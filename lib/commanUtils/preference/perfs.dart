import 'package:chat_app/commanUtils/const.dart';
import 'package:chat_app/commanUtils/preference/prefs_helper.dart';

class Prefs{
  static Future setIsLogin(bool val) =>
      PreferencesHelper.setBool(CONST.IS_LOGIN_KEY, val);

  static Future getIsLogin()=>
      PreferencesHelper.getBool(CONST.IS_LOGIN_KEY);

  static Future setUserToken(String value) =>
      PreferencesHelper.setString(CONST.USER_TOKEN, value);

  static Future<String> get getUserToken =>
      PreferencesHelper.getString(CONST.USER_TOKEN);

  static Future setCurrentUser(String value) =>
      PreferencesHelper.setString(CONST.CURRENT_USER_KEY, value);

  static Future<String> get getCurrentUser =>
      PreferencesHelper.getString(CONST.CURRENT_USER_KEY);
}