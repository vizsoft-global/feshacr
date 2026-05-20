// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class LanguageInfoStruct extends FFFirebaseStruct {
  LanguageInfoStruct({
    LanguageListStruct? mainName,
    LanguageListStruct? mainDescription,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _mainName = mainName,
        _mainDescription = mainDescription,
        super(firestoreUtilData);

  // "main_name" field.
  LanguageListStruct? _mainName;
  LanguageListStruct get mainName => _mainName ?? LanguageListStruct();
  set mainName(LanguageListStruct? val) => _mainName = val;

  void updateMainName(Function(LanguageListStruct) updateFn) {
    updateFn(_mainName ??= LanguageListStruct());
  }

  bool hasMainName() => _mainName != null;

  // "main_description" field.
  LanguageListStruct? _mainDescription;
  LanguageListStruct get mainDescription =>
      _mainDescription ?? LanguageListStruct();
  set mainDescription(LanguageListStruct? val) => _mainDescription = val;

  void updateMainDescription(Function(LanguageListStruct) updateFn) {
    updateFn(_mainDescription ??= LanguageListStruct());
  }

  bool hasMainDescription() => _mainDescription != null;

  static LanguageInfoStruct fromMap(Map<String, dynamic> data) =>
      LanguageInfoStruct(
        mainName: data['main_name'] is LanguageListStruct
            ? data['main_name']
            : LanguageListStruct.maybeFromMap(data['main_name']),
        mainDescription: data['main_description'] is LanguageListStruct
            ? data['main_description']
            : LanguageListStruct.maybeFromMap(data['main_description']),
      );

  static LanguageInfoStruct? maybeFromMap(dynamic data) => data is Map
      ? LanguageInfoStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'main_name': _mainName?.toMap(),
        'main_description': _mainDescription?.toMap(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'main_name': serializeParam(
          _mainName,
          ParamType.DataStruct,
        ),
        'main_description': serializeParam(
          _mainDescription,
          ParamType.DataStruct,
        ),
      }.withoutNulls;

  static LanguageInfoStruct fromSerializableMap(Map<String, dynamic> data) =>
      LanguageInfoStruct(
        mainName: deserializeStructParam(
          data['main_name'],
          ParamType.DataStruct,
          false,
          structBuilder: LanguageListStruct.fromSerializableMap,
        ),
        mainDescription: deserializeStructParam(
          data['main_description'],
          ParamType.DataStruct,
          false,
          structBuilder: LanguageListStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'LanguageInfoStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is LanguageInfoStruct &&
        mainName == other.mainName &&
        mainDescription == other.mainDescription;
  }

  @override
  int get hashCode => const ListEquality().hash([mainName, mainDescription]);
}

LanguageInfoStruct createLanguageInfoStruct({
  LanguageListStruct? mainName,
  LanguageListStruct? mainDescription,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    LanguageInfoStruct(
      mainName: mainName ?? (clearUnsetFields ? LanguageListStruct() : null),
      mainDescription:
          mainDescription ?? (clearUnsetFields ? LanguageListStruct() : null),
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

LanguageInfoStruct? updateLanguageInfoStruct(
  LanguageInfoStruct? languageInfo, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    languageInfo
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addLanguageInfoStructData(
  Map<String, dynamic> firestoreData,
  LanguageInfoStruct? languageInfo,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (languageInfo == null) {
    return;
  }
  if (languageInfo.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && languageInfo.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final languageInfoData =
      getLanguageInfoFirestoreData(languageInfo, forFieldValue);
  final nestedData =
      languageInfoData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = languageInfo.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getLanguageInfoFirestoreData(
  LanguageInfoStruct? languageInfo, [
  bool forFieldValue = false,
]) {
  if (languageInfo == null) {
    return {};
  }
  final firestoreData = mapToFirestore(languageInfo.toMap());

  // Handle nested data for "main_name" field.
  addLanguageListStructData(
    firestoreData,
    languageInfo.hasMainName() ? languageInfo.mainName : null,
    'main_name',
    forFieldValue,
  );

  // Handle nested data for "main_description" field.
  addLanguageListStructData(
    firestoreData,
    languageInfo.hasMainDescription() ? languageInfo.mainDescription : null,
    'main_description',
    forFieldValue,
  );

  // Add any Firestore field values
  mapToFirestore(languageInfo.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getLanguageInfoListFirestoreData(
  List<LanguageInfoStruct>? languageInfos,
) =>
    languageInfos?.map((e) => getLanguageInfoFirestoreData(e, true)).toList() ??
    [];
