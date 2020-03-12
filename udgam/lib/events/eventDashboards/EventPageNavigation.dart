import 'package:flutter/material.dart';
import 'package:udgam/events/screens/events_info.dart';
import 'package:udgam/events/eventsDatabase/events_details.dart';

class EventPageNavigation extends StatefulWidget {
  final int index,dayNumber;
  EventPageNavigation({@required this.index,@required this.dayNumber});
  @override
  _EventPageNavigationState createState() => _EventPageNavigationState();
}

class _EventPageNavigationState extends State<EventPageNavigation> {
  PageController setIndex() {
    PageController controller =
        PageController(initialPage: (eventsList[widget.dayNumber].length - widget.index - 1));
    return controller;
  }
  
  List<Widget> setChildrenWidgets(){
    if(eventsList[widget.dayNumber].length == 9){
      var childrenWidgets = <Widget>[
            EventsInfo(
                title: eventsList[widget.dayNumber][8]['eventName'],
                imgheaderUrl: eventsList[widget.dayNumber][8]['imagePath'],bgColor:Color(0xFFFCE4EC),about:eventsList[widget.dayNumber][8]['about'],rules:eventsList[widget.dayNumber][8]['rules'],venue:eventsList[widget.dayNumber][8]['venue'],coordinators: eventsList[widget.dayNumber][8]['coordinators'],reg:eventsList[widget.dayNumber][8]['reg']),
            EventsInfo(
                title: eventsList[widget.dayNumber][7]['eventName'],
                imgheaderUrl: eventsList[widget.dayNumber][7]['imagePath'],bgColor:Color(0xFFFCE4EC),about:eventsList[widget.dayNumber][7]['about'],rules:eventsList[widget.dayNumber][7]['rules'],venue:eventsList[widget.dayNumber][7]['venue'],coordinators: eventsList[widget.dayNumber][7]['coordinators'],reg:eventsList[widget.dayNumber][7]['reg']),
            EventsInfo(
                title: eventsList[widget.dayNumber][6]['eventName'],
                imgheaderUrl: eventsList[widget.dayNumber][6]['imagePath'],bgColor:Color(0xFFFCE4EC),about:eventsList[widget.dayNumber][6]['about'],rules:eventsList[widget.dayNumber][6]['rules'],venue:eventsList[widget.dayNumber][6]['venue'],coordinators: eventsList[widget.dayNumber][6]['coordinators'],reg:eventsList[widget.dayNumber][6]['reg']),
            EventsInfo(
                title: eventsList[widget.dayNumber][5]['eventName'],
                imgheaderUrl: eventsList[widget.dayNumber][5]['imagePath'],bgColor:Color(0xFFFCE4EC),about:eventsList[widget.dayNumber][5]['about'],rules:eventsList[widget.dayNumber][5]['rules'],venue:eventsList[widget.dayNumber][5]['venue'],coordinators: eventsList[widget.dayNumber][5]['coordinators'],reg:eventsList[widget.dayNumber][5]['reg']),
            EventsInfo(
                title: eventsList[widget.dayNumber][4]['eventName'],
                imgheaderUrl: eventsList[widget.dayNumber][4]['imagePath'],bgColor:Color(0xFFFCE4EC),about:eventsList[widget.dayNumber][4]['about'],rules:eventsList[widget.dayNumber][4]['rules'],venue:eventsList[widget.dayNumber][4]['venue'],coordinators: eventsList[widget.dayNumber][4]['coordinators'],reg:eventsList[widget.dayNumber][4]['reg']),
            EventsInfo(
                title: eventsList[widget.dayNumber][3]['eventName'],
                imgheaderUrl: eventsList[widget.dayNumber][3]['imagePath'],bgColor:Color(0xFFFCE4EC),about:eventsList[widget.dayNumber][3]['about'],rules:eventsList[widget.dayNumber][3]['rules'],venue:eventsList[widget.dayNumber][3]['venue'],coordinators: eventsList[widget.dayNumber][3]['coordinators'],reg:eventsList[widget.dayNumber][3]['reg']),
            EventsInfo(
                title: eventsList[widget.dayNumber][2]['eventName'],
                imgheaderUrl: eventsList[widget.dayNumber][2]['imagePath'],bgColor:Color(0xFFFCE4EC),about:eventsList[widget.dayNumber][2]['about'],rules:eventsList[widget.dayNumber][2]['rules'],venue:eventsList[widget.dayNumber][2]['venue'],coordinators: eventsList[widget.dayNumber][2]['coordinators'],reg:eventsList[widget.dayNumber][2]['reg']),
            EventsInfo(
                title: eventsList[widget.dayNumber][1]['eventName'],
                imgheaderUrl: eventsList[widget.dayNumber][1]['imagePath'],bgColor:Color(0xFFFCE4EC),about:eventsList[widget.dayNumber][1]['about'],rules:eventsList[widget.dayNumber][1]['rules'],venue:eventsList[widget.dayNumber][1]['venue'],coordinators: eventsList[widget.dayNumber][1]['coordinators'],reg:eventsList[widget.dayNumber][1]['reg']),
            EventsInfo(
                title: eventsList[widget.dayNumber][0]['eventName'],
                imgheaderUrl: eventsList[widget.dayNumber][0]['imagePath'],bgColor:Color(0xFFFCE4EC),about:eventsList[widget.dayNumber][0]['about'],rules:eventsList[widget.dayNumber][0]['rules'],venue:eventsList[widget.dayNumber][0]['venue'],coordinators: eventsList[widget.dayNumber][0]['coordinators'],reg:eventsList[widget.dayNumber][0]['reg']),
          ];
          
    return childrenWidgets;
    }
    else {
      var childrenWidgets = <Widget>[
            EventsInfo(
                title: eventsList[widget.dayNumber][5]['eventName'],
                imgheaderUrl: eventsList[widget.dayNumber][5]['imagePath'],bgColor:Color(0xFFFCE4EC),about:eventsList[widget.dayNumber][5]['about'],rules:eventsList[widget.dayNumber][5]['rules'],venue:eventsList[widget.dayNumber][5]['venue'],coordinators: eventsList[widget.dayNumber][5]['coordinators'],reg:eventsList[widget.dayNumber][5]['reg']),
            EventsInfo(
                title: eventsList[widget.dayNumber][4]['eventName'],
                imgheaderUrl: eventsList[widget.dayNumber][4]['imagePath'],bgColor:Color(0xFFFCE4EC),about:eventsList[widget.dayNumber][4]['about'],rules:eventsList[widget.dayNumber][4]['rules'],venue:eventsList[widget.dayNumber][4]['venue'],coordinators: eventsList[widget.dayNumber][4]['coordinators'],reg:eventsList[widget.dayNumber][4]['reg']),
            EventsInfo(
                title: eventsList[widget.dayNumber][3]['eventName'],
                imgheaderUrl: eventsList[widget.dayNumber][3]['imagePath'],bgColor:Color(0xFFFCE4EC),about:eventsList[widget.dayNumber][3]['about'],rules:eventsList[widget.dayNumber][3]['rules'],venue:eventsList[widget.dayNumber][3]['venue'],coordinators: eventsList[widget.dayNumber][3]['coordinators'],reg:eventsList[widget.dayNumber][3]['reg']),
            EventsInfo(
                title: eventsList[widget.dayNumber][2]['eventName'],
                imgheaderUrl: eventsList[widget.dayNumber][2]['imagePath'],bgColor:Color(0xFFFCE4EC),about:eventsList[widget.dayNumber][2]['about'],rules:eventsList[widget.dayNumber][2]['rules'],venue:eventsList[widget.dayNumber][2]['venue'],coordinators: eventsList[widget.dayNumber][2]['coordinators'],reg:eventsList[widget.dayNumber][2]['reg']),
            EventsInfo(
                title: eventsList[widget.dayNumber][1]['eventName'],
                imgheaderUrl: eventsList[widget.dayNumber][1]['imagePath'],bgColor:Color(0xFFFCE4EC),about:eventsList[widget.dayNumber][1]['about'],rules:eventsList[widget.dayNumber][1]['rules'],venue:eventsList[widget.dayNumber][1]['venue'],coordinators: eventsList[widget.dayNumber][1]['coordinators'],reg:eventsList[widget.dayNumber][1]['reg']),
            EventsInfo(
                title: eventsList[widget.dayNumber][0]['eventName'],
                imgheaderUrl: eventsList[widget.dayNumber][0]['imagePath'],bgColor:Color(0xFFFCE4EC),about:eventsList[widget.dayNumber][0]['about'],rules:eventsList[widget.dayNumber][0]['rules'],venue:eventsList[widget.dayNumber][0]['venue'],coordinators: eventsList[widget.dayNumber][0]['coordinators'],reg:eventsList[widget.dayNumber][0]['reg']),
          ];
    return childrenWidgets;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          scrollDirection: Axis.horizontal,
          controller: setIndex(),
          children: setChildrenWidgets(),
        ),
      ),
    );
  }
}
// import 'dart:html';
// // import 'dart:math';
// import 'dart:ui';

