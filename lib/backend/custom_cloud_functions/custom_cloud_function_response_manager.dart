import '/backend/schema/structs/index.dart';

class AddFcmTokenCloudFunctionCallResponse {
  AddFcmTokenCloudFunctionCallResponse({
    this.errorCode,
    this.succeeded,
    this.jsonBody,
  });
  String? errorCode;
  bool? succeeded;
  dynamic jsonBody;
}
