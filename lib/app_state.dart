import 'package:flutter/material.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/api_requests/api_manager.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:csv/csv.dart';
import 'package:synchronized/synchronized.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    secureStorage = FlutterSecureStorage();
    await _safeInitAsync(() async {
      _Onboard = await secureStorage.getString('ff_Onboard') ?? _Onboard;
    });
    await _safeInitAsync(() async {
      _appLang = await secureStorage.getString('ff_appLang') ?? _appLang;
    });
    await _safeInitAsync(() async {
      if (await secureStorage.read(key: 'ff_userflow') != null) {
        try {
          final serializedData =
              await secureStorage.getString('ff_userflow') ?? '{}';
          _userflow =
              UserflowStruct.fromSerializableMap(jsonDecode(serializedData));
        } catch (e) {
          print("Can't decode persisted data type. Error: $e.");
        }
      }
    });
    await _safeInitAsync(() async {
      _refresh = await secureStorage.getInt('ff_refresh') ?? _refresh;
    });
    await _safeInitAsync(() async {
      if (await secureStorage.read(key: 'ff_gameInfo') != null) {
        try {
          final serializedData =
              await secureStorage.getString('ff_gameInfo') ?? '{}';
          _gameInfo =
              MainInfoStruct.fromSerializableMap(jsonDecode(serializedData));
        } catch (e) {
          print("Can't decode persisted data type. Error: $e.");
        }
      }
    });
    await _safeInitAsync(() async {
      _gameZoneSteps =
          await secureStorage.getInt('ff_gameZoneSteps') ?? _gameZoneSteps;
    });
    await _safeInitAsync(() async {
      _helpLineStatus =
          await secureStorage.getBool('ff_helpLineStatus') ?? _helpLineStatus;
    });
    await _safeInitAsync(() async {
      _QRvalue = await secureStorage.getString('ff_QRvalue') ?? _QRvalue;
    });
    await _safeInitAsync(() async {
      _currentUserRef =
          (await secureStorage.getString('ff_currentUserRef'))?.ref ??
              _currentUserRef;
    });
    await _safeInitAsync(() async {
      _walkStatus = await secureStorage.getBool('ff_walkStatus') ?? _walkStatus;
    });
    await _safeInitAsync(() async {
      _listedQuestionIDList =
          (await secureStorage.getStringList('ff_listedQuestionIDList'))
                  ?.map(int.parse)
                  .toList() ??
              _listedQuestionIDList;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late FlutterSecureStorage secureStorage;

  String _Onboard = 'start';
  String get Onboard => _Onboard;
  set Onboard(String value) {
    _Onboard = value;
    secureStorage.setString('ff_Onboard', value);
  }

  void deleteOnboard() {
    secureStorage.delete(key: 'ff_Onboard');
  }

  String _appLang = 'ar';
  String get appLang => _appLang;
  set appLang(String value) {
    _appLang = value;
    secureStorage.setString('ff_appLang', value);
  }

  void deleteAppLang() {
    secureStorage.delete(key: 'ff_appLang');
  }

  UserflowStruct _userflow = UserflowStruct();
  UserflowStruct get userflow => _userflow;
  set userflow(UserflowStruct value) {
    _userflow = value;
    secureStorage.setString('ff_userflow', value.serialize());
  }

  void deleteUserflow() {
    secureStorage.delete(key: 'ff_userflow');
  }

  void updateUserflowStruct(Function(UserflowStruct) updateFn) {
    updateFn(_userflow);
    secureStorage.setString('ff_userflow', _userflow.serialize());
  }

  int _refresh = 1;
  int get refresh => _refresh;
  set refresh(int value) {
    _refresh = value;
    secureStorage.setInt('ff_refresh', value);
  }

  void deleteRefresh() {
    secureStorage.delete(key: 'ff_refresh');
  }

  MainInfoStruct _gameInfo = MainInfoStruct();
  MainInfoStruct get gameInfo => _gameInfo;
  set gameInfo(MainInfoStruct value) {
    _gameInfo = value;
    secureStorage.setString('ff_gameInfo', value.serialize());
  }

  void deleteGameInfo() {
    secureStorage.delete(key: 'ff_gameInfo');
  }

  void updateGameInfoStruct(Function(MainInfoStruct) updateFn) {
    updateFn(_gameInfo);
    secureStorage.setString('ff_gameInfo', _gameInfo.serialize());
  }

  List<int> _teamInputFields = [];
  List<int> get teamInputFields => _teamInputFields;
  set teamInputFields(List<int> value) {
    _teamInputFields = value;
  }

  void addToTeamInputFields(int value) {
    teamInputFields.add(value);
  }

  void removeFromTeamInputFields(int value) {
    teamInputFields.remove(value);
  }

  void removeAtIndexFromTeamInputFields(int index) {
    teamInputFields.removeAt(index);
  }

  void updateTeamInputFieldsAtIndex(
    int index,
    int Function(int) updateFn,
  ) {
    teamInputFields[index] = updateFn(_teamInputFields[index]);
  }

  void insertAtIndexInTeamInputFields(int index, int value) {
    teamInputFields.insert(index, value);
  }

  int _gameZoneSteps = 1;
  int get gameZoneSteps => _gameZoneSteps;
  set gameZoneSteps(int value) {
    _gameZoneSteps = value;
    secureStorage.setInt('ff_gameZoneSteps', value);
  }

  void deleteGameZoneSteps() {
    secureStorage.delete(key: 'ff_gameZoneSteps');
  }

  bool _helpLineStatus = false;
  bool get helpLineStatus => _helpLineStatus;
  set helpLineStatus(bool value) {
    _helpLineStatus = value;
    secureStorage.setBool('ff_helpLineStatus', value);
  }

  void deleteHelpLineStatus() {
    secureStorage.delete(key: 'ff_helpLineStatus');
  }

  String _QRvalue = 'null';
  String get QRvalue => _QRvalue;
  set QRvalue(String value) {
    _QRvalue = value;
    secureStorage.setString('ff_QRvalue', value);
  }

  void deleteQRvalue() {
    secureStorage.delete(key: 'ff_QRvalue');
  }

  DocumentReference? _currentUserRef;
  DocumentReference? get currentUserRef => _currentUserRef;
  set currentUserRef(DocumentReference? value) {
    _currentUserRef = value;
    value != null
        ? secureStorage.setString('ff_currentUserRef', value.path)
        : secureStorage.remove('ff_currentUserRef');
  }

  void deleteCurrentUserRef() {
    secureStorage.delete(key: 'ff_currentUserRef');
  }

  bool _walkStatus = false;
  bool get walkStatus => _walkStatus;
  set walkStatus(bool value) {
    _walkStatus = value;
    secureStorage.setBool('ff_walkStatus', value);
  }

  void deleteWalkStatus() {
    secureStorage.delete(key: 'ff_walkStatus');
  }

  List<int> _listedQuestionIDList = [];
  List<int> get listedQuestionIDList => _listedQuestionIDList;
  set listedQuestionIDList(List<int> value) {
    _listedQuestionIDList = value;
    secureStorage.setStringList(
        'ff_listedQuestionIDList', value.map((x) => x.toString()).toList());
  }

  void deleteListedQuestionIDList() {
    secureStorage.delete(key: 'ff_listedQuestionIDList');
  }

  void addToListedQuestionIDList(int value) {
    listedQuestionIDList.add(value);
    secureStorage.setStringList('ff_listedQuestionIDList',
        _listedQuestionIDList.map((x) => x.toString()).toList());
  }

  void removeFromListedQuestionIDList(int value) {
    listedQuestionIDList.remove(value);
    secureStorage.setStringList('ff_listedQuestionIDList',
        _listedQuestionIDList.map((x) => x.toString()).toList());
  }

  void removeAtIndexFromListedQuestionIDList(int index) {
    listedQuestionIDList.removeAt(index);
    secureStorage.setStringList('ff_listedQuestionIDList',
        _listedQuestionIDList.map((x) => x.toString()).toList());
  }

  void updateListedQuestionIDListAtIndex(
    int index,
    int Function(int) updateFn,
  ) {
    listedQuestionIDList[index] = updateFn(_listedQuestionIDList[index]);
    secureStorage.setStringList('ff_listedQuestionIDList',
        _listedQuestionIDList.map((x) => x.toString()).toList());
  }

  void insertAtIndexInListedQuestionIDList(int index, int value) {
    listedQuestionIDList.insert(index, value);
    secureStorage.setStringList('ff_listedQuestionIDList',
        _listedQuestionIDList.map((x) => x.toString()).toList());
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}

extension FlutterSecureStorageExtensions on FlutterSecureStorage {
  static final _lock = Lock();

  Future<void> writeSync({required String key, String? value}) async =>
      await _lock.synchronized(() async {
        await write(key: key, value: value);
      });

  void remove(String key) => delete(key: key);

  Future<String?> getString(String key) async => await read(key: key);
  Future<void> setString(String key, String value) async =>
      await writeSync(key: key, value: value);

  Future<bool?> getBool(String key) async => (await read(key: key)) == 'true';
  Future<void> setBool(String key, bool value) async =>
      await writeSync(key: key, value: value.toString());

  Future<int?> getInt(String key) async =>
      int.tryParse(await read(key: key) ?? '');
  Future<void> setInt(String key, int value) async =>
      await writeSync(key: key, value: value.toString());

  Future<double?> getDouble(String key) async =>
      double.tryParse(await read(key: key) ?? '');
  Future<void> setDouble(String key, double value) async =>
      await writeSync(key: key, value: value.toString());

  Future<List<String>?> getStringList(String key) async =>
      await read(key: key).then((result) {
        if (result == null || result.isEmpty) {
          return null;
        }
        return CsvToListConverter()
            .convert(result)
            .first
            .map((e) => e.toString())
            .toList();
      });
  Future<void> setStringList(String key, List<String> value) async =>
      await writeSync(key: key, value: ListToCsvConverter().convert([value]));
}
