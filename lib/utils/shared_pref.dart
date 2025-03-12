import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late final SharedPreferences instance;

  static Future<SharedPreferences> init() async => instance = await SharedPreferences.getInstance();

  /// set value
  static void setBool({required String key, required bool value}) =>
      instance.setBool(key, value);

  static void setDouble({required String key, required double value}) =>
      instance.setDouble(key, value);

  static void setInt({required String key, required int value}) =>
      instance.setInt(key, value);

  static void setString({required String key, required String value}) =>
      instance.setString(key, value);

  static void setStringList(
          {required String key, required List<String> value}) =>
      instance.setStringList(key, value);

  /// get value
  static bool getBool({required String key}) => instance.getBool(key) ?? false;

  static double getDouble({required String key}) => instance.getDouble(key) ?? 0.0;

  static int getInt({required String key}) => instance.getInt(key) ?? 0;

  static String getString({required String key}) =>
      instance.getString(key) ?? '';

  static List<String> getStringList({required String key}) =>
      instance.getStringList(key) ?? [];

  static clearSession() async {
    await instance.clear();
  }
//   Future<void> saveToken(String token) async {
//   final prefs = await SharedPreferences.getInstance();
//   await prefs.setString('token', token);
// }
static const String _tokenKey = 'token';

  // Save the token
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  // Retrieve the token
  // Future<String?> getToken() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(_tokenKey);
  // }

  // Remove the token (if needed)
  Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }
}
