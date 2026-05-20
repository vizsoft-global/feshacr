const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

const kFcmTokensCollection = "fcm_tokens";
const kPushNotificationsCollection = "ff_push_notifications";
const firestore = admin.firestore();

const kPushNotificationRuntimeOpts = {
  timeoutSeconds: 540,
  memory: "2GB",
};

exports.addFcmToken = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    return "Failed: Unauthenticated calls are not allowed.";
  }
  const userDocPath = data.userDocPath;
  const fcmToken = data.fcmToken;
  const deviceType = data.deviceType;
  if (
    typeof userDocPath === "undefined" ||
    typeof fcmToken === "undefined" ||
    typeof deviceType === "undefined" ||
    userDocPath.split("/").length <= 1 ||
    fcmToken.length === 0 ||
    deviceType.length === 0
  ) {
    return "Invalid arguments encoutered when adding FCM token.";
  }
  if (context.auth.uid != userDocPath.split("/")[1]) {
    return "Failed: Authenticated user doesn't match user provided.";
  }
  const existingTokens = await firestore
    .collectionGroup(kFcmTokensCollection)
    .where("fcm_token", "==", fcmToken)
    .get();
  var userAlreadyHasToken = false;
  for (var doc of existingTokens.docs) {
    const user = doc.ref.parent.parent;
    if (user.path != userDocPath) {
      // Should never have the same FCM token associated with multiple users.
      await doc.ref.delete();
    } else {
      userAlreadyHasToken = true;
    }
  }
  if (userAlreadyHasToken) {
    return "FCM token already exists for this user. Ignoring...";
  }
  await getUserFcmTokensCollection(userDocPath).doc().set({
    fcm_token: fcmToken,
    device_type: deviceType,
    created_at: admin.firestore.FieldValue.serverTimestamp(),
  });
  return "Successfully added FCM token!";
});

exports.sendPushNotificationsTrigger = functions
  .runWith(kPushNotificationRuntimeOpts)
  .firestore.document(`${kPushNotificationsCollection}/{id}`)
  .onCreate(async (snapshot, _) => {
    try {
      // Ignore scheduled push notifications on create
      const scheduledTime = snapshot.data().scheduled_time || "";
      if (scheduledTime) {
        return;
      }

      await sendPushNotifications(snapshot);
    } catch (e) {
      console.log(`Error: ${e}`);
      await snapshot.ref.update({ status: "failed", error: `${e}` });
    }
  });

async function sendPushNotifications(snapshot) {
  const notificationData = snapshot.data();
  const title = notificationData.notification_title || "";
  const body = notificationData.notification_text || "";
  const imageUrl = notificationData.notification_image_url || "";
  const sound = notificationData.notification_sound || "";
  const parameterData = notificationData.parameter_data || "";
  const targetAudience = notificationData.target_audience || "";
  const initialPageName = notificationData.initial_page_name || "";
  const userRefsStr = notificationData.user_refs || "";
  const batchIndex = notificationData.batch_index || 0;
  const numBatches = notificationData.num_batches || 0;
  const status = notificationData.status || "";

  if (status !== "" && status !== "started") {
    console.log(`Already processed ${snapshot.ref.path}. Skipping...`);
    return;
  }

  if (title === "" || body === "") {
    await snapshot.ref.update({ status: "failed" });
    return;
  }

  const userRefs = userRefsStr === "" ? [] : userRefsStr.trim().split(",");
  var tokens = new Set();
  if (userRefsStr) {
    for (var userRef of userRefs) {
      const userTokens = await firestore
        .doc(userRef)
        .collection(kFcmTokensCollection)
        .get();
      userTokens.docs.forEach((token) => {
        if (typeof token.data().fcm_token !== undefined) {
          tokens.add(token.data().fcm_token);
        }
      });
    }
  } else {
    var userTokensQuery = firestore.collectionGroup(kFcmTokensCollection);
    // Handle batched push notifications by splitting tokens up by document
    // id.
    if (numBatches > 0) {
      userTokensQuery = userTokensQuery
        .orderBy(admin.firestore.FieldPath.documentId())
        .startAt(getDocIdBound(batchIndex, numBatches))
        .endBefore(getDocIdBound(batchIndex + 1, numBatches));
    }
    const userTokens = await userTokensQuery.get();
    userTokens.docs.forEach((token) => {
      const data = token.data();
      const audienceMatches =
        targetAudience === "All" || data.device_type === targetAudience;
      if (audienceMatches && typeof data.fcm_token !== undefined) {
        tokens.add(data.fcm_token);
      }
    });
  }

  const tokensArr = Array.from(tokens);
  var messageBatches = [];
  for (let i = 0; i < tokensArr.length; i += 500) {
    const tokensBatch = tokensArr.slice(i, Math.min(i + 500, tokensArr.length));
    const messages = {
      notification: {
        title,
        body,
        ...(imageUrl && { imageUrl: imageUrl }),
      },
      data: {
        initialPageName,
        parameterData,
      },
      android: {
        notification: {
          ...(sound && { sound: sound }),
        },
      },
      apns: {
        payload: {
          aps: {
            ...(sound && { sound: sound }),
          },
        },
      },
      tokens: tokensBatch,
    };
    messageBatches.push(messages);
  }

  var numSent = 0;
  await Promise.all(
    messageBatches.map(async (messages) => {
      const response = await admin.messaging().sendEachForMulticast(messages);
      numSent += response.successCount;
    }),
  );

  await snapshot.ref.update({ status: "succeeded", num_sent: numSent });
}

