import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:udgam/events/eventDashboards/EventPageNavigation.dart';
import 'package:udgam/events/eventsDatabase/events_details.dart';
import 'package:udgam/events/screens/days/day-cards.dart';

class MiscellaneousEvents extends StatefulWidget {
  MiscellaneousEvents({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MiscellaneousEventsState createState() => _MiscellaneousEventsState();
}

var mov = 27.0 / 41.0;
var aspectratio = mov * 1.2;
class _MiscellaneousEventsState extends State<MiscellaneousEvents> {
  static var _eventListMiscellaneousEvents =
      eventsList[3]; ////assigning Miscellaneous Events list
  double currentPage = _eventListMiscellaneousEvents.length - 1.0;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    PageController controller =
        PageController(initialPage: _eventListMiscellaneousEvents.length - 1);
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
                        // IconButton(icon: Icon(Icons.keyboard_backspace,color: Colors.white,), onPressed:() {
                        //   print("Back pressed");
                        //     Navigator.pop(context);
                        //   },),
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
                                      color: Colors.white))),
                        ),
                        Expanded(
                          child: Text(
                            widget.title.toString().toUpperCase(),
                            style: TextStyle(
                                fontSize: 30.0, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
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
                          child: Stack(
                            children: <Widget>[
                              PosterScrollWidget(
                                  _eventListMiscellaneousEvents, currentPage),
                              Positioned.fill(
                                  child: PageView.builder(
                                      //this PageView is basically a glorified GestureDetector.
                                      itemCount:
                                          _eventListMiscellaneousEvents.length,
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
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => EventPageNavigation(
                                    index: currentPage.round(), dayNumber: 3),
                              ),
                            );
                          },
                        ),
                        Text(
                          _eventListMiscellaneousEvents[currentPage.round()]
                              ['eventName'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white.withOpacity(0.4)),
                        ),
                        // TextScrollWidget(_eventListMiscellaneousEvents,currentPage),///////////
                      ]),
                ),
                // ),
                //this demo doesn't include the movie title, but you could implement that using a very similar setup to the poster stack
                //put each title in a Stack. offset them based on distance from the "current" title in the list.
                //prev goes up by the height of the Stack, next goes down by the same
                //and just don't add anything to the Stack that isn't adjacent to the current item.
              ],
            ),
          ],
        ),
      ),
    );
  }
}
