import 'package:flutter/material.dart';
import 'package:custom_splash/custom_splash.dart';
import 'root_screen.dart';
import 'package:udgam/services/authentication_service.dart';
import 'package:udgam/main.dart';


Map<int, Widget> op = {1: MyApp(), 2: MyApp()};
class Splash extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Stack(
      children: <Widget>[
        CustomSplash(
          imagePath: 'assets/images/logo.jpg',
          backGroundColor: Colors.white,
          animationEffect: 'fade-in',
          logoSize: 250.0,
          home: RootPage(
              auth: Auth()
          ),
          // customFunction: duringSplash,
          duration: 2500,
          type: CustomSplashType.StaticDuration,
          outputAndHome: op,
        ),
        Align(
          child: LinearProgressIndicator(
            backgroundColor: Theme.of(context).backgroundColor,
            valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor),
          ),
          alignment: FractionalOffset.bottomCenter,
        ),
        Positioned(
          child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 35),
              child: Text(
                "Udgam'20",
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
        )
      ],
    );
  }
}