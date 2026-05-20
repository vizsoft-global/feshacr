// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserflowStruct extends FFFirebaseStruct {
  UserflowStruct({
    PaymentProcessingTimeStruct? paymentProcessingTime,
    String? roomType,
    RoomInfoStruct? roomInfo,
    int? roomCreatedBy,
    int? presentScannerUserId,
    int? count,
    int? randomInteger,
    String? scanResult,
    List<String>? randomFiveNumber,
    List<String>? questionIdList,
    String? selectedQuestionId,
    String? navigate,
    String? timmerStatus,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _paymentProcessingTime = paymentProcessingTime,
        _roomType = roomType,
        _roomInfo = roomInfo,
        _roomCreatedBy = roomCreatedBy,
        _presentScannerUserId = presentScannerUserId,
        _count = count,
        _randomInteger = randomInteger,
        _scanResult = scanResult,
        _randomFiveNumber = randomFiveNumber,
        _questionIdList = questionIdList,
        _selectedQuestionId = selectedQuestionId,
        _navigate = navigate,
        _timmerStatus = timmerStatus,
        super(firestoreUtilData);

  // "payment_processing_time" field.
  PaymentProcessingTimeStruct? _paymentProcessingTime;
  PaymentProcessingTimeStruct get paymentProcessingTime =>
      _paymentProcessingTime ?? PaymentProcessingTimeStruct();
  set paymentProcessingTime(PaymentProcessingTimeStruct? val) =>
      _paymentProcessingTime = val;

  void updatePaymentProcessingTime(
      Function(PaymentProcessingTimeStruct) updateFn) {
    updateFn(_paymentProcessingTime ??= PaymentProcessingTimeStruct());
  }

  bool hasPaymentProcessingTime() => _paymentProcessingTime != null;

  // "room_type" field.
  String? _roomType;
  String get roomType => _roomType ?? 'create/join';
  set roomType(String? val) => _roomType = val;

  bool hasRoomType() => _roomType != null;

  // "room_info" field.
  RoomInfoStruct? _roomInfo;
  RoomInfoStruct get roomInfo => _roomInfo ?? RoomInfoStruct();
  set roomInfo(RoomInfoStruct? val) => _roomInfo = val;

  void updateRoomInfo(Function(RoomInfoStruct) updateFn) {
    updateFn(_roomInfo ??= RoomInfoStruct());
  }

  bool hasRoomInfo() => _roomInfo != null;

  // "room_created_by" field.
  int? _roomCreatedBy;
  int get roomCreatedBy => _roomCreatedBy ?? 0;
  set roomCreatedBy(int? val) => _roomCreatedBy = val;

  void incrementRoomCreatedBy(int amount) =>
      roomCreatedBy = roomCreatedBy + amount;

  bool hasRoomCreatedBy() => _roomCreatedBy != null;

  // "present_scanner_user_id" field.
  int? _presentScannerUserId;
  int get presentScannerUserId => _presentScannerUserId ?? 0;
  set presentScannerUserId(int? val) => _presentScannerUserId = val;

  void incrementPresentScannerUserId(int amount) =>
      presentScannerUserId = presentScannerUserId + amount;

  bool hasPresentScannerUserId() => _presentScannerUserId != null;

  // "count" field.
  int? _count;
  int get count => _count ?? 0;
  set count(int? val) => _count = val;

  void incrementCount(int amount) => count = count + amount;

  bool hasCount() => _count != null;

  // "random_integer" field.
  int? _randomInteger;
  int get randomInteger => _randomInteger ?? 0;
  set randomInteger(int? val) => _randomInteger = val;

  void incrementRandomInteger(int amount) =>
      randomInteger = randomInteger + amount;

  bool hasRandomInteger() => _randomInteger != null;

  // "scan_result" field.
  String? _scanResult;
  String get scanResult => _scanResult ?? '';
  set scanResult(String? val) => _scanResult = val;

  bool hasScanResult() => _scanResult != null;

  // "random_five_number" field.
  List<String>? _randomFiveNumber;
  List<String> get randomFiveNumber => _randomFiveNumber ?? const [];
  set randomFiveNumber(List<String>? val) => _randomFiveNumber = val;

  void updateRandomFiveNumber(Function(List<String>) updateFn) {
    updateFn(_randomFiveNumber ??= []);
  }

  bool hasRandomFiveNumber() => _randomFiveNumber != null;

  // "question_id_list" field.
  List<String>? _questionIdList;
  List<String> get questionIdList => _questionIdList ?? const [];
  set questionIdList(List<String>? val) => _questionIdList = val;

  void updateQuestionIdList(Function(List<String>) updateFn) {
    updateFn(_questionIdList ??= []);
  }

  bool hasQuestionIdList() => _questionIdList != null;

  // "selected_question_id" field.
  String? _selectedQuestionId;
  String get selectedQuestionId => _selectedQuestionId ?? '';
  set selectedQuestionId(String? val) => _selectedQuestionId = val;

  bool hasSelectedQuestionId() => _selectedQuestionId != null;

  // "navigate" field.
  String? _navigate;
  String get navigate => _navigate ?? '';
  set navigate(String? val) => _navigate = val;

  bool hasNavigate() => _navigate != null;

  // "timmerStatus" field.
  String? _timmerStatus;
  String get timmerStatus => _timmerStatus ?? '';
  set timmerStatus(String? val) => _timmerStatus = val;

  bool hasTimmerStatus() => _timmerStatus != null;

  static UserflowStruct fromMap(Map<String, dynamic> data) => UserflowStruct(
        paymentProcessingTime:
            data['payment_processing_time'] is PaymentProcessingTimeStruct
                ? data['payment_processing_time']
                : PaymentProcessingTimeStruct.maybeFromMap(
                    data['payment_processing_time']),
        roomType: data['room_type'] as String?,
        roomInfo: data['room_info'] is RoomInfoStruct
            ? data['room_info']
            : RoomInfoStruct.maybeFromMap(data['room_info']),
        roomCreatedBy: castToType<int>(data['room_created_by']),
        presentScannerUserId: castToType<int>(data['present_scanner_user_id']),
        count: castToType<int>(data['count']),
        randomInteger: castToType<int>(data['random_integer']),
        scanResult: data['scan_result'] as String?,
        randomFiveNumber: getDataList(data['random_five_number']),
        questionIdList: getDataList(data['question_id_list']),
        selectedQuestionId: data['selected_question_id'] as String?,
        navigate: data['navigate'] as String?,
        timmerStatus: data['timmerStatus'] as String?,
      );

  static UserflowStruct? maybeFromMap(dynamic data) =>
      data is Map ? UserflowStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'payment_processing_time': _paymentProcessingTime?.toMap(),
        'room_type': _roomType,
        'room_info': _roomInfo?.toMap(),
        'room_created_by': _roomCreatedBy,
        'present_scanner_user_id': _presentScannerUserId,
        'count': _count,
        'random_integer': _randomInteger,
        'scan_result': _scanResult,
        'random_five_number': _randomFiveNumber,
        'question_id_list': _questionIdList,
        'selected_question_id': _selectedQuestionId,
        'navigate': _navigate,
        'timmerStatus': _timmerStatus,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'payment_processing_time': serializeParam(
          _paymentProcessingTime,
          ParamType.DataStruct,
        ),
        'room_type': serializeParam(
          _roomType,
          ParamType.String,
        ),
        'room_info': serializeParam(
          _roomInfo,
          ParamType.DataStruct,
        ),
        'room_created_by': serializeParam(
          _roomCreatedBy,
          ParamType.int,
        ),
        'present_scanner_user_id': serializeParam(
          _presentScannerUserId,
          ParamType.int,
        ),
        'count': serializeParam(
          _count,
          ParamType.int,
        ),
        'random_integer': serializeParam(
          _randomInteger,
          ParamType.int,
        ),
        'scan_result': serializeParam(
          _scanResult,
          ParamType.String,
        ),
        'random_five_number': serializeParam(
          _randomFiveNumber,
          ParamType.String,
          isList: true,
        ),
        'question_id_list': serializeParam(
          _questionIdList,
          ParamType.String,
          isList: true,
        ),
        'selected_question_id': serializeParam(
          _selectedQuestionId,
          ParamType.String,
        ),
        'navigate': serializeParam(
          _navigate,
          ParamType.String,
        ),
        'timmerStatus': serializeParam(
          _timmerStatus,
          ParamType.String,
        ),
      }.withoutNulls;

  static UserflowStruct fromSerializableMap(Map<String, dynamic> data) =>
      UserflowStruct(
        paymentProcessingTime: deserializeStructParam(
          data['payment_processing_time'],
          ParamType.DataStruct,
          false,
          structBuilder: PaymentProcessingTimeStruct.fromSerializableMap,
        ),
        roomType: deserializeParam(
          data['room_type'],
          ParamType.String,
          false,
        ),
        roomInfo: deserializeStructParam(
          data['room_info'],
          ParamType.DataStruct,
          false,
          structBuilder: RoomInfoStruct.fromSerializableMap,
        ),
        roomCreatedBy: deserializeParam(
          data['room_created_by'],
          ParamType.int,
          false,
        ),
        presentScannerUserId: deserializeParam(
          data['present_scanner_user_id'],
          ParamType.int,
          false,
        ),
        count: deserializeParam(
          data['count'],
          ParamType.int,
          false,
        ),
        randomInteger: deserializeParam(
          data['random_integer'],
          ParamType.int,
          false,
        ),
        scanResult: deserializeParam(
          data['scan_result'],
          ParamType.String,
          false,
        ),
        randomFiveNumber: deserializeParam<String>(
          data['random_five_number'],
          ParamType.String,
          true,
        ),
        questionIdList: deserializeParam<String>(
          data['question_id_list'],
          ParamType.String,
          true,
        ),
        selectedQuestionId: deserializeParam(
          data['selected_question_id'],
          ParamType.String,
          false,
        ),
        navigate: deserializeParam(
          data['navigate'],
          ParamType.String,
          false,
        ),
        timmerStatus: deserializeParam(
          data['timmerStatus'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'UserflowStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is UserflowStruct &&
        paymentProcessingTime == other.paymentProcessingTime &&
        roomType == other.roomType &&
        roomInfo == other.roomInfo &&
        roomCreatedBy == other.roomCreatedBy &&
        presentScannerUserId == other.presentScannerUserId &&
        count == other.count &&
        randomInteger == other.randomInteger &&
        scanResult == other.scanResult &&
        listEquality.equals(randomFiveNumber, other.randomFiveNumber) &&
        listEquality.equals(questionIdList, other.questionIdList) &&
        selectedQuestionId == other.selectedQuestionId &&
        navigate == other.navigate &&
        timmerStatus == other.timmerStatus;
  }

  @override
  int get hashCode => const ListEquality().hash([
        paymentProcessingTime,
        roomType,
        roomInfo,
        roomCreatedBy,
        presentScannerUserId,
        count,
        randomInteger,
        scanResult,
        randomFiveNumber,
        questionIdList,
        selectedQuestionId,
        navigate,
        timmerStatus
      ]);
}

UserflowStruct createUserflowStruct({
  PaymentProcessingTimeStruct? paymentProcessingTime,
  String? roomType,
  RoomInfoStruct? roomInfo,
  int? roomCreatedBy,
  int? presentScannerUserId,
  int? count,
  int? randomInteger,
  String? scanResult,
  String? selectedQuestionId,
  String? navigate,
  String? timmerStatus,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    UserflowStruct(
      paymentProcessingTime: paymentProcessingTime ??
          (clearUnsetFields ? PaymentProcessingTimeStruct() : null),
      roomType: roomType,
      roomInfo: roomInfo ?? (clearUnsetFields ? RoomInfoStruct() : null),
      roomCreatedBy: roomCreatedBy,
      presentScannerUserId: presentScannerUserId,
      count: count,
      randomInteger: randomInteger,
      scanResult: scanResult,
      selectedQuestionId: selectedQuestionId,
      navigate: navigate,
      timmerStatus: timmerStatus,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

UserflowStruct? updateUserflowStruct(
  UserflowStruct? userflow, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    userflow
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addUserflowStructData(
  Map<String, dynamic> firestoreData,
  UserflowStruct? userflow,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (userflow == null) {
    return;
  }
  if (userflow.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && userflow.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final userflowData = getUserflowFirestoreData(userflow, forFieldValue);
  final nestedData = userflowData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = userflow.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getUserflowFirestoreData(
  UserflowStruct? userflow, [
  bool forFieldValue = false,
]) {
  if (userflow == null) {
    return {};
  }
  final firestoreData = mapToFirestore(userflow.toMap());

  // Handle nested data for "payment_processing_time" field.
  addPaymentProcessingTimeStructData(
    firestoreData,
    userflow.hasPaymentProcessingTime() ? userflow.paymentProcessingTime : null,
    'payment_processing_time',
    forFieldValue,
  );

  // Handle nested data for "room_info" field.
  addRoomInfoStructData(
    firestoreData,
    userflow.hasRoomInfo() ? userflow.roomInfo : null,
    'room_info',
    forFieldValue,
  );

  // Add any Firestore field values
  mapToFirestore(userflow.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getUserflowListFirestoreData(
  List<UserflowStruct>? userflows,
) =>
    userflows?.map((e) => getUserflowFirestoreData(e, true)).toList() ?? [];
