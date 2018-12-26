import 'package:LoginUI/model/UserProfile.dart';
import 'package:LoginUI/userprofile/UserProfileState.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatefulWidget{

  String user;

  UserProfilePage(@required this.user);

  @override
  UserProfileState createState() => UserProfileState(user);
}