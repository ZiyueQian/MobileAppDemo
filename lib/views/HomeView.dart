//THIS IS THE HOME TAB ON THE HOME SCREEN.
//CURRENTLY EMPTY

import 'package:flutter/material.dart';
import 'package:greenwaydispatch/models/Dispatch.dart';

class HomeView extends StatefulWidget {
  final Dispatch dispatch;
  HomeView({Key key, @required this.dispatch}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      //child: Text(widget.dispatch.dispatchAmount.toString()),
    );
  }
}
