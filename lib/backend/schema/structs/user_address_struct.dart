// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserAddressStruct extends FFFirebaseStruct {
  UserAddressStruct({
    String? name,
    String? email,
    String? dailCode1,
    String? phone1,
    String? dailCode2,
    String? phone2,
    String? flatNumber,
    String? street1,
    String? street2,
    String? city,
    String? state,
    String? country,
    int? pincode,
    String? landMark,
    String? gmapLink,
    LatLng? gmapLatLan,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _name = name,
        _email = email,
        _dailCode1 = dailCode1,
        _phone1 = phone1,
        _dailCode2 = dailCode2,
        _phone2 = phone2,
        _flatNumber = flatNumber,
        _street1 = street1,
        _street2 = street2,
        _city = city,
        _state = state,
        _country = country,
        _pincode = pincode,
        _landMark = landMark,
        _gmapLink = gmapLink,
        _gmapLatLan = gmapLatLan,
        super(firestoreUtilData);

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  set email(String? val) => _email = val;

  bool hasEmail() => _email != null;

  // "dail_code1" field.
  String? _dailCode1;
  String get dailCode1 => _dailCode1 ?? '';
  set dailCode1(String? val) => _dailCode1 = val;

  bool hasDailCode1() => _dailCode1 != null;

  // "phone1" field.
  String? _phone1;
  String get phone1 => _phone1 ?? '';
  set phone1(String? val) => _phone1 = val;

  bool hasPhone1() => _phone1 != null;

  // "dail_code2" field.
  String? _dailCode2;
  String get dailCode2 => _dailCode2 ?? '';
  set dailCode2(String? val) => _dailCode2 = val;

  bool hasDailCode2() => _dailCode2 != null;

  // "phone2" field.
  String? _phone2;
  String get phone2 => _phone2 ?? '';
  set phone2(String? val) => _phone2 = val;

  bool hasPhone2() => _phone2 != null;

  // "flat_number" field.
  String? _flatNumber;
  String get flatNumber => _flatNumber ?? '';
  set flatNumber(String? val) => _flatNumber = val;

  bool hasFlatNumber() => _flatNumber != null;

  // "street1" field.
  String? _street1;
  String get street1 => _street1 ?? '';
  set street1(String? val) => _street1 = val;

  bool hasStreet1() => _street1 != null;

  // "street2" field.
  String? _street2;
  String get street2 => _street2 ?? '';
  set street2(String? val) => _street2 = val;

  bool hasStreet2() => _street2 != null;

  // "city" field.
  String? _city;
  String get city => _city ?? '';
  set city(String? val) => _city = val;

  bool hasCity() => _city != null;

  // "state" field.
  String? _state;
  String get state => _state ?? '';
  set state(String? val) => _state = val;

  bool hasState() => _state != null;

  // "country" field.
  String? _country;
  String get country => _country ?? '';
  set country(String? val) => _country = val;

  bool hasCountry() => _country != null;

  // "pincode" field.
  int? _pincode;
  int get pincode => _pincode ?? 0;
  set pincode(int? val) => _pincode = val;

  void incrementPincode(int amount) => pincode = pincode + amount;

  bool hasPincode() => _pincode != null;

  // "land_mark" field.
  String? _landMark;
  String get landMark => _landMark ?? '';
  set landMark(String? val) => _landMark = val;

  bool hasLandMark() => _landMark != null;

  // "gmap_link" field.
  String? _gmapLink;
  String get gmapLink => _gmapLink ?? '';
  set gmapLink(String? val) => _gmapLink = val;

  bool hasGmapLink() => _gmapLink != null;

  // "gmap_lat_lan" field.
  LatLng? _gmapLatLan;
  LatLng? get gmapLatLan => _gmapLatLan;
  set gmapLatLan(LatLng? val) => _gmapLatLan = val;

  bool hasGmapLatLan() => _gmapLatLan != null;

  static UserAddressStruct fromMap(Map<String, dynamic> data) =>
      UserAddressStruct(
        name: data['name'] as String?,
        email: data['email'] as String?,
        dailCode1: data['dail_code1'] as String?,
        phone1: data['phone1'] as String?,
        dailCode2: data['dail_code2'] as String?,
        phone2: data['phone2'] as String?,
        flatNumber: data['flat_number'] as String?,
        street1: data['street1'] as String?,
        street2: data['street2'] as String?,
        city: data['city'] as String?,
        state: data['state'] as String?,
        country: data['country'] as String?,
        pincode: castToType<int>(data['pincode']),
        landMark: data['land_mark'] as String?,
        gmapLink: data['gmap_link'] as String?,
        gmapLatLan: data['gmap_lat_lan'] as LatLng?,
      );

  static UserAddressStruct? maybeFromMap(dynamic data) => data is Map
      ? UserAddressStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'name': _name,
        'email': _email,
        'dail_code1': _dailCode1,
        'phone1': _phone1,
        'dail_code2': _dailCode2,
        'phone2': _phone2,
        'flat_number': _flatNumber,
        'street1': _street1,
        'street2': _street2,
        'city': _city,
        'state': _state,
        'country': _country,
        'pincode': _pincode,
        'land_mark': _landMark,
        'gmap_link': _gmapLink,
        'gmap_lat_lan': _gmapLatLan,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'email': serializeParam(
          _email,
          ParamType.String,
        ),
        'dail_code1': serializeParam(
          _dailCode1,
          ParamType.String,
        ),
        'phone1': serializeParam(
          _phone1,
          ParamType.String,
        ),
        'dail_code2': serializeParam(
          _dailCode2,
          ParamType.String,
        ),
        'phone2': serializeParam(
          _phone2,
          ParamType.String,
        ),
        'flat_number': serializeParam(
          _flatNumber,
          ParamType.String,
        ),
        'street1': serializeParam(
          _street1,
          ParamType.String,
        ),
        'street2': serializeParam(
          _street2,
          ParamType.String,
        ),
        'city': serializeParam(
          _city,
          ParamType.String,
        ),
        'state': serializeParam(
          _state,
          ParamType.String,
        ),
        'country': serializeParam(
          _country,
          ParamType.String,
        ),
        'pincode': serializeParam(
          _pincode,
          ParamType.int,
        ),
        'land_mark': serializeParam(
          _landMark,
          ParamType.String,
        ),
        'gmap_link': serializeParam(
          _gmapLink,
          ParamType.String,
        ),
        'gmap_lat_lan': serializeParam(
          _gmapLatLan,
          ParamType.LatLng,
        ),
      }.withoutNulls;

  static UserAddressStruct fromSerializableMap(Map<String, dynamic> data) =>
      UserAddressStruct(
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        email: deserializeParam(
          data['email'],
          ParamType.String,
          false,
        ),
        dailCode1: deserializeParam(
          data['dail_code1'],
          ParamType.String,
          false,
        ),
        phone1: deserializeParam(
          data['phone1'],
          ParamType.String,
          false,
        ),
        dailCode2: deserializeParam(
          data['dail_code2'],
          ParamType.String,
          false,
        ),
        phone2: deserializeParam(
          data['phone2'],
          ParamType.String,
          false,
        ),
        flatNumber: deserializeParam(
          data['flat_number'],
          ParamType.String,
          false,
        ),
        street1: deserializeParam(
          data['street1'],
          ParamType.String,
          false,
        ),
        street2: deserializeParam(
          data['street2'],
          ParamType.String,
          false,
        ),
        city: deserializeParam(
          data['city'],
          ParamType.String,
          false,
        ),
        state: deserializeParam(
          data['state'],
          ParamType.String,
          false,
        ),
        country: deserializeParam(
          data['country'],
          ParamType.String,
          false,
        ),
        pincode: deserializeParam(
          data['pincode'],
          ParamType.int,
          false,
        ),
        landMark: deserializeParam(
          data['land_mark'],
          ParamType.String,
          false,
        ),
        gmapLink: deserializeParam(
          data['gmap_link'],
          ParamType.String,
          false,
        ),
        gmapLatLan: deserializeParam(
          data['gmap_lat_lan'],
          ParamType.LatLng,
          false,
        ),
      );

  @override
  String toString() => 'UserAddressStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is UserAddressStruct &&
        name == other.name &&
        email == other.email &&
        dailCode1 == other.dailCode1 &&
        phone1 == other.phone1 &&
        dailCode2 == other.dailCode2 &&
        phone2 == other.phone2 &&
        flatNumber == other.flatNumber &&
        street1 == other.street1 &&
        street2 == other.street2 &&
        city == other.city &&
        state == other.state &&
        country == other.country &&
        pincode == other.pincode &&
        landMark == other.landMark &&
        gmapLink == other.gmapLink &&
        gmapLatLan == other.gmapLatLan;
  }

  @override
  int get hashCode => const ListEquality().hash([
        name,
        email,
        dailCode1,
        phone1,
        dailCode2,
        phone2,
        flatNumber,
        street1,
        street2,
        city,
        state,
        country,
        pincode,
        landMark,
        gmapLink,
        gmapLatLan
      ]);
}

