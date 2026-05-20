// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserSettingStruct extends FFFirebaseStruct {
  UserSettingStruct({
    bool? isOfferstatus,
    bool? isNewsletterstatus,
    bool? isNotificationstatus,
    bool? isSoundstatus,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _isOfferstatus = isOfferstatus,
        _isNewsletterstatus = isNewsletterstatus,
        _isNotificationstatus = isNotificationstatus,
        _isSoundstatus = isSoundstatus,
        super(firestoreUtilData);

  // "is_offerstatus" field.
  bool? _isOfferstatus;
  bool get isOfferstatus => _isOfferstatus ?? false;
  set isOfferstatus(bool? val) => _isOfferstatus = val;

  bool hasIsOfferstatus() => _isOfferstatus != null;

  // "is_newsletterstatus" field.
  bool? _isNewsletterstatus;
  bool get isNewsletterstatus => _isNewsletterstatus ?? false;
  set isNewsletterstatus(bool? val) => _isNewsletterstatus = val;

  bool hasIsNewsletterstatus() => _isNewsletterstatus != null;

  // "is_notificationstatus" field.
  bool? _isNotificationstatus;
  bool get isNotificationstatus => _isNotificationstatus ?? true;
  set isNotificationstatus(bool? val) => _isNotificationstatus = val;

  bool hasIsNotificationstatus() => _isNotificationstatus != null;

  // "is_soundstatus" field.
  bool? _isSoundstatus;
  bool get isSoundstatus => _isSoundstatus ?? true;
  set isSoundstatus(bool? val) => _isSoundstatus = val;

  bool hasIsSoundstatus() => _isSoundstatus != null;

  static UserSettingStruct fromMap(Map<String, dynamic> data) =>
      UserSettingStruct(
        isOfferstatus: data['is_offerstatus'] as bool?,
        isNewsletterstatus: data['is_newsletterstatus'] as bool?,
        isNotificationstatus: data['is_notificationstatus'] as bool?,
        isSoundstatus: data['is_soundstatus'] as bool?,
      );

  static UserSettingStruct? maybeFromMap(dynamic data) => data is Map
      ? UserSettingStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'is_offerstatus': _isOfferstatus,
        'is_newsletterstatus': _isNewsletterstatus,
        'is_notificationstatus': _isNotificationstatus,
        'is_soundstatus': _isSoundstatus,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'is_offerstatus': serializeParam(
          _isOfferstatus,
          ParamType.bool,
        ),
        'is_newsletterstatus': serializeParam(
          _isNewsletterstatus,
          ParamType.bool,
        ),
        'is_notificationstatus': serializeParam(
          _isNotificationstatus,
          ParamType.bool,
        ),
        'is_soundstatus': serializeParam(
          _isSoundstatus,
          ParamType.bool,
        ),
      }.withoutNulls;

  static UserSettingStruct fromSerializableMap(Map<String, dynamic> data) =>
      UserSettingStruct(
        isOfferstatus: deserializeParam(
          data['is_offerstatus'],
          ParamType.bool,
          false,
        ),
        isNewsletterstatus: deserializeParam(
          data['is_newsletterstatus'],
          ParamType.bool,
          false,
        ),
        isNotificationstatus: deserializeParam(
          data['is_notificationstatus'],
          ParamType.bool,
          false,
        ),
        isSoundstatus: deserializeParam(
          data['is_soundstatus'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'UserSettingStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is UserSettingStruct &&
        isOfferstatus == other.isOfferstatus &&
        isNewsletterstatus == other.isNewsletterstatus &&
        isNotificationstatus == other.isNotificationstatus &&
        isSoundstatus == other.isSoundstatus;
  }

  @override
  int get hashCode => const ListEquality().hash(
      [isOfferstatus, isNewsletterstatus, isNotificationstatus, isSoundstatus]);
}

UserSettingStruct createUserSettingStruct({
  bool? isOfferstatus,
  bool? isNewsletterstatus,
  bool? isNotificationstatus,
  bool? isSoundstatus,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    UserSettingStruct(
      isOfferstatus: isOfferstatus,
      isNewsletterstatus: isNewsletterstatus,
      isNotificationstatus: isNotificationstatus,
      isSoundstatus: isSoundstatus,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

UserSettingStruct? updateUserSettingStruct(
  UserSettingStruct? userSetting, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    userSetting
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addUserSettingStructData(
  Map<String, dynamic> firestoreData,
  UserSettingStruct? userSetting,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (userSetting == null) {
    return;
  }
  if (userSetting.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && userSetting.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final userSettingData =
      getUserSettingFirestoreData(userSetting, forFieldValue);
  final nestedData =
      userSettingData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = userSetting.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getUserSettingFirestoreData(
  UserSettingStruct? userSetting, [
  bool forFieldValue = false,
]) {
  if (userSetting == null) {
    return {};
  }
  final firestoreData = mapToFirestore(userSetting.toMap());

  // Add any Firestore field values
  mapToFirestore(userSetting.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getUserSettingListFirestoreData(
  List<UserSettingStruct>? userSettings,
) =>
    userSettings?.map((e) => getUserSettingFirestoreData(e, true)).toList() ??
    [];
