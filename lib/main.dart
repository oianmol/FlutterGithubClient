import 'package:LoginUI/Routes.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

void main() => runApp(new AppGithubClient());

class AppGithubClient extends StatelessWidget {
  // This widget is the root of your application.

  AppGithubClient() {
    final router = new Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
   var app = new MaterialApp(
      title: 'Flutter Github Client',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(),
      onGenerateRoute: Application.router.generator,
    );
   print("initial route = ${app.initialRoute}");
   return app;
  }
}


class Application{
  static Router router;
}