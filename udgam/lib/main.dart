import 'package:custom_splash/custom_splash.dart';
import 'package:flutter/material.dart';
import 'package:udgam/screens/about_screen.dart';
import 'package:udgam/screens/blog_screen.dart';
import 'package:udgam/screens/events_screen.dart';
import 'package:udgam/screens/gallery_screen.dart';
import 'package:udgam/screens/root_screen.dart';
import 'package:udgam/screens/sponsors_screen.dart';
import 'package:udgam/screens/teams_screen.dart';
import 'package:udgam/services/authentication_service.dart';

void main() => runApp(MyApp());

// TODO Use MediaQuery to make the app responsive
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Udgam 2020",
      theme: ThemeData.dark(),
      home: buildCustomSplashScreen(context),
      routes: {
        Blog.routeName: (context) => Blog(),
        Events.routeName: (context) => Events(),
        Gallery.routeName: (context) => Gallery(),
        Teams.routeName: (context) => Teams(),
        Sponsors.routeName: (context) => Sponsors(),
        About.routeName: (context) => About(),
      },
    );
  }

  Stack buildCustomSplashScreen(BuildContext context) {
    return Stack(
      children: <Widget>[
        CustomSplash(
          imagePath: 'assets/images/logo.jpg',
          backGroundColor: Colors.white,
          animationEffect: 'zoom-in',
          logoSize: 500.0,
          home: RootPage(
            auth: Auth(),
          ),
          duration: 3000,
          type: CustomSplashType.StaticDuration,
        ),
        Align(
          child: Container(
            height: 4,
            child: LinearProgressIndicator(
              backgroundColor: Theme.of(context).backgroundColor,
              valueColor:
                  AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor),
            ),
          ),
          alignment: FractionalOffset.bottomCenter,
        ),
        Positioned(
          child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 35),
              child: Text(
                "Udgam 2020",
                textAlign: TextAlign.center,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontFamily: 'IndieFlower',
                  color: Colors.black45,
                  fontSize: 65,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
