import 'package:anexpress/core/extensions/log_extension.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelpers {
  Future<void> setStringData(
      {required String key, required String text}) async {
    "inside setStringData  userInfo:$text".log();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, text);
  }

  Future<void> setIntData({required String key, required int id}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, id);
  }

  Future<void> setBoolData({required String key, required bool value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  Future<String?> getStringData({required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<int?> getIntData({required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  Future<bool?> getBoolData({required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  Future<void> removeSingleKey({required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  Future<void> clearAllPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
