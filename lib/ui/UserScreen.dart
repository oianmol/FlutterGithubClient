import 'package:LoginUI/ui/UserScreenState.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  String data;

  UserScreen({Key key, this.data}) : super(key: key);

  @override
  UserScreenState createState() => new UserScreenState();
}