UserAddressStruct createUserAddressStruct({
  String? name,
  String? email,
  String? dailCode1,
  String? phone1,
  String? dailCode2,
  String? phone2,
  String? flatNumber,
  String? street1,
  String? street2,
  String? city,
  String? state,
  String? country,
  int? pincode,
  String? landMark,
  String? gmapLink,
  LatLng? gmapLatLan,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    UserAddressStruct(
      name: name,
      email: email,
      dailCode1: dailCode1,
      phone1: phone1,
      dailCode2: dailCode2,
      phone2: phone2,
      flatNumber: flatNumber,
      street1: street1,
      street2: street2,
      city: city,
      state: state,
      country: country,
      pincode: pincode,
      landMark: landMark,
      gmapLink: gmapLink,
      gmapLatLan: gmapLatLan,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

UserAddressStruct? updateUserAddressStruct(
  UserAddressStruct? userAddress, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    userAddress
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addUserAddressStructData(
  Map<String, dynamic> firestoreData,
  UserAddressStruct? userAddress,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (userAddress == null) {
    return;
  }
  if (userAddress.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && userAddress.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final userAddressData =
      getUserAddressFirestoreData(userAddress, forFieldValue);
  final nestedData =
      userAddressData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = userAddress.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getUserAddressFirestoreData(
  UserAddressStruct? userAddress, [
  bool forFieldValue = false,
]) {
  if (userAddress == null) {
    return {};
  }
  final firestoreData = mapToFirestore(userAddress.toMap());

  // Add any Firestore field values
  mapToFirestore(userAddress.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getUserAddressListFirestoreData(
  List<UserAddressStruct>? userAddresss,
) =>
    userAddresss?.map((e) => getUserAddressFirestoreData(e, true)).toList() ??
    [];
