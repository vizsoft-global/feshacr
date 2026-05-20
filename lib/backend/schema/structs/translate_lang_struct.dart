// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TranslateLangStruct extends FFFirebaseStruct {
  TranslateLangStruct({
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

  static TranslateLangStruct fromMap(Map<String, dynamic> data) =>
      TranslateLangStruct(
        en: data['en'] as String?,
        ar: data['ar'] as String?,
      );

  static TranslateLangStruct? maybeFromMap(dynamic data) => data is Map
      ? TranslateLangStruct.fromMap(data.cast<String, dynamic>())
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

  static TranslateLangStruct fromSerializableMap(Map<String, dynamic> data) =>
      TranslateLangStruct(
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
  String toString() => 'TranslateLangStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is TranslateLangStruct && en == other.en && ar == other.ar;
  }

  @override
  int get hashCode => const ListEquality().hash([en, ar]);
}

TranslateLangStruct createTranslateLangStruct({
  String? en,
  String? ar,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    TranslateLangStruct(
      en: en,
      ar: ar,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

TranslateLangStruct? updateTranslateLangStruct(
  TranslateLangStruct? translateLang, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    translateLang
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addTranslateLangStructData(
  Map<String, dynamic> firestoreData,
  TranslateLangStruct? translateLang,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (translateLang == null) {
    return;
  }
  if (translateLang.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && translateLang.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final translateLangData =
      getTranslateLangFirestoreData(translateLang, forFieldValue);
  final nestedData =
      translateLangData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = translateLang.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getTranslateLangFirestoreData(
  TranslateLangStruct? translateLang, [
  bool forFieldValue = false,
]) {
  if (translateLang == null) {
    return {};
  }
  final firestoreData = mapToFirestore(translateLang.toMap());

  // Add any Firestore field values
  mapToFirestore(translateLang.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getTranslateLangListFirestoreData(
  List<TranslateLangStruct>? translateLangs,
) =>
    translateLangs
        ?.map((e) => getTranslateLangFirestoreData(e, true))
        .toList() ??
    [];