function getUserFcmTokensCollection(userDocPath) {
  return firestore.doc(userDocPath).collection(kFcmTokensCollection);
}

function getDocIdBound(index, numBatches) {
  if (index <= 0) {
    return "users/(";
  }
  if (index >= numBatches) {
    return "users/}";
  }
  const numUidChars = 62;
  const twoCharOptions = Math.pow(numUidChars, 2);

  var twoCharIdx = (index * twoCharOptions) / numBatches;
  var firstCharIdx = Math.floor(twoCharIdx / numUidChars);
  var secondCharIdx = Math.floor(twoCharIdx % numUidChars);
  const firstChar = getCharForIndex(firstCharIdx);
  const secondChar = getCharForIndex(secondCharIdx);
  return "users/" + firstChar + secondChar;
}

function getCharForIndex(charIdx) {
  if (charIdx < 10) {
    return String.fromCharCode(charIdx + "0".charCodeAt(0));
  } else if (charIdx < 36) {
    return String.fromCharCode("A".charCodeAt(0) + charIdx - 10);
  } else {
    return String.fromCharCode("a".charCodeAt(0) + charIdx - 36);
  }
}

const VALID_EDGE_HINTS = new Set([
  "wnam",
  "enam",
  "sam",
  "weur",
  "eeur",
  "apac",
  "oc",
  "afr",
  "me",
]);

/**
 * Shared Hot Potato arena checks for `getHotPotatoEdgeToken` and `getLiveKitVoiceToken`.
 *
 * LiveKit: set credentials before deploy:
 *   firebase functions:config:set livekit.url="wss://YOUR-PROJECT.livekit.cloud" \
 *     livekit.api_key="APIxxxxx" livekit.api_secret="xxxxxxxx"
 * Or env vars LIVEKIT_URL, LIVEKIT_API_KEY, LIVEKIT_API_SECRET (e.g. CI / Secret Manager).
 */

/** @returns {Promise<FirebaseFirestore.DocumentData>} */
async function assertHotPotatoArenaParticipant(roomId, participantPath, uid) {
  if (!roomId || typeof roomId !== "string" || roomId.length < 4) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "roomId required.",
    );
  }
  if (
    !participantPath ||
    typeof participantPath !== "string" ||
    !participantPath.startsWith("users/")
  ) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "participantPath required.",
    );
  }
  if (
    !participantPath.endsWith(uid) &&
    participantPath !== `users/${uid}`
  ) {
    const suffix = participantPath.split("/").pop();
    if (suffix !== uid) {
      throw new functions.https.HttpsError(
        "permission-denied",
        "participantPath must match auth user.",
      );
    }
  }

  const roomSnap = await firestore.collection("room").doc(roomId).get();
  if (!roomSnap.exists) {
    throw new functions.https.HttpsError("not-found", "Room not found.");
  }
  const roomData = roomSnap.data() || {};
  const hpSettings = roomData.hot_potato_settings || {};
  if (hpSettings.state !== "arena") {
    throw new functions.https.HttpsError(
      "failed-precondition",
      "Match not in arena.",
    );
  }

  const live = roomData.hot_potato_live || {};
  const paths = live.participant_paths || [];
  const ghosts = live.ghost_paths || [];
  const allowed =
    paths.includes(participantPath) || ghosts.includes(participantPath);
  if (!allowed) {
    throw new functions.https.HttpsError(
      "permission-denied",
      "Not a participant in this match.",
    );
  }

  return roomData;
}

