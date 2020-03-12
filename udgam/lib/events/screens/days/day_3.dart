import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:udgam/events/eventDashboards/EventPageNavigation.dart';
import 'package:udgam/events/eventsDatabase/events_details.dart';
import 'day-cards.dart';

class Day3 extends StatefulWidget {
  Day3({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Day3State createState() => _Day3State();
}

var mov = 27.0 / 41.0;
var aspectratio = mov * 1.2;
class _Day3State extends State<Day3> {
  static var _eventsListDay3 = eventsList[2];
  double currentPage = _eventsListDay3.length - 1.0;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    PageController controller =
        PageController(initialPage: _eventsListDay3.length - 1);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page;
      });
    });

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image:
                        AssetImage("assets/images/eventsDashboardImages/3.jpg"),
                    fit: BoxFit.cover),
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
                          height: h / 21.17647,
                          width: w / 7.0588,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.black.withOpacity(0.1),
                          ),
                          child: Center(
                            child: Icon(Icons.keyboard_backspace,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      Text(
                        widget.title.toString().toUpperCase(),
                        style: TextStyle(
                            fontSize: 40.0, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        height: h / 21.17647,
                        width: w / 10.58823,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                ),
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
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => EventPageNavigation(
                                index: currentPage.round(),
                                dayNumber: 2,
                              ),
                            ),
                          );
                        },
                        child: Stack(
                          children: <Widget>[
                            PosterScrollWidget(_eventsListDay3, currentPage),
                            Positioned.fill(
                              child: PageView.builder(
                                //this PageView is basically a glorified GestureDetector.
                                itemCount: _eventsListDay3.length,
                                controller: controller,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: <Widget>[
                                      Container(),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        _eventsListDay3[currentPage.round()]['eventName'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white.withOpacity(0.4)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
