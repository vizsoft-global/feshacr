// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class OrderUserMainInfoStruct extends FFFirebaseStruct {
  OrderUserMainInfoStruct({
    String? userEmail,
    String? userId,
    String? userName,
    String? userPhone,
    String? userRole,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _userEmail = userEmail,
        _userId = userId,
        _userName = userName,
        _userPhone = userPhone,
        _userRole = userRole,
        super(firestoreUtilData);

  // "user_email" field.
  String? _userEmail;
  String get userEmail => _userEmail ?? '';
  set userEmail(String? val) => _userEmail = val;

  bool hasUserEmail() => _userEmail != null;

  // "user_id" field.
  String? _userId;
  String get userId => _userId ?? '';
  set userId(String? val) => _userId = val;

  bool hasUserId() => _userId != null;

  // "user_name" field.
  String? _userName;
  String get userName => _userName ?? '';
  set userName(String? val) => _userName = val;

  bool hasUserName() => _userName != null;

  // "user_phone" field.
  String? _userPhone;
  String get userPhone => _userPhone ?? '';
  set userPhone(String? val) => _userPhone = val;

  bool hasUserPhone() => _userPhone != null;

  // "user_role" field.
  String? _userRole;
  String get userRole => _userRole ?? '';
  set userRole(String? val) => _userRole = val;

  bool hasUserRole() => _userRole != null;

  static OrderUserMainInfoStruct fromMap(Map<String, dynamic> data) =>
      OrderUserMainInfoStruct(
        userEmail: data['user_email'] as String?,
        userId: data['user_id'] as String?,
        userName: data['user_name'] as String?,
        userPhone: data['user_phone'] as String?,
        userRole: data['user_role'] as String?,
      );

  static OrderUserMainInfoStruct? maybeFromMap(dynamic data) => data is Map
      ? OrderUserMainInfoStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'user_email': _userEmail,
        'user_id': _userId,
        'user_name': _userName,
        'user_phone': _userPhone,
        'user_role': _userRole,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'user_email': serializeParam(
          _userEmail,
          ParamType.String,
        ),
        'user_id': serializeParam(
          _userId,
          ParamType.String,
        ),
        'user_name': serializeParam(
          _userName,
          ParamType.String,
        ),
        'user_phone': serializeParam(
          _userPhone,
          ParamType.String,
        ),
        'user_role': serializeParam(
          _userRole,
          ParamType.String,
        ),
      }.withoutNulls;

  static OrderUserMainInfoStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      OrderUserMainInfoStruct(
        userEmail: deserializeParam(
          data['user_email'],
          ParamType.String,
          false,
        ),
        userId: deserializeParam(
          data['user_id'],
          ParamType.String,
          false,
        ),
        userName: deserializeParam(
          data['user_name'],
          ParamType.String,
          false,
        ),
        userPhone: deserializeParam(
          data['user_phone'],
          ParamType.String,
          false,
        ),
        userRole: deserializeParam(
          data['user_role'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'OrderUserMainInfoStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is OrderUserMainInfoStruct &&
        userEmail == other.userEmail &&
        userId == other.userId &&
        userName == other.userName &&
        userPhone == other.userPhone &&
        userRole == other.userRole;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([userEmail, userId, userName, userPhone, userRole]);
}

OrderUserMainInfoStruct createOrderUserMainInfoStruct({
  String? userEmail,
  String? userId,
  String? userName,
  String? userPhone,
  String? userRole,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    OrderUserMainInfoStruct(
      userEmail: userEmail,
      userId: userId,
      userName: userName,
      userPhone: userPhone,
      userRole: userRole,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

OrderUserMainInfoStruct? updateOrderUserMainInfoStruct(
  OrderUserMainInfoStruct? orderUserMainInfo, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    orderUserMainInfo
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addOrderUserMainInfoStructData(
  Map<String, dynamic> firestoreData,
  OrderUserMainInfoStruct? orderUserMainInfo,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (orderUserMainInfo == null) {
    return;
  }
  if (orderUserMainInfo.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && orderUserMainInfo.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final orderUserMainInfoData =
      getOrderUserMainInfoFirestoreData(orderUserMainInfo, forFieldValue);
  final nestedData =
      orderUserMainInfoData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = orderUserMainInfo.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getOrderUserMainInfoFirestoreData(
  OrderUserMainInfoStruct? orderUserMainInfo, [
  bool forFieldValue = false,
]) {
  if (orderUserMainInfo == null) {
    return {};
  }
  final firestoreData = mapToFirestore(orderUserMainInfo.toMap());

  // Add any Firestore field values
  mapToFirestore(orderUserMainInfo.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getOrderUserMainInfoListFirestoreData(
  List<OrderUserMainInfoStruct>? orderUserMainInfos,
) =>
    orderUserMainInfos
        ?.map((e) => getOrderUserMainInfoFirestoreData(e, true))
        .toList() ??
    [];
