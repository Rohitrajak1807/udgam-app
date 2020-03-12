import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:events/screens/days/Day_1.dart';
import 'package:events/screens/days/Day_2.dart';
import 'package:events/screens/days/Day_3.dart';
import 'package:events/screens/days/MiscellaneousEvents.dart';

class DashboardPage extends StatefulWidget {
  
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  build(BuildContext context) {
    double h=MediaQuery.of(context).size.height;
    double w=MediaQuery.of(context).size.width;
    return Scaffold(body:SafeArea( child:Stack(
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/eventsDashboardImages/3.jpg"),fit:BoxFit.fitHeight),

              ),
            ), 
            BackdropFilter(
            filter: new ImageFilter.blur(sigmaX: 40, sigmaY: 40),
            child: Container(
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.6)),
            ),
          ),
          Column(
            children: <Widget>[
              SizedBox(height: h/121.0084),
              Row(
                
                children: <Widget>[  
                  SizedBox(width:w/105.88235),
                  InkWell(
                      onTap:(){ Navigator.pop(context);},
                      child: Container(
                        width:w/6.05042,
                        height:h/21.17647,
                        decoration: BoxDecoration(
                          color:Colors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(30)
                        ),
                        child: Center(child: Icon(Icons.keyboard_backspace,color: Colors.white))
                      ),
                  ),
              SizedBox(width:(MediaQuery.of(context).size.width*7)/27),
              Container(
                 width:w/8.47058798,
                height:h/16.941176,
                decoration: BoxDecoration(
                  image: DecorationImage(image:AssetImage("assets/logo/ulogo.png")),
                  color:Colors.black.withOpacity(0.2),
                borderRadius: BorderRadius.circular(30)
                ),
                
              ),
              SizedBox(width:(MediaQuery.of(context).size.width*9)/27),
              Container(
                width:w/10.588235,
                height:h/21.17647,
                decoration: BoxDecoration(
                  color:Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(30)
                ),
                child: Center(child: Icon(Icons.person_outline,color: Colors.white,))
                
              ),
              ]),
              SizedBox(height:(MediaQuery.of(context).size.height)/4-20),
              Container(
                height:MediaQuery.of(context).size.height/2.2,
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children:<Widget>[
                    SizedBox(width:MediaQuery.of(context).size.width/4),
                    InkWell(
                    child: Container(                
                        height:MediaQuery.of(context).size.height/2.2,
                        width: MediaQuery.of(context).size.width/1.8,
                        decoration: BoxDecoration(
                          image: DecorationImage(image:AssetImage("assets/images/eventsDashboardImages/5.jpg"),fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                        onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Day1(key: widget.key, title: 'DAY 1')
                      ));
                    },
                    ),
                    SizedBox(width:w/21.17647),
                    InkWell(
                    child: Container(                
                      height:MediaQuery.of(context).size.height/2.2,
                      width: MediaQuery.of(context).size.width/1.8,
                      decoration: BoxDecoration(
                        image: DecorationImage(image:AssetImage("assets/images/eventsDashboardImages/6.jpg"),fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                     onTap: () {
                       Navigator.of(context).push(
                       MaterialPageRoute(
                       builder: (context) => Day2(key: widget.key, title: 'DAY 2')
                      ));
                    },
                    ),
                    SizedBox(width:w/21.17647),
                    InkWell(
                    child: Container(                
                      height:MediaQuery.of(context).size.height/2.2,
                      width: MediaQuery.of(context).size.width/1.8,
                      decoration: BoxDecoration(
                        image: DecorationImage(image:AssetImage("assets/images/eventsDashboardImages/7.jpg"),fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                     onTap: () {
                       Navigator.of(context).push(
                       MaterialPageRoute(
                       builder: (context) => Day3(key: widget.key, title: 'DAY 3')
                      ));
                    },
                    ),
                    SizedBox(width:w/21.17647),
                    InkWell(
                    child: Container(                
                      height:MediaQuery.of(context).size.height/2.2,
                      width: MediaQuery.of(context).size.width/1.8,
                      decoration: BoxDecoration(
                        image: DecorationImage(image:AssetImage("assets/images/eventsDashboardImages/8.jpg"),fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                     onTap: () {
                       Navigator.of(context).push(
                       MaterialPageRoute(
                       builder: (context) => MiscellaneousEvents(key: widget.key, title: 'Extra Fun Events')
                      ));
                    },
                    ),
                    SizedBox(width:w/3.85026726)
              ]))
                ])
            ]),
    )); 
  }
}