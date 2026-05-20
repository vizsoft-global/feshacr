import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SettingsRecord extends FirestoreRecord {
  SettingsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  bool hasType() => _type != null;

  // "settings_payment_info" field.
  List<SettingsPaymentInfoStruct>? _settingsPaymentInfo;
  List<SettingsPaymentInfoStruct> get settingsPaymentInfo =>
      _settingsPaymentInfo ?? const [];
  bool hasSettingsPaymentInfo() => _settingsPaymentInfo != null;

  // "settings_app_version_info" field.
  SettingsAppVersionInfoStruct? _settingsAppVersionInfo;
  SettingsAppVersionInfoStruct get settingsAppVersionInfo =>
      _settingsAppVersionInfo ?? SettingsAppVersionInfoStruct();
  bool hasSettingsAppVersionInfo() => _settingsAppVersionInfo != null;

  // "settings_company_info" field.
  SettingsCompanyInfoStruct? _settingsCompanyInfo;
  SettingsCompanyInfoStruct get settingsCompanyInfo =>
      _settingsCompanyInfo ?? SettingsCompanyInfoStruct();
  bool hasSettingsCompanyInfo() => _settingsCompanyInfo != null;

  // "settings_inapp_purchase_status" field.
  bool? _settingsInappPurchaseStatus;
  bool get settingsInappPurchaseStatus => _settingsInappPurchaseStatus ?? false;
  bool hasSettingsInappPurchaseStatus() => _settingsInappPurchaseStatus != null;

  // "settings_social_login" field.
  SettingsSocialLoginStruct? _settingsSocialLogin;
  SettingsSocialLoginStruct get settingsSocialLogin =>
      _settingsSocialLogin ?? SettingsSocialLoginStruct();
  bool hasSettingsSocialLogin() => _settingsSocialLogin != null;

  // "settings_sponsor_info" field.
  List<MainInfoStruct>? _settingsSponsorInfo;
  List<MainInfoStruct> get settingsSponsorInfo =>
      _settingsSponsorInfo ?? const [];
  bool hasSettingsSponsorInfo() => _settingsSponsorInfo != null;

  // "settings_otpless" field.
  bool? _settingsOtpless;
  bool get settingsOtpless => _settingsOtpless ?? false;
  bool hasSettingsOtpless() => _settingsOtpless != null;

  // "settings_new_reg_coins" field.
  int? _settingsNewRegCoins;
  int get settingsNewRegCoins => _settingsNewRegCoins ?? 0;
  bool hasSettingsNewRegCoins() => _settingsNewRegCoins != null;

  // "settings_new_room_coins" field.
  int? _settingsNewRoomCoins;
  int get settingsNewRoomCoins => _settingsNewRoomCoins ?? 0;
  bool hasSettingsNewRoomCoins() => _settingsNewRoomCoins != null;

  void _initializeFields() {
    _type = snapshotData['type'] as String?;
    _settingsPaymentInfo = getStructList(
      snapshotData['settings_payment_info'],
      SettingsPaymentInfoStruct.fromMap,
    );
    _settingsAppVersionInfo = snapshotData['settings_app_version_info']
            is SettingsAppVersionInfoStruct
        ? snapshotData['settings_app_version_info']
        : SettingsAppVersionInfoStruct.maybeFromMap(
            snapshotData['settings_app_version_info']);
    _settingsCompanyInfo =
        snapshotData['settings_company_info'] is SettingsCompanyInfoStruct
            ? snapshotData['settings_company_info']
            : SettingsCompanyInfoStruct.maybeFromMap(
                snapshotData['settings_company_info']);
    _settingsInappPurchaseStatus =
        snapshotData['settings_inapp_purchase_status'] as bool?;
    _settingsSocialLogin =
        snapshotData['settings_social_login'] is SettingsSocialLoginStruct
            ? snapshotData['settings_social_login']
            : SettingsSocialLoginStruct.maybeFromMap(
                snapshotData['settings_social_login']);
    _settingsSponsorInfo = getStructList(
      snapshotData['settings_sponsor_info'],
      MainInfoStruct.fromMap,
    );
    _settingsOtpless = snapshotData['settings_otpless'] as bool?;
    _settingsNewRegCoins =
        castToType<int>(snapshotData['settings_new_reg_coins']);
    _settingsNewRoomCoins =
        castToType<int>(snapshotData['settings_new_room_coins']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('settings');

  static Stream<SettingsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => SettingsRecord.fromSnapshot(s));

  static Future<SettingsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => SettingsRecord.fromSnapshot(s));

  static SettingsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      SettingsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static SettingsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      SettingsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'SettingsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is SettingsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createSettingsRecordData({
  String? type,
  SettingsAppVersionInfoStruct? settingsAppVersionInfo,
  SettingsCompanyInfoStruct? settingsCompanyInfo,
  bool? settingsInappPurchaseStatus,
  SettingsSocialLoginStruct? settingsSocialLogin,
  bool? settingsOtpless,
  int? settingsNewRegCoins,
  int? settingsNewRoomCoins,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'type': type,
      'settings_app_version_info': SettingsAppVersionInfoStruct().toMap(),
      'settings_company_info': SettingsCompanyInfoStruct().toMap(),
      'settings_inapp_purchase_status': settingsInappPurchaseStatus,
      'settings_social_login': SettingsSocialLoginStruct().toMap(),
      'settings_otpless': settingsOtpless,
      'settings_new_reg_coins': settingsNewRegCoins,
      'settings_new_room_coins': settingsNewRoomCoins,
    }.withoutNulls,
  );

  // Handle nested data for "settings_app_version_info" field.
  addSettingsAppVersionInfoStructData(
      firestoreData, settingsAppVersionInfo, 'settings_app_version_info');

  // Handle nested data for "settings_company_info" field.
  addSettingsCompanyInfoStructData(
      firestoreData, settingsCompanyInfo, 'settings_company_info');

  // Handle nested data for "settings_social_login" field.
  addSettingsSocialLoginStructData(
      firestoreData, settingsSocialLogin, 'settings_social_login');

  return firestoreData;
}

class SettingsRecordDocumentEquality implements Equality<SettingsRecord> {
  const SettingsRecordDocumentEquality();

  @override
  bool equals(SettingsRecord? e1, SettingsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.type == e2?.type &&
        listEquality.equals(e1?.settingsPaymentInfo, e2?.settingsPaymentInfo) &&
        e1?.settingsAppVersionInfo == e2?.settingsAppVersionInfo &&
        e1?.settingsCompanyInfo == e2?.settingsCompanyInfo &&
        e1?.settingsInappPurchaseStatus == e2?.settingsInappPurchaseStatus &&
        e1?.settingsSocialLogin == e2?.settingsSocialLogin &&
        listEquality.equals(e1?.settingsSponsorInfo, e2?.settingsSponsorInfo) &&
        e1?.settingsOtpless == e2?.settingsOtpless &&
        e1?.settingsNewRegCoins == e2?.settingsNewRegCoins &&
        e1?.settingsNewRoomCoins == e2?.settingsNewRoomCoins;
  }

  @override
  int hash(SettingsRecord? e) => const ListEquality().hash([
        e?.type,
        e?.settingsPaymentInfo,
        e?.settingsAppVersionInfo,
        e?.settingsCompanyInfo,
        e?.settingsInappPurchaseStatus,
        e?.settingsSocialLogin,
        e?.settingsSponsorInfo,
        e?.settingsOtpless,
        e?.settingsNewRegCoins,
        e?.settingsNewRoomCoins
      ]);

  @override
  bool isValidKey(Object? o) => o is SettingsRecord;
}
