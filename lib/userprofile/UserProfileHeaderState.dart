import 'package:LoginUI/Routes.dart';
import 'package:LoginUI/main.dart';
import 'package:LoginUI/model/UserProfile.dart';
import 'package:LoginUI/ui/base/BaseStatefulState.dart';
import 'package:LoginUI/userprofile/UserProfileHeader.dart';
import 'package:flutter/material.dart';

class UserProfileHeaderState extends BaseStatefulState<UserProfileHeader> {
  final UserProfile userProfile;

  UserProfileHeaderState({userProfile: UserProfile})
      : this.userProfile = userProfile;

  userImageWidget() {
    return Expanded(
        flex: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                child: new CircleAvatar(
              backgroundImage: new NetworkImage(userProfile.avatarUrl),
              radius: 40.0,
            )),
          ],
        ));
  }

  userDetailsWidget(BuildContext context) {
    return Expanded(
        flex: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
                child: Text("${userProfile.name}",
                    style: new TextStyle(color: Colors.white)),
                padding: EdgeInsets.only(top: 2)),
            Padding(
                child: Text("${userProfile.login}",
                    style: new TextStyle(color: Colors.white)),
                padding: EdgeInsets.only(top: 2)),
            Padding(
                child: Text(
                  "${userProfile.bio}",
                  style: new TextStyle(color: Colors.white),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
                padding: EdgeInsets.only(top: 2)),
            Padding(
                child: Text("${userProfile.company}",
                    style: new TextStyle(color: Colors.white)),
                padding: EdgeInsets.only(top: 2)),
            GestureDetector(
              child: Padding(
                  child: Text("See ${userProfile.name}'s Gist's",
                      style: new TextStyle(color: Colors.white)),
                  padding: EdgeInsets.all(4)),
              onTap: () {
                Application.router.navigateTo(
                    context,
                    Routes.userGists
                        .replaceFirst(":loginname", userProfile.login));
              },
            )
          ],
        ));
  }

  @override
  Widget prepareWidget(BuildContext context) {
    var listWidgets = <Widget>[];
    if (userProfile != null) {
      listWidgets.add(userImageWidget());
      listWidgets.add(userDetailsWidget(context));
    }
    return Container(
      padding: EdgeInsets.only(top: 48),
      child: Row(
        children: listWidgets,
      ),
      decoration: BoxDecoration(
        color: Colors.black87,
      ),
    );
  }
}
