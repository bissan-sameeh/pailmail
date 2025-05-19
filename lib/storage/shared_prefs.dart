import 'package:pailmail/models/users/user_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


enum PrefKeys { loggedIn, email, id, image, name, token, roleId, role }

class SharedPreferencesController {
  static final SharedPreferencesController _instance =
      SharedPreferencesController._();
  late SharedPreferences _sharedPreferences;

  SharedPreferencesController._();

  factory SharedPreferencesController() {
    return _instance;
  }

  Future<void> initPref() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> saveAuth(
      {required UserResponseModel userModel, required bool isLogin}) async {
    // print('ave auth shared preferences: ');
    await _sharedPreferences.setBool(PrefKeys.loggedIn.toString(), true);
    await _sharedPreferences.setInt(
        PrefKeys.id.toString(), userModel.user.id!);
    await _sharedPreferences.setString(
        PrefKeys.roleId.toString(), userModel.user.roleId.toString() ??'');
    await _sharedPreferences.setString(
        PrefKeys.email.toString(), userModel.user.email.toString());
    await _sharedPreferences.setString(
        PrefKeys.name.toString(), userModel.user.name.toString());
    await _sharedPreferences.setString(
        PrefKeys.token.toString(), 'Bearer ${userModel.token}');
    await _sharedPreferences.setString(
        PrefKeys.role.toString(), userModel.user.role!.name.toString());
    if (isLogin) {
      await _sharedPreferences.setString(
          PrefKeys.image.toString(), userModel.user.image.toString());
    }
  }

  Future<bool?> setData(String key, dynamic data) async {
    switch (data.runtimeType) {
      case int:
        return _sharedPreferences.setInt(key, data);
      case String:
        return _sharedPreferences.setString(key, data);
      case bool:
        return _sharedPreferences.setBool(key, data);
    }
    return null;
  }

  bool get loggedIn =>
      _sharedPreferences.getBool(PrefKeys.loggedIn.toString()) ?? false;
  String get email =>
      _sharedPreferences.getString(PrefKeys.email.toString()) ?? '';
  String get name =>
      _sharedPreferences.getString(PrefKeys.name.toString()) ?? '';
  String get roleId => _sharedPreferences.getString(PrefKeys.roleId.toString()) ??
  '1';
  int get id => _sharedPreferences.getInt(PrefKeys.id.toString()) ??0;
  String get image =>
      _sharedPreferences.getString(PrefKeys.image.toString()) ?? '';
  String get token =>
      _sharedPreferences.getString(PrefKeys.token.toString()) ?? '';
  String get roleName =>
      _sharedPreferences.getString(PrefKeys.role.toString()) ??
      'not found role';

  //
  // Future<dynamic> getData(String key) async {
  //   if (_sharedPreferences.containsKey(key)) {
  //     return _sharedPreferences.get(key);
  //   }
  // }

// Future<T?> getValueFor<T>(String key) async {
//   await _checkInstance();
//   if (_sharedPreferences!.containsKey(key)) {
//     return _prefs?.get(key) as T;
//   }
//   return null;
// }
  // bool get loggedIn =>
  //     _sharedPreferences.getBool(PrefKeys.loggedIn.toString()) ?? false;
  //
  // String get email =>
  //     _sharedPreferences.getString(PrefKeys.email.toString()) ?? ' ';

  Future<bool> remove({required String key}) async {
    if (_sharedPreferences.containsKey(key)) {
      return await _sharedPreferences.remove(key);
    }
    return false;
  }

  Future<bool> clear() async {
    print('------------------clear-----------------------');
    return await _sharedPreferences.clear();
  }
}
