// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PointInfoStruct extends FFFirebaseStruct {
  PointInfoStruct({
    double? price,
    double? regularPrice,
    double? salesPrice,
    int? point,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _price = price,
        _regularPrice = regularPrice,
        _salesPrice = salesPrice,
        _point = point,
        super(firestoreUtilData);

  // "price" field.
  double? _price;
  double get price => _price ?? 0.0;
  set price(double? val) => _price = val;

  void incrementPrice(double amount) => price = price + amount;

  bool hasPrice() => _price != null;

  // "regular_price" field.
  double? _regularPrice;
  double get regularPrice => _regularPrice ?? 0.0;
  set regularPrice(double? val) => _regularPrice = val;

  void incrementRegularPrice(double amount) =>
      regularPrice = regularPrice + amount;

  bool hasRegularPrice() => _regularPrice != null;

  // "sales_price" field.
  double? _salesPrice;
  double get salesPrice => _salesPrice ?? 0.0;
  set salesPrice(double? val) => _salesPrice = val;

  void incrementSalesPrice(double amount) => salesPrice = salesPrice + amount;

  bool hasSalesPrice() => _salesPrice != null;

  // "point" field.
  int? _point;
  int get point => _point ?? 0;
  set point(int? val) => _point = val;

  void incrementPoint(int amount) => point = point + amount;

  bool hasPoint() => _point != null;

  static PointInfoStruct fromMap(Map<String, dynamic> data) => PointInfoStruct(
        price: castToType<double>(data['price']),
        regularPrice: castToType<double>(data['regular_price']),
        salesPrice: castToType<double>(data['sales_price']),
        point: castToType<int>(data['point']),
      );

  static PointInfoStruct? maybeFromMap(dynamic data) => data is Map
      ? PointInfoStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'price': _price,
        'regular_price': _regularPrice,
        'sales_price': _salesPrice,
        'point': _point,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'price': serializeParam(
          _price,
          ParamType.double,
        ),
        'regular_price': serializeParam(
          _regularPrice,
          ParamType.double,
        ),
        'sales_price': serializeParam(
          _salesPrice,
          ParamType.double,
        ),
        'point': serializeParam(
          _point,
          ParamType.int,
        ),
      }.withoutNulls;

  static PointInfoStruct fromSerializableMap(Map<String, dynamic> data) =>
      PointInfoStruct(
        price: deserializeParam(
          data['price'],
          ParamType.double,
          false,
        ),
        regularPrice: deserializeParam(
          data['regular_price'],
          ParamType.double,
          false,
        ),
        salesPrice: deserializeParam(
          data['sales_price'],
          ParamType.double,
          false,
        ),
        point: deserializeParam(
          data['point'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'PointInfoStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is PointInfoStruct &&
        price == other.price &&
        regularPrice == other.regularPrice &&
        salesPrice == other.salesPrice &&
        point == other.point;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([price, regularPrice, salesPrice, point]);
}

PointInfoStruct createPointInfoStruct({
  double? price,
  double? regularPrice,
  double? salesPrice,
  int? point,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    PointInfoStruct(
      price: price,
      regularPrice: regularPrice,
      salesPrice: salesPrice,
      point: point,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

PointInfoStruct? updatePointInfoStruct(
  PointInfoStruct? pointInfo, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    pointInfo
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addPointInfoStructData(
  Map<String, dynamic> firestoreData,
  PointInfoStruct? pointInfo,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (pointInfo == null) {
    return;
  }
  if (pointInfo.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && pointInfo.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final pointInfoData = getPointInfoFirestoreData(pointInfo, forFieldValue);
  final nestedData = pointInfoData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = pointInfo.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getPointInfoFirestoreData(
  PointInfoStruct? pointInfo, [
  bool forFieldValue = false,
]) {
  if (pointInfo == null) {
    return {};
  }
  final firestoreData = mapToFirestore(pointInfo.toMap());

  // Add any Firestore field values
  mapToFirestore(pointInfo.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getPointInfoListFirestoreData(
  List<PointInfoStruct>? pointInfos,
) =>
    pointInfos?.map((e) => getPointInfoFirestoreData(e, true)).toList() ?? [];
