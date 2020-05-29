//HOME SCREEN CONTROL. CURRENTLY CONTAINS 'HOME' AND 'HISTORY' TAB.

import 'package:flutter/material.dart';
import 'views/HomeView.dart';
import 'views/HistoryView.dart';
import 'views/HistoryView.dart';
import 'views/newDispatch/infoView.dart';
import 'package:greenwaydispatch/models/Dispatch.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeView(),
    HistoryView(),
  ];

  @override
  Widget build(BuildContext context) {
    final newDispatch = new Dispatch(null, null, null, null);
    return Scaffold(
      appBar: AppBar(
        title: Text('Dispatch'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        DispatchInfoView(dispatch: newDispatch)),
              );
            },
          )
        ],
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: new Icon(Icons.assignment), title: new Text("Home")),
          BottomNavigationBarItem(
              icon: new Icon(Icons.assignment_turned_in),
              title: new Text("History"))
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
