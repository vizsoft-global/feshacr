// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MainInfoStruct extends FFFirebaseStruct {
  MainInfoStruct({
    String? name,
    String? mainDescription,
    String? mainImage,
    String? mainImageId,
    String? mainImageGallery,
    String? mainVideoUrl,
    String? image,
    String? shortDescription,
    String? description,
    List<String>? gallery,
    String? fileID,
    String? fileURL,
    String? videoUrl,
    String? audioUrl,
    TranslateInfoStruct? mainInfoTranslate,
    TranslateInfoStruct? mainInfoManualTranslate,
    Color? color1,
    Color? color2,
    int? id,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _name = name,
        _mainDescription = mainDescription,
        _mainImage = mainImage,
        _mainImageId = mainImageId,
        _mainImageGallery = mainImageGallery,
        _mainVideoUrl = mainVideoUrl,
        _image = image,
        _shortDescription = shortDescription,
        _description = description,
        _gallery = gallery,
        _fileID = fileID,
        _fileURL = fileURL,
        _videoUrl = videoUrl,
        _audioUrl = audioUrl,
        _mainInfoTranslate = mainInfoTranslate,
        _mainInfoManualTranslate = mainInfoManualTranslate,
        _color1 = color1,
        _color2 = color2,
        _id = id,
        super(firestoreUtilData);

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "main_description" field.
  String? _mainDescription;
  String get mainDescription => _mainDescription ?? '';
  set mainDescription(String? val) => _mainDescription = val;

  bool hasMainDescription() => _mainDescription != null;

  // "main_image" field.
  String? _mainImage;
  String get mainImage => _mainImage ?? '';
  set mainImage(String? val) => _mainImage = val;

  bool hasMainImage() => _mainImage != null;

  // "main_image_id" field.
  String? _mainImageId;
  String get mainImageId => _mainImageId ?? '';
  set mainImageId(String? val) => _mainImageId = val;

  bool hasMainImageId() => _mainImageId != null;

  // "main_image_gallery" field.
  String? _mainImageGallery;
  String get mainImageGallery => _mainImageGallery ?? '';
  set mainImageGallery(String? val) => _mainImageGallery = val;

  bool hasMainImageGallery() => _mainImageGallery != null;

  // "main_video_url" field.
  String? _mainVideoUrl;
  String get mainVideoUrl => _mainVideoUrl ?? '';
  set mainVideoUrl(String? val) => _mainVideoUrl = val;

  bool hasMainVideoUrl() => _mainVideoUrl != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  set image(String? val) => _image = val;

  bool hasImage() => _image != null;

  // "short_description" field.
  String? _shortDescription;
  String get shortDescription => _shortDescription ?? '';
  set shortDescription(String? val) => _shortDescription = val;

  bool hasShortDescription() => _shortDescription != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  set description(String? val) => _description = val;

  bool hasDescription() => _description != null;

  // "gallery" field.
  List<String>? _gallery;
  List<String> get gallery => _gallery ?? const [];
  set gallery(List<String>? val) => _gallery = val;

  void updateGallery(Function(List<String>) updateFn) {
    updateFn(_gallery ??= []);
  }

  bool hasGallery() => _gallery != null;

  // "file_ID" field.
  String? _fileID;
  String get fileID => _fileID ?? '';
  set fileID(String? val) => _fileID = val;

  bool hasFileID() => _fileID != null;

  // "file_URL" field.
  String? _fileURL;
  String get fileURL => _fileURL ?? '';
  set fileURL(String? val) => _fileURL = val;

  bool hasFileURL() => _fileURL != null;

  // "video_url" field.
  String? _videoUrl;
  String get videoUrl => _videoUrl ?? '';
  set videoUrl(String? val) => _videoUrl = val;

  bool hasVideoUrl() => _videoUrl != null;

  // "audio_url" field.
  String? _audioUrl;
  String get audioUrl => _audioUrl ?? '';
  set audioUrl(String? val) => _audioUrl = val;

  bool hasAudioUrl() => _audioUrl != null;

  // "main_info_translate" field.
  TranslateInfoStruct? _mainInfoTranslate;
  TranslateInfoStruct get mainInfoTranslate =>
      _mainInfoTranslate ?? TranslateInfoStruct();
  set mainInfoTranslate(TranslateInfoStruct? val) => _mainInfoTranslate = val;

  void updateMainInfoTranslate(Function(TranslateInfoStruct) updateFn) {
    updateFn(_mainInfoTranslate ??= TranslateInfoStruct());
  }

  bool hasMainInfoTranslate() => _mainInfoTranslate != null;

  // "main_info_manual_translate" field.
  TranslateInfoStruct? _mainInfoManualTranslate;
  TranslateInfoStruct get mainInfoManualTranslate =>
      _mainInfoManualTranslate ?? TranslateInfoStruct();
  set mainInfoManualTranslate(TranslateInfoStruct? val) =>
      _mainInfoManualTranslate = val;

  void updateMainInfoManualTranslate(Function(TranslateInfoStruct) updateFn) {
    updateFn(_mainInfoManualTranslate ??= TranslateInfoStruct());
  }

  bool hasMainInfoManualTranslate() => _mainInfoManualTranslate != null;

  // "color1" field.
  Color? _color1;
  Color? get color1 => _color1;
  set color1(Color? val) => _color1 = val;

  bool hasColor1() => _color1 != null;

  // "color2" field.
  Color? _color2;
  Color? get color2 => _color2;
  set color2(Color? val) => _color2 = val;

  bool hasColor2() => _color2 != null;

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) => _id = val;

  void incrementId(int amount) => id = id + amount;

  bool hasId() => _id != null;

  static MainInfoStruct fromMap(Map<String, dynamic> data) => MainInfoStruct(
        name: data['name'] as String?,
        mainDescription: data['main_description'] as String?,
        mainImage: data['main_image'] as String?,
        mainImageId: data['main_image_id'] as String?,
        mainImageGallery: data['main_image_gallery'] as String?,
        mainVideoUrl: data['main_video_url'] as String?,
        image: data['image'] as String?,
        shortDescription: data['short_description'] as String?,
        description: data['description'] as String?,
        gallery: getDataList(data['gallery']),
        fileID: data['file_ID'] as String?,
        fileURL: data['file_URL'] as String?,
        videoUrl: data['video_url'] as String?,
        audioUrl: data['audio_url'] as String?,
        mainInfoTranslate: data['main_info_translate'] is TranslateInfoStruct
            ? data['main_info_translate']
            : TranslateInfoStruct.maybeFromMap(data['main_info_translate']),
        mainInfoManualTranslate:
            data['main_info_manual_translate'] is TranslateInfoStruct
                ? data['main_info_manual_translate']
                : TranslateInfoStruct.maybeFromMap(
                    data['main_info_manual_translate']),
        color1: getSchemaColor(data['color1']),
        color2: getSchemaColor(data['color2']),
        id: castToType<int>(data['id']),
      );

  static MainInfoStruct? maybeFromMap(dynamic data) =>
      data is Map ? MainInfoStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'name': _name,
        'main_description': _mainDescription,
        'main_image': _mainImage,
        'main_image_id': _mainImageId,
        'main_image_gallery': _mainImageGallery,
        'main_video_url': _mainVideoUrl,
        'image': _image,
        'short_description': _shortDescription,
        'description': _description,
        'gallery': _gallery,
        'file_ID': _fileID,
        'file_URL': _fileURL,
        'video_url': _videoUrl,
        'audio_url': _audioUrl,
        'main_info_translate': _mainInfoTranslate?.toMap(),
        'main_info_manual_translate': _mainInfoManualTranslate?.toMap(),
        'color1': _color1,
        'color2': _color2,
        'id': _id,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'main_description': serializeParam(
          _mainDescription,
          ParamType.String,
        ),
        'main_image': serializeParam(
          _mainImage,
          ParamType.String,
        ),
        'main_image_id': serializeParam(
          _mainImageId,
          ParamType.String,
        ),
        'main_image_gallery': serializeParam(
          _mainImageGallery,
          ParamType.String,
        ),
        'main_video_url': serializeParam(
          _mainVideoUrl,
          ParamType.String,
        ),
        'image': serializeParam(
          _image,
          ParamType.String,
        ),
        'short_description': serializeParam(
          _shortDescription,
          ParamType.String,
        ),
        'description': serializeParam(
          _description,
          ParamType.String,
        ),
        'gallery': serializeParam(
          _gallery,
          ParamType.String,
          isList: true,
        ),
        'file_ID': serializeParam(
          _fileID,
          ParamType.String,
        ),
        'file_URL': serializeParam(
          _fileURL,
          ParamType.String,
        ),
        'video_url': serializeParam(
          _videoUrl,
          ParamType.String,
        ),
        'audio_url': serializeParam(
          _audioUrl,
          ParamType.String,
        ),
        'main_info_translate': serializeParam(
          _mainInfoTranslate,
          ParamType.DataStruct,
        ),
        'main_info_manual_translate': serializeParam(
          _mainInfoManualTranslate,
          ParamType.DataStruct,
        ),
        'color1': serializeParam(
          _color1,
          ParamType.Color,
        ),
        'color2': serializeParam(
          _color2,
          ParamType.Color,
        ),
        'id': serializeParam(
          _id,
          ParamType.int,
        ),
      }.withoutNulls;

  static MainInfoStruct fromSerializableMap(Map<String, dynamic> data) =>
      MainInfoStruct(
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        mainDescription: deserializeParam(
          data['main_description'],
          ParamType.String,
          false,
        ),
        mainImage: deserializeParam(
          data['main_image'],
          ParamType.String,
          false,
        ),
        mainImageId: deserializeParam(
          data['main_image_id'],
          ParamType.String,
          false,
        ),
        mainImageGallery: deserializeParam(
          data['main_image_gallery'],
          ParamType.String,
          false,
        ),
        mainVideoUrl: deserializeParam(
          data['main_video_url'],
          ParamType.String,
          false,
        ),
        image: deserializeParam(
          data['image'],
          ParamType.String,
          false,
        ),
        shortDescription: deserializeParam(
          data['short_description'],
          ParamType.String,
          false,
        ),
        description: deserializeParam(
          data['description'],
          ParamType.String,
          false,
        ),
        gallery: deserializeParam<String>(
          data['gallery'],
          ParamType.String,
          true,
        ),
        fileID: deserializeParam(
          data['file_ID'],
          ParamType.String,
          false,
        ),
        fileURL: deserializeParam(
          data['file_URL'],
          ParamType.String,
          false,
        ),
        videoUrl: deserializeParam(
          data['video_url'],
          ParamType.String,
          false,
        ),
        audioUrl: deserializeParam(
          data['audio_url'],
          ParamType.String,
          false,
        ),
        mainInfoTranslate: deserializeStructParam(
          data['main_info_translate'],
          ParamType.DataStruct,
          false,
          structBuilder: TranslateInfoStruct.fromSerializableMap,
        ),
        mainInfoManualTranslate: deserializeStructParam(
          data['main_info_manual_translate'],
          ParamType.DataStruct,
          false,
          structBuilder: TranslateInfoStruct.fromSerializableMap,
        ),
        color1: deserializeParam(
          data['color1'],
          ParamType.Color,
          false,
        ),
        color2: deserializeParam(
          data['color2'],
          ParamType.Color,
          false,
        ),
        id: deserializeParam(
          data['id'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'MainInfoStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is MainInfoStruct &&
        name == other.name &&
        mainDescription == other.mainDescription &&
        mainImage == other.mainImage &&
        mainImageId == other.mainImageId &&
        mainImageGallery == other.mainImageGallery &&
        mainVideoUrl == other.mainVideoUrl &&
        image == other.image &&
        shortDescription == other.shortDescription &&
        description == other.description &&
        listEquality.equals(gallery, other.gallery) &&
        fileID == other.fileID &&
        fileURL == other.fileURL &&
        videoUrl == other.videoUrl &&
        audioUrl == other.audioUrl &&
        mainInfoTranslate == other.mainInfoTranslate &&
        mainInfoManualTranslate == other.mainInfoManualTranslate &&
        color1 == other.color1 &&
        color2 == other.color2 &&
        id == other.id;
  }

  @override
  int get hashCode => const ListEquality().hash([
        name,
        mainDescription,
        mainImage,
        mainImageId,
        mainImageGallery,
        mainVideoUrl,
        image,
        shortDescription,
        description,
        gallery,
        fileID,
        fileURL,
        videoUrl,
        audioUrl,
        mainInfoTranslate,
        mainInfoManualTranslate,
        color1,
        color2,
        id
      ]);
}

MainInfoStruct createMainInfoStruct({
  String? name,
  String? mainDescription,
  String? mainImage,
  String? mainImageId,
  String? mainImageGallery,
  String? mainVideoUrl,
  String? image,
  String? shortDescription,
  String? description,
  String? fileID,
  String? fileURL,
  String? videoUrl,
  String? audioUrl,
  TranslateInfoStruct? mainInfoTranslate,
  TranslateInfoStruct? mainInfoManualTranslate,
  Color? color1,
  Color? color2,
  int? id,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    MainInfoStruct(
      name: name,
      mainDescription: mainDescription,
      mainImage: mainImage,
      mainImageId: mainImageId,
      mainImageGallery: mainImageGallery,
      mainVideoUrl: mainVideoUrl,
      image: image,
      shortDescription: shortDescription,
      description: description,
      fileID: fileID,
      fileURL: fileURL,
      videoUrl: videoUrl,
      audioUrl: audioUrl,
      mainInfoTranslate: mainInfoTranslate ??
          (clearUnsetFields ? TranslateInfoStruct() : null),
      mainInfoManualTranslate: mainInfoManualTranslate ??
          (clearUnsetFields ? TranslateInfoStruct() : null),
      color1: color1,
      color2: color2,
      id: id,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

MainInfoStruct? updateMainInfoStruct(
  MainInfoStruct? mainInfo, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    mainInfo
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addMainInfoStructData(
  Map<String, dynamic> firestoreData,
  MainInfoStruct? mainInfo,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (mainInfo == null) {
    return;
  }
  if (mainInfo.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && mainInfo.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final mainInfoData = getMainInfoFirestoreData(mainInfo, forFieldValue);
  final nestedData = mainInfoData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = mainInfo.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getMainInfoFirestoreData(
  MainInfoStruct? mainInfo, [
  bool forFieldValue = false,
]) {
  if (mainInfo == null) {
    return {};
  }
  final firestoreData = mapToFirestore(mainInfo.toMap());

  // Handle nested data for "main_info_translate" field.
  addTranslateInfoStructData(
    firestoreData,
    mainInfo.hasMainInfoTranslate() ? mainInfo.mainInfoTranslate : null,
    'main_info_translate',
    forFieldValue,
  );

  // Handle nested data for "main_info_manual_translate" field.
  addTranslateInfoStructData(
    firestoreData,
    mainInfo.hasMainInfoManualTranslate()
        ? mainInfo.mainInfoManualTranslate
        : null,
    'main_info_manual_translate',
    forFieldValue,
  );

  // Add any Firestore field values
  mapToFirestore(mainInfo.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getMainInfoListFirestoreData(
  List<MainInfoStruct>? mainInfos,
) =>
    mainInfos?.map((e) => getMainInfoFirestoreData(e, true)).toList() ?? [];
