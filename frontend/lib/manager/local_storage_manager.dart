import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorage {
  static const String _coursePreferenceKey = "course-preference-key@123";
  static const String _tnpCookieKey = "tnp-cookie-key@827";

  static late final SharedPreferences _prefs;

  static void init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> saveCoursePreference(String preference) async {
    return await _prefs.setString(_coursePreferenceKey, preference);
  }

  static Future<bool> saveCookie(String cookie) async {
    return await _prefs.setString(_tnpCookieKey, cookie);
  }

  static String? getCookie() {
    return _prefs.getString(_tnpCookieKey);
  }

  static Future<bool> deleteCoursePreference() async {
    return await _prefs.remove(_coursePreferenceKey);
  }

  static String? getCoursePreference() {
    return _prefs.getString(_coursePreferenceKey);
  }
}
