import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper{
 static Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  static Future<bool> getBool(String key) async {
    final p = await prefs;
    return p.getBool(key) ?? false;
  }

  static Future setBool(String key, bool value) async {
    final p = await prefs;
     p.setBool(key, value);
  }


 static Future<String> getString(String key) async {
   final p = await prefs;
   return p.getString(key) ?? "null";
 }

 static Future setString(String key, String value) async {
   final p = await prefs;
   p.setString(key, value);
 }

}