import 'package:flutter/material.dart';
import 'package:video_player_better_player/ContentFragment.dart';

class FlexibleTabs {
  //List<Tab> listOfTabs = [];

  List<Tab> listOfTabs = [
    const Tab(child: Text('কন্টেন্ট')),
    const Tab(child: Text('প্যারালাল টেক্সট ')),
  ];


  Widget createFlexibleTabs(BuildContext context) {
    //listOfTabs.clear();
    //generateDummyList();
    List<Widget> tabsContent = [    const ContentFragment(),    Container(),  ];
    return DefaultTabController(
      length: listOfTabs.length, // length of tabs
      initialIndex: 0,
      child: Flexible(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TabBar(
              isScrollable: true,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.blueAccent,
              indicatorWeight: 5,
              tabs: listOfTabs,
            ),
            Flexible(
              child: TabBarView(
                children: tabsContent,
              ),
            ),
          ],
        ),
      ),
    );
  }

}
