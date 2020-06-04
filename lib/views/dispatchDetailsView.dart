import 'package:flutter/material.dart';
import '../models/Dispatch.dart';

class DispatchDetailsView extends StatelessWidget {
  final Dispatch dispatch;

  DispatchDetailsView({Key key, @required this.dispatch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Dispatch ${dispatch.dispatchRecord}"),
        ),
        body: Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Amount: ${dispatch.dispatchAmount}"),
                Text("Type: ${dispatch.dispatchType}"),
                Text("Date: ${dispatch.dispatchTime}"),
              ],
            )));
  }
}
