import 'dart:async';
import 'dart:convert';
import 'package:LoginUI/model/Issue.dart' as IssueModel;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:LoginUI/utils/SharedPrefs.dart';
import 'package:LoginUI/model/NotificationModel.dart';
import 'package:LoginUI/model/PullRequest.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'NotificationsPage.dart';
import '../base/BaseStatefulState.dart';
import '../../network/Github.dart';
import '../../utils/Strings.dart';

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
    var futures = <Future<http.Response>>[];
    var stream = Github.getUserNotifications(accessToken).asStream();
    stream.listen((response) {
      var notifications = json.decode(response.body) as List;
      var notificationsList = List<NotificationModel>();
      notifications.forEach((notification) {
        var notificationModel = NotificationModel.fromJson(notification);
        notificationsList.add(notificationModel);
        futures.add(getNotificationStatus(notificationModel));
      });
      Future.wait(futures).then((value) {
        var i = 0;
        value.forEach((res) {
          var status = "";
          print(res.body);
          if (res.body.contains(Strings.MERGED_JSON_KEY)) {
            var pr = PullRequest.fromJson(json.decode(res.body));
            if (pr.state == Strings.STATUS_OPEN_JSON_VALUE) {
              status = Strings.STATUS_PR_OPEN;
            } else {
              status = Strings.STATUS_PR_MERGED;
            }
          } else {
            var issue = IssueModel.Issue.fromJson(json.decode(res.body));
            if (issue.state == Strings.STATUS_OPEN_JSON_VALUE) {
              status = Strings.STATUS_ISSUE_OPEN;
            } else {
              status = Strings.STATUS_ISSUE_CLOSED;
            }
          }
          notificationsList[i++].status = status;
        });
        setState(() {
          this.notifications = notificationsList;
          hideProgress();
        });
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
                    Container(
                      child: Text(
                        "Updated at ${formatDate(
                            notifications[index].updatedAt)}",
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.fade,
                      ),
                      margin: EdgeInsets.only(bottom: 4.0),
                    ),
                    Text(
                      notifications[index].status,
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

  Future<http.Response> getNotificationStatus(NotificationModel notification) {
    return Github.getNotificationDetail(notification.subject.url, accessToken);
  }
}
