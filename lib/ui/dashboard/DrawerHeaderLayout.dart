import 'package:LoginUI/model/UserProfile.dart';
import 'package:flutter/material.dart';

class DrawerHeaderLayout extends StatelessWidget {
  final UserProfile userProfile;

  DrawerHeaderLayout({userProfile: UserProfile}):this.userProfile = userProfile;

  @override
  DrawerHeader build(BuildContext context) {
    return DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            child: new CircleAvatar(
                          backgroundImage: new NetworkImage(
                              userProfile.avatarUrl),
                          radius: 40.0,
                        )),
                      ],
                    )),
                Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("${userProfile.name}",
                            style: new TextStyle(color: Colors.white)),
                        Text("${userProfile.login}",
                            style: new TextStyle(color: Colors.white)),
                        Text("${userProfile.bio}",
                            style: new TextStyle(color: Colors.white)),
                        Text("${userProfile.company}",
                            style: new TextStyle(color: Colors.white))
                      ],
                    ))
                  ],
                )
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          );
  }
}