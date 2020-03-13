import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:udgam/models/event_details.dart';
import 'package:udgam/events/screens/days/day-cards.dart';
import 'package:udgam/events/eventDashboards/EventPageNavigation.dart';

class Day extends StatefulWidget {
  final List<EventDetails> eventsData;
  Day({Key key, this.title, @required this.eventsData}) : super(key: key);

  final String title;

  @override
  _DayState createState() => _DayState(this.eventsData);
}

var mov = 27.0 / 41.0;
var aspectRatio = mov * 1.2;

class _DayState extends State<Day> {
  List<EventDetails> _eventListDay;
  double currentPage;
  _DayState(this._eventListDay);
  @override
  void initState() {
    super.initState();
    currentPage = _eventListDay.length - 1.0;
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    PageController controller =
        PageController(initialPage: _eventListDay.length - 1);
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
                            PosterScrollWidget(_eventListDay, currentPage),
                            Positioned.fill(
                              child: PageView.builder(
                                itemCount: _eventListDay.length,
                                controller: controller,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: <Widget>[
                                      Container(),
                                    ],
                                  );
                                }, ////////////////////
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
                        _eventListDay[currentPage.round()].title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white.withOpacity(0.4)),
                      ),
                      // TextScrollWidget(_eventListDay,currentPage),///////////
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
