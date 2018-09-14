import 'package:LoginUI/ui/dashboard/DashboardPage.dart';
import 'package:flutter/material.dart';

class DashboardPageState extends State<DashboardPage> {

  Widget appBarTitle = new Text("Your Dashboard");

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return new Scaffold(
        body: new Stack(
          children: <Widget>[
            toolbarAndroid()
          ],
        ));
  }


  toolbarAndroid() {
    return new AppBar(
      centerTitle: false,
      title: appBarTitle,
    );
  }
}