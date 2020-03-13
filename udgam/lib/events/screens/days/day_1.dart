import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:udgam/events/screens/days/day-cards.dart';
import 'package:udgam/events/eventsDatabase/events_details.dart';
import 'package:udgam/events/eventDashboards/EventPageNavigation.dart';

class Day1 extends StatefulWidget {
  Day1({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Day1State createState() => _Day1State();
}

var mov = 27.0 / 41.0;
var aspectRatio = mov * 1.2;

class _Day1State extends State<Day1> {
  static var _eventListDay1 = eventsList[0]; ////assigning day 1 list
  double currentPage = _eventListDay1.length - 1.0;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    PageController controller =
        PageController(initialPage: _eventListDay1.length - 1);
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
                      Wrap(
                        children: <Widget>[
                          Text(widget.title.toString().toUpperCase(),
                              style: TextStyle(
                                  fontSize: 40.0, fontWeight: FontWeight.bold)),
                        ],
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        child: Stack(
                          children: <Widget>[
                            PosterScrollWidget(_eventListDay1, currentPage),
                            Positioned.fill(
                              child: PageView.builder(
                                itemCount: _eventListDay1.length,
                                controller: controller,
                                itemBuilder: (context, index) {},
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => EventPageNavigation(
                                  index: currentPage.round(), dayNumber: 0),
                            ),
                          );
                        },
                      ),
                      Text(
                        _eventListDay1[currentPage.round()]['eventName'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white.withOpacity(0.4)),
                      ),
                      // TextScrollWidget(_eventListDay1,currentPage),///////////
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
