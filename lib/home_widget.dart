//HOME SCREEN CONTROL. CURRENTLY CONTAINS 'HOME' AND 'HISTORY' TAB.

import 'package:flutter/material.dart';
import 'views/HomeView.dart';
import 'views/HistoryView.dart';
import 'views/newDispatch/infoView.dart';
import 'package:greenwaydispatch/models/Dispatch.dart';
import 'package:greenwaydispatch/data/dispatch_bloc/dispatch_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'views/newDispatch/inOrOutBoundView.dart';

class Home extends StatefulWidget {
  @override
  final String token;

  Home({Key key, @required this.token}) : super(key: key);

//  State<StatefulWidget> createState() {
//    return _HomeState();
//  }

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    HomeView(),
    HistoryView(),
  ];

  DispatchBloc _dispatchBloc;

  @override
  void initState() {
    super.initState();
//    _dispatchBloc = BlocProvider.of<DispatchBloc>(context);
//    // Events can be passed into the bloc by calling dispatch.
//    // We want to start loading dispatches right from the start.
//    _dispatchBloc.add(LoadDispatches());
  }

  @override
  Widget build(BuildContext context) {
    final newDispatch = new Dispatch(null, null, null, null, null, null, null,
        null, null, null, null, null, null, null, null);
    return Scaffold(
      appBar: AppBar(
        title: Text('Dispatch Executive'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        InOrOutBoundView(dispatch: newDispatch)),
              );
            },
          )
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
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
