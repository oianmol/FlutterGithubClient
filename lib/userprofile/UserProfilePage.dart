import 'package:LoginUI/ui/data/User.dart';
import 'package:LoginUI/userprofile/UserProfileState.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatefulWidget{

  User user;

  UserProfilePage(@required this.user);

  @override
  UserProfileState createState() => UserProfileState(user);
}