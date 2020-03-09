import 'package:flutter/material.dart';
import 'package:custom_splash/custom_splash.dart';
import 'package:udgam/models/root_page.dart';
import 'package:udgam/services/authentication.dart';
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
              auth: new Auth()
          ),
         // customFunction: duringSplash,
          duration: 2500,
          type: CustomSplashType.StaticDuration,
          outputAndHome: op,
        ),
        Align(
          child: LinearProgressIndicator(
            backgroundColor: Colors.lightBlueAccent,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange),
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