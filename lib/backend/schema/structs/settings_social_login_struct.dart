// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SettingsSocialLoginStruct extends FFFirebaseStruct {
  SettingsSocialLoginStruct({
    bool? appleLogin,
    bool? facebookLogin,
    bool? googleLogin,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _appleLogin = appleLogin,
        _facebookLogin = facebookLogin,
        _googleLogin = googleLogin,
        super(firestoreUtilData);

  // "apple_login" field.
  bool? _appleLogin;
  bool get appleLogin => _appleLogin ?? false;
  set appleLogin(bool? val) => _appleLogin = val;

  bool hasAppleLogin() => _appleLogin != null;

  // "facebook_login" field.
  bool? _facebookLogin;
  bool get facebookLogin => _facebookLogin ?? false;
  set facebookLogin(bool? val) => _facebookLogin = val;

  bool hasFacebookLogin() => _facebookLogin != null;

  // "google_login" field.
  bool? _googleLogin;
  bool get googleLogin => _googleLogin ?? false;
  set googleLogin(bool? val) => _googleLogin = val;

  bool hasGoogleLogin() => _googleLogin != null;

  static SettingsSocialLoginStruct fromMap(Map<String, dynamic> data) =>
      SettingsSocialLoginStruct(
        appleLogin: data['apple_login'] as bool?,
        facebookLogin: data['facebook_login'] as bool?,
        googleLogin: data['google_login'] as bool?,
      );

  static SettingsSocialLoginStruct? maybeFromMap(dynamic data) => data is Map
      ? SettingsSocialLoginStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'apple_login': _appleLogin,
        'facebook_login': _facebookLogin,
        'google_login': _googleLogin,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'apple_login': serializeParam(
          _appleLogin,
          ParamType.bool,
        ),
        'facebook_login': serializeParam(
          _facebookLogin,
          ParamType.bool,
        ),
        'google_login': serializeParam(
          _googleLogin,
          ParamType.bool,
        ),
      }.withoutNulls;

  static SettingsSocialLoginStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      SettingsSocialLoginStruct(
        appleLogin: deserializeParam(
          data['apple_login'],
          ParamType.bool,
          false,
        ),
        facebookLogin: deserializeParam(
          data['facebook_login'],
          ParamType.bool,
          false,
        ),
        googleLogin: deserializeParam(
          data['google_login'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'SettingsSocialLoginStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is SettingsSocialLoginStruct &&
        appleLogin == other.appleLogin &&
        facebookLogin == other.facebookLogin &&
        googleLogin == other.googleLogin;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([appleLogin, facebookLogin, googleLogin]);
}

SettingsSocialLoginStruct createSettingsSocialLoginStruct({
  bool? appleLogin,
  bool? facebookLogin,
  bool? googleLogin,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    SettingsSocialLoginStruct(
      appleLogin: appleLogin,
      facebookLogin: facebookLogin,
      googleLogin: googleLogin,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

SettingsSocialLoginStruct? updateSettingsSocialLoginStruct(
  SettingsSocialLoginStruct? settingsSocialLogin, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    settingsSocialLogin
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addSettingsSocialLoginStructData(
  Map<String, dynamic> firestoreData,
  SettingsSocialLoginStruct? settingsSocialLogin,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (settingsSocialLogin == null) {
    return;
  }
  if (settingsSocialLogin.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && settingsSocialLogin.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final settingsSocialLoginData =
      getSettingsSocialLoginFirestoreData(settingsSocialLogin, forFieldValue);
  final nestedData =
      settingsSocialLoginData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      settingsSocialLogin.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getSettingsSocialLoginFirestoreData(
  SettingsSocialLoginStruct? settingsSocialLogin, [
  bool forFieldValue = false,
]) {
  if (settingsSocialLogin == null) {
    return {};
  }
  final firestoreData = mapToFirestore(settingsSocialLogin.toMap());

  // Add any Firestore field values
  mapToFirestore(settingsSocialLogin.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getSettingsSocialLoginListFirestoreData(
  List<SettingsSocialLoginStruct>? settingsSocialLogins,
) =>
    settingsSocialLogins
        ?.map((e) => getSettingsSocialLoginFirestoreData(e, true))
        .toList() ??
    [];
