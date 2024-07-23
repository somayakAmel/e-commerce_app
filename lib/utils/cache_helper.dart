import 'package:shared_preferences/shared_preferences.dart';

//CacheHelper That's Connect and Talk to local database.
class CacheHelper {
  static late SharedPreferences sharedPreferences;

  //Initialization on shared preferences that should be called before runApp.
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  //Save data in shared preferences.
  static Future<bool> saveData(
      {required String key, required dynamic value}) async {
    if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    }
    if (value is String) {
      return await sharedPreferences.setString(key, value);
    }
    if (value is int) {
      return await sharedPreferences.setInt(key, value);
    }
    if (value is double) {
      return await sharedPreferences.setDouble(key, value);
    }
    return false;
  }

  //Checking if this key is being saved in the shared preferences.
  static bool checkForData({required String key}) {
    return sharedPreferences.containsKey(key);
  }

  //Getting data from shared preferences.
  static dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }

  //Delete data for a single key.
  static Future<bool> removeData({required String key}) async {
    return await sharedPreferences.remove(key);
  }

  //Delete all saved data.
  static Future<bool> clearData() async {
    return await sharedPreferences.clear();
  }
}
