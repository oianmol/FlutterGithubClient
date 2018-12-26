import 'package:flutter/material.dart';
import 'NotificationsPage.dart';
import 'package:LoginUI/utils/SharedPrefs.dart';
import 'package:LoginUI/model/NotificationModel.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../base/BaseStatefulState.dart';
import '../../network/Github.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class NotificationPageState extends BaseStatefulState<NotificationsPage> {
  Widget appBarTitle = Text("Notifications");
  String accessToken;
  List<NotificationModel> notifications;

  @override
  void initState() {
    super.initState();
    SharedPrefs().getToken().then((token) {
      accessToken = token;
      getUserNotifications();
    });
  }

  @override
  Widget prepareWidget(BuildContext context) {
    var uiElements = <Widget>[toolbarAndroid()];
    if (notifications != null) {
      uiElements.add(Expanded(child: getNotificationListView()));
    }
    return Scaffold(
      key: scaffoldKey,
      body: Column(
        children: uiElements,
      ),
    );
  }

  toolbarAndroid() {
    return new AppBar(
      backgroundColor: Colors.black,
      centerTitle: false,
      title: appBarTitle,
    );
  }

  void getUserNotifications() {
    showProgress();
    var stream = Github.getUserNotifications(accessToken).asStream();
    stream.listen((response) {
      var notifications = json.decode(response.body) as List;
      var notificationsList = List<NotificationModel>();
      notifications.forEach((json) {
        notificationsList.add(NotificationModel.fromJson(json));
      });
      setState(() {
        this.notifications = notificationsList;
        hideProgress();
      });
    });
  }

  Widget getNotificationListView() {
    return ListView.builder(
      itemCount: (notifications == null) ? 0 : notifications.length,
      padding: EdgeInsets.all(12.0),
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              buildSvgWidget(notifications[index].subject.type),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(notifications[index].subject.title.trim()),
                      margin: EdgeInsets.only(bottom: 4.0),
                    ),
                    Text(
                      "Updated at ${formatDate(notifications[index].updatedAt)}",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.fade,
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  String formatDate(String date) {
    var oldFormat = DateFormat("yyyy-MM-ddTHH:mm:ssZ");
    var oldDate = oldFormat.parse(date);
    var newFormat = DateFormat("MMM dd, yyyy");
    return newFormat.format(oldDate);
  }

  Widget buildSvgWidget(String type) {
    String asset = "";
    switch (type) {
      case "PullRequest":
        asset = "icons/git-pull-request.svg";
        break;
      case "Issue":
        asset = "icons/issue-opened.svg";
        break;
      default:
        asset = "icons/bell.svg";
        break;
    }
    return SvgPicture.asset(
      asset,
      width: 28.0,
      height: 28.0,
    );
  }
}
