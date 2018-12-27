import 'package:LoginUI/model/UserProfile.dart';
import 'package:LoginUI/userprofile/UserProfileHeaderState.dart';
import 'package:flutter/material.dart';

class UserProfileHeader extends StatefulWidget {

  UserProfile userProfile;

  UserProfileHeader(@required this.userProfile);

  @override
  UserProfileHeaderState createState() => UserProfileHeaderState(userProfile: userProfile);
}
