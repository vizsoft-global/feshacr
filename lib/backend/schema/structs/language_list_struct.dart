// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class LanguageListStruct extends FFFirebaseStruct {
  LanguageListStruct({
    String? en,
    String? ar,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _en = en,
        _ar = ar,
        super(firestoreUtilData);

  // "en" field.
  String? _en;
  String get en => _en ?? '';
  set en(String? val) => _en = val;

  bool hasEn() => _en != null;

  // "ar" field.
  String? _ar;
  String get ar => _ar ?? '';
  set ar(String? val) => _ar = val;

  bool hasAr() => _ar != null;

  static LanguageListStruct fromMap(Map<String, dynamic> data) =>
      LanguageListStruct(
        en: data['en'] as String?,
        ar: data['ar'] as String?,
      );

  static LanguageListStruct? maybeFromMap(dynamic data) => data is Map
      ? LanguageListStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'en': _en,
        'ar': _ar,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'en': serializeParam(
          _en,
          ParamType.String,
        ),
        'ar': serializeParam(
          _ar,
          ParamType.String,
        ),
      }.withoutNulls;

  static LanguageListStruct fromSerializableMap(Map<String, dynamic> data) =>
      LanguageListStruct(
        en: deserializeParam(
          data['en'],
          ParamType.String,
          false,
        ),
        ar: deserializeParam(
          data['ar'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'LanguageListStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is LanguageListStruct && en == other.en && ar == other.ar;
  }

  @override
  int get hashCode => const ListEquality().hash([en, ar]);
}

LanguageListStruct createLanguageListStruct({
  String? en,
  String? ar,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    LanguageListStruct(
      en: en,
      ar: ar,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

LanguageListStruct? updateLanguageListStruct(
  LanguageListStruct? languageList, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    languageList
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addLanguageListStructData(
  Map<String, dynamic> firestoreData,
  LanguageListStruct? languageList,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (languageList == null) {
    return;
  }
  if (languageList.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && languageList.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final languageListData =
      getLanguageListFirestoreData(languageList, forFieldValue);
  final nestedData =
      languageListData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = languageList.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getLanguageListFirestoreData(
  LanguageListStruct? languageList, [
  bool forFieldValue = false,
]) {
  if (languageList == null) {
    return {};
  }
  final firestoreData = mapToFirestore(languageList.toMap());

  // Add any Firestore field values
  mapToFirestore(languageList.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getLanguageListListFirestoreData(
  List<LanguageListStruct>? languageLists,
) =>
    languageLists?.map((e) => getLanguageListFirestoreData(e, true)).toList() ??
    [];
