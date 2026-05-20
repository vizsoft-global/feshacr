// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserVerificationStruct extends FFFirebaseStruct {
  UserVerificationStruct({
    String? orderId,
    String? verificationType,
    String? verifiyIdentity,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _orderId = orderId,
        _verificationType = verificationType,
        _verifiyIdentity = verifiyIdentity,
        super(firestoreUtilData);

  // "order_id" field.
  String? _orderId;
  String get orderId => _orderId ?? '';
  set orderId(String? val) => _orderId = val;

  bool hasOrderId() => _orderId != null;

  // "verification_type" field.
  String? _verificationType;
  String get verificationType => _verificationType ?? '';
  set verificationType(String? val) => _verificationType = val;

  bool hasVerificationType() => _verificationType != null;

  // "verifiy_identity" field.
  String? _verifiyIdentity;
  String get verifiyIdentity => _verifiyIdentity ?? '';
  set verifiyIdentity(String? val) => _verifiyIdentity = val;

  bool hasVerifiyIdentity() => _verifiyIdentity != null;

  static UserVerificationStruct fromMap(Map<String, dynamic> data) =>
      UserVerificationStruct(
        orderId: data['order_id'] as String?,
        verificationType: data['verification_type'] as String?,
        verifiyIdentity: data['verifiy_identity'] as String?,
      );

  static UserVerificationStruct? maybeFromMap(dynamic data) => data is Map
      ? UserVerificationStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'order_id': _orderId,
        'verification_type': _verificationType,
        'verifiy_identity': _verifiyIdentity,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'order_id': serializeParam(
          _orderId,
          ParamType.String,
        ),
        'verification_type': serializeParam(
          _verificationType,
          ParamType.String,
        ),
        'verifiy_identity': serializeParam(
          _verifiyIdentity,
          ParamType.String,
        ),
      }.withoutNulls;

  static UserVerificationStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      UserVerificationStruct(
        orderId: deserializeParam(
          data['order_id'],
          ParamType.String,
          false,
        ),
        verificationType: deserializeParam(
          data['verification_type'],
          ParamType.String,
          false,
        ),
        verifiyIdentity: deserializeParam(
          data['verifiy_identity'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'UserVerificationStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is UserVerificationStruct &&
        orderId == other.orderId &&
        verificationType == other.verificationType &&
        verifiyIdentity == other.verifiyIdentity;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([orderId, verificationType, verifiyIdentity]);
}

UserVerificationStruct createUserVerificationStruct({
  String? orderId,
  String? verificationType,
  String? verifiyIdentity,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    UserVerificationStruct(
      orderId: orderId,
      verificationType: verificationType,
      verifiyIdentity: verifiyIdentity,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

UserVerificationStruct? updateUserVerificationStruct(
  UserVerificationStruct? userVerification, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    userVerification
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addUserVerificationStructData(
  Map<String, dynamic> firestoreData,
  UserVerificationStruct? userVerification,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (userVerification == null) {
    return;
  }
  if (userVerification.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && userVerification.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final userVerificationData =
      getUserVerificationFirestoreData(userVerification, forFieldValue);
  final nestedData =
      userVerificationData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = userVerification.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getUserVerificationFirestoreData(
  UserVerificationStruct? userVerification, [
  bool forFieldValue = false,
]) {
  if (userVerification == null) {
    return {};
  }
  final firestoreData = mapToFirestore(userVerification.toMap());

  // Add any Firestore field values
  mapToFirestore(userVerification.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getUserVerificationListFirestoreData(
  List<UserVerificationStruct>? userVerifications,
) =>
    userVerifications
        ?.map((e) => getUserVerificationFirestoreData(e, true))
        .toList() ??
    [];
