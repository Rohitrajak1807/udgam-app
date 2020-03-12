import 'package:flutter/material.dart';
import 'package:events/eventDashboards/EventsInfoHeader.dart';
import 'package:events/eventsDatabase/About_us.dart';

// final List<String> details = [
//   "About",
//   "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Sit amet volutpat consequat mauris. Mauris ultrices eros in cursus turpis massa tincidunt dui ut. Sit amet facilisis magna etiam tempor orci eu lobortis. Venenatis tellus in metus vulputate eu scelerisque felis imperdiet proin. Sapien nec sagittis aliquam malesuada bibendum. Pellentesque pulvinar pellentesque habitant morbi tristique senectus et netus. Ultrices gravida dictum fusce ut placerat. Sed risus pretium quam vulputate. Cursus euismod quis viverra nibh cras pulvinar. Metus dictum at tempor commodo ullamcorper. Ut pharetra sit amet aliquam id diam maecenas. Cursus eget nunc scelerisque viverra mauris in. Augue mauris augue neque gravida in fermentum et sollicitudin ac. Nisl nunc mi ipsum faucibus. Nunc id cursus metus aliquam. Enim ut tellus elementum sagittis vitae. Aliquam nulla facilisi cras fermentum odio. Consequat ac felis donec et odio pellentesque diam volutpat commodo."
// ];

List <EventListTiles> dta =  <EventListTiles>[
  EventListTiles('about',<EventListTiles>[
    EventListTiles("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Sit amet volutpat consequat mauris. Mauris ultrices eros in cursus turpis massa tincidunt dui ut. Sit amet facilisis magna etiam tempor orci eu lobortis. Venenatis tellus in metus vulputate eu scelerisque felis imperdiet proin. Sapien nec sagittis aliquam malesuada bibendum. Pellentesque pulvinar pellentesque habitant morbi tristique senectus et netus. Ultrices gravida dictum fusce ut placerat. Sed risus pretium quam vulputate. Cursus euismod quis viverra nibh cras pulvinar. Metus dictum at tempor commodo ullamcorper. Ut pharetra sit amet aliquam id diam maecenas. Cursus eget nunc scelerisque viverra mauris in. Augue mauris augue neque gravida in fermentum et sollicitudin ac. Nisl nunc mi ipsum faucibus. Nunc id cursus metus aliquam. Enim ut tellus elementum sagittis vitae. Aliquam nulla facilisi cras fermentum odio. Consequat ac felis donec et odio pellentesque diam volutpat commodo."),
  ],),
];

class EventsInfo extends StatefulWidget {
  final String title, imgheaderUrl,about,rules,venue,coordinators;
  var reg;
  final Color bgColor;
  EventsInfo({this.title, this.imgheaderUrl, this.bgColor,this.about,this.rules,this.venue,this.coordinators,this.reg});
  @override
  _EventsInfoState createState() => _EventsInfoState();
}

class _EventsInfoState extends State<EventsInfo> {
  get children => null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
      color:Colors.brown.withOpacity(0.5),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: CustomScrollView(
        // physics: NeverScrollableScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            forceElevated:true,
            shape:RoundedRectangleBorder(
              borderRadius:BorderRadius.vertical(
                bottom:Radius.circular(6),
              )
            ),
            elevation: 40,
            backgroundColor: Color(0xFFC2185B),
            title: Text(widget.title),
            floating: true,
          ),
          SliverPersistentHeader(
            pinned: false,
            floating: true,
            delegate: EventsInfoHeader(
              SliverOpacity(opacity: 0.2),
              imgheaderUrl: widget.imgheaderUrl,
              title:widget.title ,
              minExtent: -300.0,
              maxExtent: 300.0,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return SafeArea(
                  child: EventListTilesItem( 
                    EventListTiles("About Event",<EventListTiles>[
                      EventListTiles(widget.about),
                    ],),
                  ),
                );
              },
              childCount: 1,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return SafeArea(
                  child: EventListTilesItem( 
                    EventListTiles("Rules & Regulation",<EventListTiles>[
                      EventListTiles(widget.rules),
                    ],),
                  ),
                );
              },
              childCount: 1,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return SafeArea(
                  child: EventListTilesItem( 
                    EventListTiles("Time & Venue",<EventListTiles>[
                      EventListTiles(widget.venue),
                    ],),
                  ),
                );
              },
              childCount: 1,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return SafeArea(
                  child: EventListTilesItem( 
                    EventListTiles("Coordinators",<EventListTiles>[
                      EventListTiles(widget.coordinators),
                    ],),
                  ),
                );
              },
              childCount: 1,
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            // fillOverscroll: true, // Set true to change overscroll behavior. Purely preference.
            child: Center(
              child:AbsorbPointer(
                absorbing: false,
              child: RaisedButton(
                splashColor: Colors.black54,
                color: Color(0xFFC2185B),
                elevation: 15,
                child: Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  ),
                ),
                onPressed: () {
                  if(widget.reg==0){
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content:Text("Registeration Successfull"),
                      // action: SnackBarAction(
                      //   label: 'UNDO',onPressed:(){
                      //     Navigator.of(context).popUntil(ModalRoute.withName('HomePage()'));
                      //   },
                      // ),                     
                      duration: Duration(milliseconds: 800),
                      backgroundColor: Color(0xFFC2185B),
                    ),
                  );
                  widget.reg+=1;
                  }
                  else{
                    Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content:Text("Already Registered"),
                      // action: SnackBarAction(
                      //   label: 'UNDO',onPressed:(){
                      //     Navigator.of(context).popUntil(ModalRoute.withName('HomePage()'));
                      //   },
                      // ),                     
                      duration: Duration(milliseconds: 800),
                      backgroundColor: Color(0xFFC2185B),
                    ),
                  );
                  }
                },
              )),
            ),
          ),
        ],
      ),
    ));
  }
}