function base64UrlEncode(input) {
  return Buffer.from(input)
    .toString("base64")
    .replace(/\+/g, "-")
    .replace(/\//g, "_")
    .replace(/=+$/g, "");
}

function signHotPotatoJwt(payload, secret) {
  const header = base64UrlEncode(JSON.stringify({ alg: "HS256", typ: "JWT" }));
  const body = base64UrlEncode(JSON.stringify(payload));
  const sig = require("crypto")
    .createHmac("sha256", secret)
    .update(`${header}.${body}`)
    .digest("base64")
    .replace(/\+/g, "-")
    .replace(/\//g, "_")
    .replace(/=+$/g, "");
  return `${header}.${body}.${sig}`;
}

exports.getHotPotatoEdgeToken = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "Must be signed in.",
    );
  }
  const roomId = data.roomId;
  const participantPath = data.participantPath;
  const uid = context.auth.uid;

  const roomData = await assertHotPotatoArenaParticipant(
    roomId,
    participantPath,
    uid,
  );
  const hpSettings = roomData.hot_potato_settings || {};
  if (hpSettings.edge_realtime !== true) {
    throw new functions.https.HttpsError(
      "failed-precondition",
      "Edge realtime not enabled for this room.",
    );
  }

  let edgeHint = hpSettings.edge_location_hint || "apac";
  if (!VALID_EDGE_HINTS.has(edgeHint)) edgeHint = "apac";

  const secret =
    functions.config().hot_potato?.jwt_secret ||
    process.env.HOT_POTATO_JWT_SECRET;
  if (!secret) {
    throw new functions.https.HttpsError(
      "failed-precondition",
      "JWT secret not configured.",
    );
  }

  const workerUrl =
    hpSettings.edge_worker_url ||
    functions.config().hot_potato?.worker_url ||
    "https://hot-potato-room.domain-772.workers.dev";

  const exp = Math.floor(Date.now() / 1000) + 120;
  const token = signHotPotatoJwt(
    {
      roomId,
      uid,
      path: participantPath,
      edgeLocationHint: edgeHint,
      exp,
    },
    secret,
  );

  return {
    token,
    roomId,
    edgeLocationHint: edgeHint,
    workerUrl,
    exp,
  };
});

exports.getLiveKitVoiceToken = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "Must be signed in.",
    );
  }
  const roomId = data.roomId;
  const participantPath = data.participantPath;
  const uid = context.auth.uid;

  await assertHotPotatoArenaParticipant(roomId, participantPath, uid);

  const lkUrl =
    functions.config().livekit?.url ||
    process.env.LIVEKIT_URL ||
    "";
  const lkKey =
    functions.config().livekit?.api_key ||
    process.env.LIVEKIT_API_KEY ||
    "";
  const lkSecret =
    functions.config().livekit?.api_secret ||
    process.env.LIVEKIT_API_SECRET ||
    "";
  if (!lkUrl || !lkKey || !lkSecret) {
    throw new functions.https.HttpsError(
      "failed-precondition",
      "LiveKit is not configured (livekit.url, livekit.api_key, livekit.api_secret).",
    );
  }

  // LiveKit room names: keep short and URL-safe.
  const roomName = `hp-voice-${roomId}`
    .replace(/[^a-zA-Z0-9_-]/g, "-")
    .slice(0, 64);

  const { AccessToken } = require("livekit-server-sdk");
  const at = new AccessToken(lkKey, lkSecret, {
    identity: uid,
    name: participantPath,
    ttl: "15m",
  });
  at.addGrant({
    roomJoin: true,
    room: roomName,
    canPublish: true,
    canSubscribe: true,
  });
  const token = await at.toJwt();

  return {
    url: lkUrl,
    token,
    roomName,
  };
});

exports.onUserDeleted = functions.auth.user().onDelete(async (user) => {
  let firestore = admin.firestore();
  let userRef = firestore.doc("users/" + user.uid);
  await firestore.collection("users").doc(user.uid).delete();
});
