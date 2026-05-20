// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TranslateInfoStruct extends FFFirebaseStruct {
  TranslateInfoStruct({
    TranslateLangStruct? name,
    TranslateLangStruct? slug,
    TranslateLangStruct? description,
    TranslateLangStruct? shortDescription,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _name = name,
        _slug = slug,
        _description = description,
        _shortDescription = shortDescription,
        super(firestoreUtilData);

  // "name" field.
  TranslateLangStruct? _name;
  TranslateLangStruct get name => _name ?? TranslateLangStruct();
  set name(TranslateLangStruct? val) => _name = val;

  void updateName(Function(TranslateLangStruct) updateFn) {
    updateFn(_name ??= TranslateLangStruct());
  }

  bool hasName() => _name != null;

  // "slug" field.
  TranslateLangStruct? _slug;
  TranslateLangStruct get slug => _slug ?? TranslateLangStruct();
  set slug(TranslateLangStruct? val) => _slug = val;

  void updateSlug(Function(TranslateLangStruct) updateFn) {
    updateFn(_slug ??= TranslateLangStruct());
  }

  bool hasSlug() => _slug != null;

  // "description" field.
  TranslateLangStruct? _description;
  TranslateLangStruct get description => _description ?? TranslateLangStruct();
  set description(TranslateLangStruct? val) => _description = val;

  void updateDescription(Function(TranslateLangStruct) updateFn) {
    updateFn(_description ??= TranslateLangStruct());
  }

  bool hasDescription() => _description != null;

  // "short_description" field.
  TranslateLangStruct? _shortDescription;
  TranslateLangStruct get shortDescription =>
      _shortDescription ?? TranslateLangStruct();
  set shortDescription(TranslateLangStruct? val) => _shortDescription = val;

  void updateShortDescription(Function(TranslateLangStruct) updateFn) {
    updateFn(_shortDescription ??= TranslateLangStruct());
  }

  bool hasShortDescription() => _shortDescription != null;

  static TranslateInfoStruct fromMap(Map<String, dynamic> data) =>
      TranslateInfoStruct(
        name: data['name'] is TranslateLangStruct
            ? data['name']
            : TranslateLangStruct.maybeFromMap(data['name']),
        slug: data['slug'] is TranslateLangStruct
            ? data['slug']
            : TranslateLangStruct.maybeFromMap(data['slug']),
        description: data['description'] is TranslateLangStruct
            ? data['description']
            : TranslateLangStruct.maybeFromMap(data['description']),
        shortDescription: data['short_description'] is TranslateLangStruct
            ? data['short_description']
            : TranslateLangStruct.maybeFromMap(data['short_description']),
      );

  static TranslateInfoStruct? maybeFromMap(dynamic data) => data is Map
      ? TranslateInfoStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'name': _name?.toMap(),
        'slug': _slug?.toMap(),
        'description': _description?.toMap(),
        'short_description': _shortDescription?.toMap(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'name': serializeParam(
          _name,
          ParamType.DataStruct,
        ),
        'slug': serializeParam(
          _slug,
          ParamType.DataStruct,
        ),
        'description': serializeParam(
          _description,
          ParamType.DataStruct,
        ),
        'short_description': serializeParam(
          _shortDescription,
          ParamType.DataStruct,
        ),
      }.withoutNulls;

  static TranslateInfoStruct fromSerializableMap(Map<String, dynamic> data) =>
      TranslateInfoStruct(
        name: deserializeStructParam(
          data['name'],
          ParamType.DataStruct,
          false,
          structBuilder: TranslateLangStruct.fromSerializableMap,
        ),
        slug: deserializeStructParam(
          data['slug'],
          ParamType.DataStruct,
          false,
          structBuilder: TranslateLangStruct.fromSerializableMap,
        ),
        description: deserializeStructParam(
          data['description'],
          ParamType.DataStruct,
          false,
          structBuilder: TranslateLangStruct.fromSerializableMap,
        ),
        shortDescription: deserializeStructParam(
          data['short_description'],
          ParamType.DataStruct,
          false,
          structBuilder: TranslateLangStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'TranslateInfoStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is TranslateInfoStruct &&
        name == other.name &&
        slug == other.slug &&
        description == other.description &&
        shortDescription == other.shortDescription;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([name, slug, description, shortDescription]);
}

TranslateInfoStruct createTranslateInfoStruct({
  TranslateLangStruct? name,
  TranslateLangStruct? slug,
  TranslateLangStruct? description,
  TranslateLangStruct? shortDescription,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    TranslateInfoStruct(
      name: name ?? (clearUnsetFields ? TranslateLangStruct() : null),
      slug: slug ?? (clearUnsetFields ? TranslateLangStruct() : null),
      description:
          description ?? (clearUnsetFields ? TranslateLangStruct() : null),
      shortDescription:
          shortDescription ?? (clearUnsetFields ? TranslateLangStruct() : null),
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

TranslateInfoStruct? updateTranslateInfoStruct(
  TranslateInfoStruct? translateInfo, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    translateInfo
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addTranslateInfoStructData(
  Map<String, dynamic> firestoreData,
  TranslateInfoStruct? translateInfo,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (translateInfo == null) {
    return;
  }
  if (translateInfo.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && translateInfo.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final translateInfoData =
      getTranslateInfoFirestoreData(translateInfo, forFieldValue);
  final nestedData =
      translateInfoData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = translateInfo.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getTranslateInfoFirestoreData(
  TranslateInfoStruct? translateInfo, [
  bool forFieldValue = false,
]) {
  if (translateInfo == null) {
    return {};
  }
  final firestoreData = mapToFirestore(translateInfo.toMap());

  // Handle nested data for "name" field.
  addTranslateLangStructData(
    firestoreData,
    translateInfo.hasName() ? translateInfo.name : null,
    'name',
    forFieldValue,
  );

  // Handle nested data for "slug" field.
  addTranslateLangStructData(
    firestoreData,
    translateInfo.hasSlug() ? translateInfo.slug : null,
    'slug',
    forFieldValue,
  );

  // Handle nested data for "description" field.
  addTranslateLangStructData(
    firestoreData,
    translateInfo.hasDescription() ? translateInfo.description : null,
    'description',
    forFieldValue,
  );

  // Handle nested data for "short_description" field.
  addTranslateLangStructData(
    firestoreData,
    translateInfo.hasShortDescription() ? translateInfo.shortDescription : null,
    'short_description',
    forFieldValue,
  );

  // Add any Firestore field values
  mapToFirestore(translateInfo.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getTranslateInfoListFirestoreData(
  List<TranslateInfoStruct>? translateInfos,
) =>
    translateInfos
        ?.map((e) => getTranslateInfoFirestoreData(e, true))
        .toList() ??
    [];
