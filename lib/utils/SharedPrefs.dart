import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs{

  static final SharedPrefs _instance = new SharedPrefs._internal();
  final String _token ="TOKEN";
  final String _currenUserProfile ="CURRENT_USER_PROFILE";


  factory SharedPrefs(){
    return _instance;
  }

  SharedPrefs._internal();

  void saveToken(String token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(_token, token);
  }

  Future<bool> clear() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.clear();
  }

  Future<String> getToken()async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return  pref.getString(_token);
  }

  void saveCurrentUserProfile(String userProfileJson) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(_currenUserProfile, userProfileJson);
  } 

  Future<String> getCurrentUserProfile() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return json.decode(pref.getString(_currenUserProfile));
  }
}