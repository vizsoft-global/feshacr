// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SettingsPaymentInfoStruct extends FFFirebaseStruct {
  SettingsPaymentInfoStruct({
    bool? isPrimaryStatus,
    int? paymentId,
    bool? isProductionStatus,
    String? paymentName,
    String? paymentTransactionFees,
    String? apiKey,
    int? merchentId,
    String? productionSecretKey,
    String? testSecretKey,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _isPrimaryStatus = isPrimaryStatus,
        _paymentId = paymentId,
        _isProductionStatus = isProductionStatus,
        _paymentName = paymentName,
        _paymentTransactionFees = paymentTransactionFees,
        _apiKey = apiKey,
        _merchentId = merchentId,
        _productionSecretKey = productionSecretKey,
        _testSecretKey = testSecretKey,
        super(firestoreUtilData);

  // "is_primary_status" field.
  bool? _isPrimaryStatus;
  bool get isPrimaryStatus => _isPrimaryStatus ?? false;
  set isPrimaryStatus(bool? val) => _isPrimaryStatus = val;

  bool hasIsPrimaryStatus() => _isPrimaryStatus != null;

  // "payment_id" field.
  int? _paymentId;
  int get paymentId => _paymentId ?? 0;
  set paymentId(int? val) => _paymentId = val;

  void incrementPaymentId(int amount) => paymentId = paymentId + amount;

  bool hasPaymentId() => _paymentId != null;

  // "is_production_status" field.
  bool? _isProductionStatus;
  bool get isProductionStatus => _isProductionStatus ?? false;
  set isProductionStatus(bool? val) => _isProductionStatus = val;

  bool hasIsProductionStatus() => _isProductionStatus != null;

  // "payment_name" field.
  String? _paymentName;
  String get paymentName => _paymentName ?? '';
  set paymentName(String? val) => _paymentName = val;

  bool hasPaymentName() => _paymentName != null;

  // "payment_transaction_fees" field.
  String? _paymentTransactionFees;
  String get paymentTransactionFees => _paymentTransactionFees ?? '';
  set paymentTransactionFees(String? val) => _paymentTransactionFees = val;

  bool hasPaymentTransactionFees() => _paymentTransactionFees != null;

  // "api_key" field.
  String? _apiKey;
  String get apiKey => _apiKey ?? '';
  set apiKey(String? val) => _apiKey = val;

  bool hasApiKey() => _apiKey != null;

  // "merchent_id" field.
  int? _merchentId;
  int get merchentId => _merchentId ?? 0;
  set merchentId(int? val) => _merchentId = val;

  void incrementMerchentId(int amount) => merchentId = merchentId + amount;

  bool hasMerchentId() => _merchentId != null;

  // "production_secret_key" field.
  String? _productionSecretKey;
  String get productionSecretKey => _productionSecretKey ?? '';
  set productionSecretKey(String? val) => _productionSecretKey = val;

  bool hasProductionSecretKey() => _productionSecretKey != null;

  // "test_secret_key" field.
  String? _testSecretKey;
  String get testSecretKey => _testSecretKey ?? '';
  set testSecretKey(String? val) => _testSecretKey = val;

  bool hasTestSecretKey() => _testSecretKey != null;

  static SettingsPaymentInfoStruct fromMap(Map<String, dynamic> data) =>
      SettingsPaymentInfoStruct(
        isPrimaryStatus: data['is_primary_status'] as bool?,
        paymentId: castToType<int>(data['payment_id']),
        isProductionStatus: data['is_production_status'] as bool?,
        paymentName: data['payment_name'] as String?,
        paymentTransactionFees: data['payment_transaction_fees'] as String?,
        apiKey: data['api_key'] as String?,
        merchentId: castToType<int>(data['merchent_id']),
        productionSecretKey: data['production_secret_key'] as String?,
        testSecretKey: data['test_secret_key'] as String?,
      );

  static SettingsPaymentInfoStruct? maybeFromMap(dynamic data) => data is Map
      ? SettingsPaymentInfoStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'is_primary_status': _isPrimaryStatus,
        'payment_id': _paymentId,
        'is_production_status': _isProductionStatus,
        'payment_name': _paymentName,
        'payment_transaction_fees': _paymentTransactionFees,
        'api_key': _apiKey,
        'merchent_id': _merchentId,
        'production_secret_key': _productionSecretKey,
        'test_secret_key': _testSecretKey,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'is_primary_status': serializeParam(
          _isPrimaryStatus,
          ParamType.bool,
        ),
        'payment_id': serializeParam(
          _paymentId,
          ParamType.int,
        ),
        'is_production_status': serializeParam(
          _isProductionStatus,
          ParamType.bool,
        ),
        'payment_name': serializeParam(
          _paymentName,
          ParamType.String,
        ),
        'payment_transaction_fees': serializeParam(
          _paymentTransactionFees,
          ParamType.String,
        ),
        'api_key': serializeParam(
          _apiKey,
          ParamType.String,
        ),
        'merchent_id': serializeParam(
          _merchentId,
          ParamType.int,
        ),
        'production_secret_key': serializeParam(
          _productionSecretKey,
          ParamType.String,
        ),
        'test_secret_key': serializeParam(
          _testSecretKey,
          ParamType.String,
        ),
      }.withoutNulls;

  static SettingsPaymentInfoStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      SettingsPaymentInfoStruct(
        isPrimaryStatus: deserializeParam(
          data['is_primary_status'],
          ParamType.bool,
          false,
        ),
        paymentId: deserializeParam(
          data['payment_id'],
          ParamType.int,
          false,
        ),
        isProductionStatus: deserializeParam(
          data['is_production_status'],
          ParamType.bool,
          false,
        ),
        paymentName: deserializeParam(
          data['payment_name'],
          ParamType.String,
          false,
        ),
        paymentTransactionFees: deserializeParam(
          data['payment_transaction_fees'],
          ParamType.String,
          false,
        ),
        apiKey: deserializeParam(
          data['api_key'],
          ParamType.String,
          false,
        ),
        merchentId: deserializeParam(
          data['merchent_id'],
          ParamType.int,
          false,
        ),
        productionSecretKey: deserializeParam(
          data['production_secret_key'],
          ParamType.String,
          false,
        ),
        testSecretKey: deserializeParam(
          data['test_secret_key'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'SettingsPaymentInfoStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is SettingsPaymentInfoStruct &&
        isPrimaryStatus == other.isPrimaryStatus &&
        paymentId == other.paymentId &&
        isProductionStatus == other.isProductionStatus &&
        paymentName == other.paymentName &&
        paymentTransactionFees == other.paymentTransactionFees &&
        apiKey == other.apiKey &&
        merchentId == other.merchentId &&
        productionSecretKey == other.productionSecretKey &&
        testSecretKey == other.testSecretKey;
  }

  @override
  int get hashCode => const ListEquality().hash([
        isPrimaryStatus,
        paymentId,
        isProductionStatus,
        paymentName,
        paymentTransactionFees,
        apiKey,
        merchentId,
        productionSecretKey,
        testSecretKey
      ]);
}

SettingsPaymentInfoStruct createSettingsPaymentInfoStruct({
  bool? isPrimaryStatus,
  int? paymentId,
  bool? isProductionStatus,
  String? paymentName,
  String? paymentTransactionFees,
  String? apiKey,
  int? merchentId,
  String? productionSecretKey,
  String? testSecretKey,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    SettingsPaymentInfoStruct(
      isPrimaryStatus: isPrimaryStatus,
      paymentId: paymentId,
      isProductionStatus: isProductionStatus,
      paymentName: paymentName,
      paymentTransactionFees: paymentTransactionFees,
      apiKey: apiKey,
      merchentId: merchentId,
      productionSecretKey: productionSecretKey,
      testSecretKey: testSecretKey,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

SettingsPaymentInfoStruct? updateSettingsPaymentInfoStruct(
  SettingsPaymentInfoStruct? settingsPaymentInfo, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    settingsPaymentInfo
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addSettingsPaymentInfoStructData(
  Map<String, dynamic> firestoreData,
  SettingsPaymentInfoStruct? settingsPaymentInfo,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (settingsPaymentInfo == null) {
    return;
  }
  if (settingsPaymentInfo.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && settingsPaymentInfo.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final settingsPaymentInfoData =
      getSettingsPaymentInfoFirestoreData(settingsPaymentInfo, forFieldValue);
  final nestedData =
      settingsPaymentInfoData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      settingsPaymentInfo.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getSettingsPaymentInfoFirestoreData(
  SettingsPaymentInfoStruct? settingsPaymentInfo, [
  bool forFieldValue = false,
]) {
  if (settingsPaymentInfo == null) {
    return {};
  }
  final firestoreData = mapToFirestore(settingsPaymentInfo.toMap());

  // Add any Firestore field values
  mapToFirestore(settingsPaymentInfo.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getSettingsPaymentInfoListFirestoreData(
  List<SettingsPaymentInfoStruct>? settingsPaymentInfos,
) =>
    settingsPaymentInfos
        ?.map((e) => getSettingsPaymentInfoFirestoreData(e, true))
        .toList() ??
    [];
