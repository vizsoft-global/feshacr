const admin = require("firebase-admin/app");
admin.initializeApp();

const addFcmToken = require("./add_fcm_token.js");
exports.addFcmToken = addFcmToken.addFcmToken;
