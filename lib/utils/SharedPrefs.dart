import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs{

  static final SharedPrefs _instance = new SharedPrefs._internal();
  final String _token ="TOKEN";


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


}