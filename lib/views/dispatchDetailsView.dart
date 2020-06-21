import 'package:flutter/material.dart';
import '../models/Dispatch.dart';

class DispatchDetailsView extends StatelessWidget {
  var data;

  DispatchDetailsView({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Dispatch ${data['dispatchRecord']}"),
        ),
        body: Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Amount: ${data['dispatchAmount']}"),
                Text("Type: ${data['dispatchType']}"),
                Text("Date: ${data['dispatchTime']}"),
              ],
            )));
  }
}
