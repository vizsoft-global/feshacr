// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SettingsAppVersionInfoStruct extends FFFirebaseStruct {
  SettingsAppVersionInfoStruct({
    String? androidVersionString,
    int? androidVersionInt,
    DateTime? androidVersionReleaseDate,
    String? iosVersionString,
    int? iosVersionInt,
    DateTime? iosVersionReleaseDate,
    String? changelog,
    bool? dismissibleStatus,
    String? appMenuBarImage,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _androidVersionString = androidVersionString,
        _androidVersionInt = androidVersionInt,
        _androidVersionReleaseDate = androidVersionReleaseDate,
        _iosVersionString = iosVersionString,
        _iosVersionInt = iosVersionInt,
        _iosVersionReleaseDate = iosVersionReleaseDate,
        _changelog = changelog,
        _dismissibleStatus = dismissibleStatus,
        _appMenuBarImage = appMenuBarImage,
        super(firestoreUtilData);

  // "android_version_string" field.
  String? _androidVersionString;
  String get androidVersionString => _androidVersionString ?? '';
  set androidVersionString(String? val) => _androidVersionString = val;

  bool hasAndroidVersionString() => _androidVersionString != null;

  // "android_version_int" field.
  int? _androidVersionInt;
  int get androidVersionInt => _androidVersionInt ?? 0;
  set androidVersionInt(int? val) => _androidVersionInt = val;

  void incrementAndroidVersionInt(int amount) =>
      androidVersionInt = androidVersionInt + amount;

  bool hasAndroidVersionInt() => _androidVersionInt != null;

  // "android_version_release_date" field.
  DateTime? _androidVersionReleaseDate;
  DateTime? get androidVersionReleaseDate => _androidVersionReleaseDate;
  set androidVersionReleaseDate(DateTime? val) =>
      _androidVersionReleaseDate = val;

  bool hasAndroidVersionReleaseDate() => _androidVersionReleaseDate != null;

  // "ios_version_string" field.
  String? _iosVersionString;
  String get iosVersionString => _iosVersionString ?? '';
  set iosVersionString(String? val) => _iosVersionString = val;

  bool hasIosVersionString() => _iosVersionString != null;

  // "ios_version_int" field.
  int? _iosVersionInt;
  int get iosVersionInt => _iosVersionInt ?? 0;
  set iosVersionInt(int? val) => _iosVersionInt = val;

  void incrementIosVersionInt(int amount) =>
      iosVersionInt = iosVersionInt + amount;

  bool hasIosVersionInt() => _iosVersionInt != null;

  // "ios_version_release_date" field.
  DateTime? _iosVersionReleaseDate;
  DateTime? get iosVersionReleaseDate => _iosVersionReleaseDate;
  set iosVersionReleaseDate(DateTime? val) => _iosVersionReleaseDate = val;

  bool hasIosVersionReleaseDate() => _iosVersionReleaseDate != null;

  // "changelog" field.
  String? _changelog;
  String get changelog => _changelog ?? '';
  set changelog(String? val) => _changelog = val;

  bool hasChangelog() => _changelog != null;

  // "dismissible_status" field.
  bool? _dismissibleStatus;
  bool get dismissibleStatus => _dismissibleStatus ?? false;
  set dismissibleStatus(bool? val) => _dismissibleStatus = val;

  bool hasDismissibleStatus() => _dismissibleStatus != null;

  // "app_menu_bar_image" field.
  String? _appMenuBarImage;
  String get appMenuBarImage => _appMenuBarImage ?? '';
  set appMenuBarImage(String? val) => _appMenuBarImage = val;

  bool hasAppMenuBarImage() => _appMenuBarImage != null;

  static SettingsAppVersionInfoStruct fromMap(Map<String, dynamic> data) =>
      SettingsAppVersionInfoStruct(
        androidVersionString: data['android_version_string'] as String?,
        androidVersionInt: castToType<int>(data['android_version_int']),
        androidVersionReleaseDate:
            data['android_version_release_date'] as DateTime?,
        iosVersionString: data['ios_version_string'] as String?,
        iosVersionInt: castToType<int>(data['ios_version_int']),
        iosVersionReleaseDate: data['ios_version_release_date'] as DateTime?,
        changelog: data['changelog'] as String?,
        dismissibleStatus: data['dismissible_status'] as bool?,
        appMenuBarImage: data['app_menu_bar_image'] as String?,
      );

  static SettingsAppVersionInfoStruct? maybeFromMap(dynamic data) => data is Map
      ? SettingsAppVersionInfoStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'android_version_string': _androidVersionString,
        'android_version_int': _androidVersionInt,
        'android_version_release_date': _androidVersionReleaseDate,
        'ios_version_string': _iosVersionString,
        'ios_version_int': _iosVersionInt,
        'ios_version_release_date': _iosVersionReleaseDate,
        'changelog': _changelog,
        'dismissible_status': _dismissibleStatus,
        'app_menu_bar_image': _appMenuBarImage,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'android_version_string': serializeParam(
          _androidVersionString,
          ParamType.String,
        ),
        'android_version_int': serializeParam(
          _androidVersionInt,
          ParamType.int,
        ),
        'android_version_release_date': serializeParam(
          _androidVersionReleaseDate,
          ParamType.DateTime,
        ),
        'ios_version_string': serializeParam(
          _iosVersionString,
          ParamType.String,
        ),
        'ios_version_int': serializeParam(
          _iosVersionInt,
          ParamType.int,
        ),
        'ios_version_release_date': serializeParam(
          _iosVersionReleaseDate,
          ParamType.DateTime,
        ),
        'changelog': serializeParam(
          _changelog,
          ParamType.String,
        ),
        'dismissible_status': serializeParam(
          _dismissibleStatus,
          ParamType.bool,
        ),
        'app_menu_bar_image': serializeParam(
          _appMenuBarImage,
          ParamType.String,
        ),
      }.withoutNulls;

  static SettingsAppVersionInfoStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      SettingsAppVersionInfoStruct(
        androidVersionString: deserializeParam(
          data['android_version_string'],
          ParamType.String,
          false,
        ),
        androidVersionInt: deserializeParam(
          data['android_version_int'],
          ParamType.int,
          false,
        ),
        androidVersionReleaseDate: deserializeParam(
          data['android_version_release_date'],
          ParamType.DateTime,
          false,
        ),
        iosVersionString: deserializeParam(
          data['ios_version_string'],
          ParamType.String,
          false,
        ),
        iosVersionInt: deserializeParam(
          data['ios_version_int'],
          ParamType.int,
          false,
        ),
        iosVersionReleaseDate: deserializeParam(
          data['ios_version_release_date'],
          ParamType.DateTime,
          false,
        ),
        changelog: deserializeParam(
          data['changelog'],
          ParamType.String,
          false,
        ),
        dismissibleStatus: deserializeParam(
          data['dismissible_status'],
          ParamType.bool,
          false,
        ),
        appMenuBarImage: deserializeParam(
          data['app_menu_bar_image'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'SettingsAppVersionInfoStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is SettingsAppVersionInfoStruct &&
        androidVersionString == other.androidVersionString &&
        androidVersionInt == other.androidVersionInt &&
        androidVersionReleaseDate == other.androidVersionReleaseDate &&
        iosVersionString == other.iosVersionString &&
        iosVersionInt == other.iosVersionInt &&
        iosVersionReleaseDate == other.iosVersionReleaseDate &&
        changelog == other.changelog &&
        dismissibleStatus == other.dismissibleStatus &&
        appMenuBarImage == other.appMenuBarImage;
  }

  @override
  int get hashCode => const ListEquality().hash([
        androidVersionString,
        androidVersionInt,
        androidVersionReleaseDate,
        iosVersionString,
        iosVersionInt,
        iosVersionReleaseDate,
        changelog,
        dismissibleStatus,
        appMenuBarImage
      ]);
}

SettingsAppVersionInfoStruct createSettingsAppVersionInfoStruct({
  String? androidVersionString,
  int? androidVersionInt,
  DateTime? androidVersionReleaseDate,
  String? iosVersionString,
  int? iosVersionInt,
  DateTime? iosVersionReleaseDate,
  String? changelog,
  bool? dismissibleStatus,
  String? appMenuBarImage,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    SettingsAppVersionInfoStruct(
      androidVersionString: androidVersionString,
      androidVersionInt: androidVersionInt,
      androidVersionReleaseDate: androidVersionReleaseDate,
      iosVersionString: iosVersionString,
      iosVersionInt: iosVersionInt,
      iosVersionReleaseDate: iosVersionReleaseDate,
      changelog: changelog,
      dismissibleStatus: dismissibleStatus,
      appMenuBarImage: appMenuBarImage,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

SettingsAppVersionInfoStruct? updateSettingsAppVersionInfoStruct(
  SettingsAppVersionInfoStruct? settingsAppVersionInfo, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    settingsAppVersionInfo
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addSettingsAppVersionInfoStructData(
  Map<String, dynamic> firestoreData,
  SettingsAppVersionInfoStruct? settingsAppVersionInfo,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (settingsAppVersionInfo == null) {
    return;
  }
  if (settingsAppVersionInfo.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields = !forFieldValue &&
      settingsAppVersionInfo.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final settingsAppVersionInfoData = getSettingsAppVersionInfoFirestoreData(
      settingsAppVersionInfo, forFieldValue);
  final nestedData =
      settingsAppVersionInfoData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      settingsAppVersionInfo.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getSettingsAppVersionInfoFirestoreData(
  SettingsAppVersionInfoStruct? settingsAppVersionInfo, [
  bool forFieldValue = false,
]) {
  if (settingsAppVersionInfo == null) {
    return {};
  }
  final firestoreData = mapToFirestore(settingsAppVersionInfo.toMap());

  // Add any Firestore field values
  mapToFirestore(settingsAppVersionInfo.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getSettingsAppVersionInfoListFirestoreData(
  List<SettingsAppVersionInfoStruct>? settingsAppVersionInfos,
) =>
    settingsAppVersionInfos
        ?.map((e) => getSettingsAppVersionInfoFirestoreData(e, true))
        .toList() ??
    [];
