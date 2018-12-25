import 'package:LoginUI/model/UserProfile.dart';
import 'package:flutter/material.dart';

class DrawerHeaderLayout extends StatelessWidget {
  final UserProfile userProfile;

  DrawerHeaderLayout({userProfile: UserProfile})
      : this.userProfile = userProfile;

  @override
  DrawerHeader build(BuildContext context) {
    return DrawerHeader(
      child: Row(
        children: <Widget>[userImageWidget(), userDetailsWidget()],
      ),
      decoration: BoxDecoration(
        color: Colors.black87,
      ),
    );
  }

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

  userDetailsWidget() {
    return Expanded(
        flex: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(child: Text("${userProfile.name}",
                style: new TextStyle(color: Colors.white)),padding: EdgeInsets.only(top: 2)),
            Padding(child: Text("${userProfile.login}",
                style: new TextStyle(color: Colors.white)),padding: EdgeInsets.only(top: 2)),
            Padding(child: Text(
              "${userProfile.bio}",
              style: new TextStyle(color: Colors.white),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),padding: EdgeInsets.only(top: 2)),
            Padding(child: Text("${userProfile.company}",
                style: new TextStyle(color: Colors.white)),padding: EdgeInsets.only(top: 2))
          ],
        ));
  }
}
