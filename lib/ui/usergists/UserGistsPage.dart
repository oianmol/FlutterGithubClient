import 'package:LoginUI/ui/usergists/UserGistsPageState.dart';
import 'package:flutter/material.dart';


class UserGistsPage extends StatefulWidget {

  String loginName;

  UserGistsPage(String username, {Key key}) : super(key: key){
    this.loginName = username;
  }

  @override
  UserGistsPageState createState() => new UserGistsPageState(loginName);
}