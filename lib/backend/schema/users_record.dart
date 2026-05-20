import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UsersRecord extends FirestoreRecord {
  UsersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "user_role" field.
  String? _userRole;
  String get userRole => _userRole ?? '';
  bool hasUserRole() => _userRole != null;

  // "user_id" field.
  int? _userId;
  int get userId => _userId ?? 0;
  bool hasUserId() => _userId != null;

  // "wallet_Point" field.
  int? _walletPoint;
  int get walletPoint => _walletPoint ?? 0;
  bool hasWalletPoint() => _walletPoint != null;

  // "country" field.
  String? _country;
  String get country => _country ?? '';
  bool hasCountry() => _country != null;

  // "language" field.
  String? _language;
  String get language => _language ?? '';
  bool hasLanguage() => _language != null;

  // "wallet_Spent" field.
  int? _walletSpent;
  int get walletSpent => _walletSpent ?? 0;
  bool hasWalletSpent() => _walletSpent != null;

  // "present_room_game_info" field.
  PresentRoomGameInfoStruct? _presentRoomGameInfo;
  PresentRoomGameInfoStruct get presentRoomGameInfo =>
      _presentRoomGameInfo ?? PresentRoomGameInfoStruct();
  bool hasPresentRoomGameInfo() => _presentRoomGameInfo != null;

  // "date_birth" field.
  DateTime? _dateBirth;
  DateTime? get dateBirth => _dateBirth;
  bool hasDateBirth() => _dateBirth != null;

  // "gender" field.
  String? _gender;
  String get gender => _gender ?? '';
  bool hasGender() => _gender != null;

  // "user_setting" field.
  UserSettingStruct? _userSetting;
  UserSettingStruct get userSetting => _userSetting ?? UserSettingStruct();
  bool hasUserSetting() => _userSetting != null;

  // "user_address" field.
  UserAddressStruct? _userAddress;
  UserAddressStruct get userAddress => _userAddress ?? UserAddressStruct();
  bool hasUserAddress() => _userAddress != null;

  // "complete_profile_status" field.
  bool? _completeProfileStatus;
  bool get completeProfileStatus => _completeProfileStatus ?? false;
  bool hasCompleteProfileStatus() => _completeProfileStatus != null;

  // "user_verification" field.
  UserVerificationStruct? _userVerification;
  UserVerificationStruct get userVerification =>
      _userVerification ?? UserVerificationStruct();
  bool hasUserVerification() => _userVerification != null;

  // "is_phone_verification" field.
  bool? _isPhoneVerification;
  bool get isPhoneVerification => _isPhoneVerification ?? false;
  bool hasIsPhoneVerification() => _isPhoneVerification != null;

  // "is_walkthrough_status" field.
  bool? _isWalkthroughStatus;
  bool get isWalkthroughStatus => _isWalkthroughStatus ?? false;
  bool hasIsWalkthroughStatus() => _isWalkthroughStatus != null;

  // "app_launch_time_user" field.
  bool? _appLaunchTimeUser;
  bool get appLaunchTimeUser => _appLaunchTimeUser ?? false;
  bool hasAppLaunchTimeUser() => _appLaunchTimeUser != null;

  void _initializeFields() {
    _email = snapshotData['email'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _uid = snapshotData['uid'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _status = snapshotData['status'] as String?;
    _userRole = snapshotData['user_role'] as String?;
    _userId = castToType<int>(snapshotData['user_id']);
    _walletPoint = castToType<int>(snapshotData['wallet_Point']);
    _country = snapshotData['country'] as String?;
    _language = snapshotData['language'] as String?;
    _walletSpent = castToType<int>(snapshotData['wallet_Spent']);
    _presentRoomGameInfo =
        snapshotData['present_room_game_info'] is PresentRoomGameInfoStruct
            ? snapshotData['present_room_game_info']
            : PresentRoomGameInfoStruct.maybeFromMap(
                snapshotData['present_room_game_info']);
    _dateBirth = snapshotData['date_birth'] as DateTime?;
    _gender = snapshotData['gender'] as String?;
    _userSetting = snapshotData['user_setting'] is UserSettingStruct
        ? snapshotData['user_setting']
        : UserSettingStruct.maybeFromMap(snapshotData['user_setting']);
    _userAddress = snapshotData['user_address'] is UserAddressStruct
        ? snapshotData['user_address']
        : UserAddressStruct.maybeFromMap(snapshotData['user_address']);
    _completeProfileStatus = snapshotData['complete_profile_status'] as bool?;
    _userVerification =
        snapshotData['user_verification'] is UserVerificationStruct
            ? snapshotData['user_verification']
            : UserVerificationStruct.maybeFromMap(
                snapshotData['user_verification']);
    _isPhoneVerification = snapshotData['is_phone_verification'] as bool?;
    _isWalkthroughStatus = snapshotData['is_walkthrough_status'] as bool?;
    _appLaunchTimeUser = snapshotData['app_launch_time_user'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UsersRecord.fromSnapshot(s));

  static Future<UsersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UsersRecord.fromSnapshot(s));

  static UsersRecord fromSnapshot(DocumentSnapshot snapshot) => UsersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UsersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UsersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UsersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UsersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUsersRecordData({
  String? email,
  String? displayName,
  String? photoUrl,
  String? uid,
  DateTime? createdTime,
  String? phoneNumber,
  String? status,
  String? userRole,
  int? userId,
  int? walletPoint,
  String? country,
  String? language,
  int? walletSpent,
  PresentRoomGameInfoStruct? presentRoomGameInfo,
  DateTime? dateBirth,
  String? gender,
  UserSettingStruct? userSetting,
  UserAddressStruct? userAddress,
  bool? completeProfileStatus,
  UserVerificationStruct? userVerification,
  bool? isPhoneVerification,
  bool? isWalkthroughStatus,
  bool? appLaunchTimeUser,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'email': email,
      'display_name': displayName,
      'photo_url': photoUrl,
      'uid': uid,
      'created_time': createdTime,
      'phone_number': phoneNumber,
      'status': status,
      'user_role': userRole,
      'user_id': userId,
      'wallet_Point': walletPoint,
      'country': country,
      'language': language,
      'wallet_Spent': walletSpent,
      'present_room_game_info': PresentRoomGameInfoStruct().toMap(),
      'date_birth': dateBirth,
      'gender': gender,
      'user_setting': UserSettingStruct().toMap(),
      'user_address': UserAddressStruct().toMap(),
      'complete_profile_status': completeProfileStatus,
      'user_verification': UserVerificationStruct().toMap(),
      'is_phone_verification': isPhoneVerification,
      'is_walkthrough_status': isWalkthroughStatus,
      'app_launch_time_user': appLaunchTimeUser,
    }.withoutNulls,
  );

  // Handle nested data for "present_room_game_info" field.
  addPresentRoomGameInfoStructData(
      firestoreData, presentRoomGameInfo, 'present_room_game_info');

  // Handle nested data for "user_setting" field.
  addUserSettingStructData(firestoreData, userSetting, 'user_setting');

  // Handle nested data for "user_address" field.
  addUserAddressStructData(firestoreData, userAddress, 'user_address');

  // Handle nested data for "user_verification" field.
  addUserVerificationStructData(
      firestoreData, userVerification, 'user_verification');

  return firestoreData;
}

class UsersRecordDocumentEquality implements Equality<UsersRecord> {
  const UsersRecordDocumentEquality();

  @override
  bool equals(UsersRecord? e1, UsersRecord? e2) {
    return e1?.email == e2?.email &&
        e1?.displayName == e2?.displayName &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.uid == e2?.uid &&
        e1?.createdTime == e2?.createdTime &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.status == e2?.status &&
        e1?.userRole == e2?.userRole &&
        e1?.userId == e2?.userId &&
        e1?.walletPoint == e2?.walletPoint &&
        e1?.country == e2?.country &&
        e1?.language == e2?.language &&
        e1?.walletSpent == e2?.walletSpent &&
        e1?.presentRoomGameInfo == e2?.presentRoomGameInfo &&
        e1?.dateBirth == e2?.dateBirth &&
        e1?.gender == e2?.gender &&
        e1?.userSetting == e2?.userSetting &&
        e1?.userAddress == e2?.userAddress &&
        e1?.completeProfileStatus == e2?.completeProfileStatus &&
        e1?.userVerification == e2?.userVerification &&
        e1?.isPhoneVerification == e2?.isPhoneVerification &&
        e1?.isWalkthroughStatus == e2?.isWalkthroughStatus &&
        e1?.appLaunchTimeUser == e2?.appLaunchTimeUser;
  }

  @override
  int hash(UsersRecord? e) => const ListEquality().hash([
        e?.email,
        e?.displayName,
        e?.photoUrl,
        e?.uid,
        e?.createdTime,
        e?.phoneNumber,
        e?.status,
        e?.userRole,
        e?.userId,
        e?.walletPoint,
        e?.country,
        e?.language,
        e?.walletSpent,
        e?.presentRoomGameInfo,
        e?.dateBirth,
        e?.gender,
        e?.userSetting,
        e?.userAddress,
        e?.completeProfileStatus,
        e?.userVerification,
        e?.isPhoneVerification,
        e?.isWalkthroughStatus,
        e?.appLaunchTimeUser
      ]);

  @override
  bool isValidKey(Object? o) => o is UsersRecord;
}
