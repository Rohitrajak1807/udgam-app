// import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:events/screens/days/DayCards.dart';
import 'package:events/eventsDatabase/EventsDetails.dart';
import 'package:events/eventDashboards/EventPageNavigation.dart';

class Day2 extends StatefulWidget {
  Day2({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _Day2State createState() => _Day2State();
}

var mov = 27.0 / 41.0; //this is the default aspect ratio for a movie poster
//fun fact: movie/TV folks are *extremely* particular about how posters and media are displayed
//like, it'll be in actors' contracts that their face won't be cut off or whatever
//notably, the original design doesn't guarantee this (it scales the poster in and out), but my implementation does, at least for
//standard sized movie posters.
var aspectratio = mov *
    1.2; //this is an arbitrary value I thought looked good. nothing special about it

/*
Rules:
Movie posters must maintain aspect ratio
custom view should maintain fixed aspect ratio, moderately wider than movie poster
 */

class _Day2State extends State<Day2> {
  static var _eventListDay2 = eventsList[1]; 
  double currentPage = _eventListDay2.length - 1.0;
  @override
  Widget build(BuildContext context) {
    double h=MediaQuery.of(context).size.height;
    double w=MediaQuery.of(context).size.width;
    PageController controller = PageController(initialPage: _eventListDay2.length - 1);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page;
      });
    });
    
    return Scaffold(
        body: SafeArea(
            child: Stack(children: <Widget>[
      Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(image:AssetImage("assets/images/eventsDashboardImages/3.jpg"),fit: BoxFit.cover),
        ),
      ),
       BackdropFilter(
            filter: new ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.6)),
            ),
          ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.fromLTRB(10.0, 10, 10.0, 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        height: h/21.17647,
                        width: w/7.0588,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.black.withOpacity(0.1),
                        ),
                        child: Center(
                            child: Icon(Icons.keyboard_backspace,
                                color: Colors.white))),
                  ),
                  Text(widget.title.toString().toUpperCase(),
                      style: TextStyle(
                          fontSize: 40.0, fontWeight: FontWeight.bold)),
                  Container(
                    height: h/21.17647,
                    width: w/10.58823,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.transparent,
                    ),
                  ),
                ],
              )),
          Expanded(
            flex: 2,
            child: Column(
                // margin: const EdgeInsets.only(top:30),
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                // alignment: Alignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EventPageNavigation(
                                index: currentPage.round(), dayNumber: 1,
                              )));
                    },
                      child: Stack(
                        children: <Widget>[
                          PosterScrollWidget(_eventListDay2, currentPage),
                          Positioned.fill(
                              child: PageView.builder(
                                  //this PageView is basically a glorified GestureDetector.
                                  itemCount: _eventListDay2.length,
                                  controller: controller,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: <Widget>[
                                        Container(),
                                      ],
                                    );
                                  })),
                        ],
                      ),
                  ),
                  Text(
                    _eventListDay2[currentPage.round()]['eventName'],
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color:Colors.white.withOpacity(0.4)),
                  ),
                  // TextScrollWidget(_eventListDay2,currentPage),///////////
                ]),
          ),
          // ),
          //this demo doesn't include the movie title, but you could implement that using a very similar setup to the poster stack
          //put each title in a Stack. offset them based on distance from the "current" title in the list.
          //prev goes up by the height of the Stack, next goes down by the same
          //and just don't add anything to the Stack that isn't adjacent to the current item.
        ],
      ),
    ])));
  }
}
