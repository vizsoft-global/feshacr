const functions = require("firebase-functions");
const admin = require("firebase-admin");
// To avoid deployment errors, do not call admin.initializeApp() in your code

exports.addFcmToken = functions.https.onCall(async (data, context) => {
  try {
    const uid = context.auth?.uid;
    const fcmToken = data.fcmToken;

    if (!uid) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be logged in",
      );
    }

    if (!fcmToken) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "FCM token is required",
      );
    }

    const userRef = db.collection("users").doc(uid);

    await userRef.set(
      {
        fcmTokens: admin.firestore.FieldValue.arrayUnion(fcmToken),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      },
      { merge: true },
    );

    return { success: true, message: "Token saved" };
  } catch (error) {
    console.error("saveFcmToken Error:", error);
    throw new functions.https.HttpsError("internal", error.message);
  }
});
