// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SettingsCompanyInfoStruct extends FFFirebaseStruct {
  SettingsCompanyInfoStruct({
    String? companyName,
    bool? companyAppLaunchTimeStatus,
    bool? companyPointPurchaseStatus,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _companyName = companyName,
        _companyAppLaunchTimeStatus = companyAppLaunchTimeStatus,
        _companyPointPurchaseStatus = companyPointPurchaseStatus,
        super(firestoreUtilData);

  // "company_name" field.
  String? _companyName;
  String get companyName => _companyName ?? '';
  set companyName(String? val) => _companyName = val;

  bool hasCompanyName() => _companyName != null;

  // "company_app_launch_time_status" field.
  bool? _companyAppLaunchTimeStatus;
  bool get companyAppLaunchTimeStatus => _companyAppLaunchTimeStatus ?? false;
  set companyAppLaunchTimeStatus(bool? val) =>
      _companyAppLaunchTimeStatus = val;

  bool hasCompanyAppLaunchTimeStatus() => _companyAppLaunchTimeStatus != null;

  // "company_point_purchase_status" field.
  bool? _companyPointPurchaseStatus;
  bool get companyPointPurchaseStatus => _companyPointPurchaseStatus ?? false;
  set companyPointPurchaseStatus(bool? val) =>
      _companyPointPurchaseStatus = val;

  bool hasCompanyPointPurchaseStatus() => _companyPointPurchaseStatus != null;

  static SettingsCompanyInfoStruct fromMap(Map<String, dynamic> data) =>
      SettingsCompanyInfoStruct(
        companyName: data['company_name'] as String?,
        companyAppLaunchTimeStatus:
            data['company_app_launch_time_status'] as bool?,
        companyPointPurchaseStatus:
            data['company_point_purchase_status'] as bool?,
      );

  static SettingsCompanyInfoStruct? maybeFromMap(dynamic data) => data is Map
      ? SettingsCompanyInfoStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'company_name': _companyName,
        'company_app_launch_time_status': _companyAppLaunchTimeStatus,
        'company_point_purchase_status': _companyPointPurchaseStatus,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'company_name': serializeParam(
          _companyName,
          ParamType.String,
        ),
        'company_app_launch_time_status': serializeParam(
          _companyAppLaunchTimeStatus,
          ParamType.bool,
        ),
        'company_point_purchase_status': serializeParam(
          _companyPointPurchaseStatus,
          ParamType.bool,
        ),
      }.withoutNulls;

  static SettingsCompanyInfoStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      SettingsCompanyInfoStruct(
        companyName: deserializeParam(
          data['company_name'],
          ParamType.String,
          false,
        ),
        companyAppLaunchTimeStatus: deserializeParam(
          data['company_app_launch_time_status'],
          ParamType.bool,
          false,
        ),
        companyPointPurchaseStatus: deserializeParam(
          data['company_point_purchase_status'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'SettingsCompanyInfoStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is SettingsCompanyInfoStruct &&
        companyName == other.companyName &&
        companyAppLaunchTimeStatus == other.companyAppLaunchTimeStatus &&
        companyPointPurchaseStatus == other.companyPointPurchaseStatus;
  }

  @override
  int get hashCode => const ListEquality().hash(
      [companyName, companyAppLaunchTimeStatus, companyPointPurchaseStatus]);
}

SettingsCompanyInfoStruct createSettingsCompanyInfoStruct({
  String? companyName,
  bool? companyAppLaunchTimeStatus,
  bool? companyPointPurchaseStatus,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    SettingsCompanyInfoStruct(
      companyName: companyName,
      companyAppLaunchTimeStatus: companyAppLaunchTimeStatus,
      companyPointPurchaseStatus: companyPointPurchaseStatus,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

SettingsCompanyInfoStruct? updateSettingsCompanyInfoStruct(
  SettingsCompanyInfoStruct? settingsCompanyInfo, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    settingsCompanyInfo
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addSettingsCompanyInfoStructData(
  Map<String, dynamic> firestoreData,
  SettingsCompanyInfoStruct? settingsCompanyInfo,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (settingsCompanyInfo == null) {
    return;
  }
  if (settingsCompanyInfo.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && settingsCompanyInfo.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final settingsCompanyInfoData =
      getSettingsCompanyInfoFirestoreData(settingsCompanyInfo, forFieldValue);
  final nestedData =
      settingsCompanyInfoData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      settingsCompanyInfo.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getSettingsCompanyInfoFirestoreData(
  SettingsCompanyInfoStruct? settingsCompanyInfo, [
  bool forFieldValue = false,
]) {
  if (settingsCompanyInfo == null) {
    return {};
  }
  final firestoreData = mapToFirestore(settingsCompanyInfo.toMap());

  // Add any Firestore field values
  mapToFirestore(settingsCompanyInfo.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getSettingsCompanyInfoListFirestoreData(
  List<SettingsCompanyInfoStruct>? settingsCompanyInfos,
) =>
    settingsCompanyInfos
        ?.map((e) => getSettingsCompanyInfoFirestoreData(e, true))
        .toList() ??
    [];