// import 'package:events/about_us.dart';
// import 'package:events/EventData.dart';
// // import 'package:events/events_info.dart';
// import 'package:flutter/material.dart';
// import 'package:liquid_swipe/Constants/Helpers.dart';
// import 'package:liquid_swipe/liquid_swipe.dart';
// import 'package:events/liquid_pages.dart';

// class EventPageNavigation extends StatefulWidget {
//   final index;
//   final List<Map<String, String>> data;
//   EventPageNavigation({this.index, this.data});
//   @override
//   _EventPageNavigationState createState() => _EventPageNavigationState();
// }

// class _EventPageNavigationState extends State<EventPageNavigation> {
//   // PageController setIndex(){
//   //   PageController controller = PageController(
//   //       initialPage: (eventsList[widget.dayNumber].length - widget.index - 1)
//   //     );
//   //   return controller;
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: LiquidSwipe(
//         pages: testPages,
//         fullTransitionValue: 400,
//         initialPage: (eventsList[widget.dayNumber].length - widget.index - 1),
//         enableLoop: false,
//         enableSlideIcon: true,
//         positionSlideIcon: 0.8,
//         waveType: WaveType.liquidReveal,
//         onPageChangeCallback: (page) => pageChangeCallback(page),
//         currentUpdateTypeCallback: (updateType) =>
//             updateTypeCallback(updateType),
//       ),
//     );
//   }
//   pageChangeCallback(int page) {
//     print(page);
//  }
//   updateTypeCallback(UpdateType updateType) {
//     print(updateType);
//   }
// }
