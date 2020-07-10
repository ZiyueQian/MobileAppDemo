import 'package:flutter/material.dart';

class HistoryDetailsView extends StatelessWidget {
  var index;
  var dispatch;

  HistoryDetailsView({Key key, @required this.index, @required this.dispatch})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Dispatch ${dispatch.dispatchRecord}"),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
          child: Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Amount: ${dispatch.dispatchAmount}"),
                  Text("Type: ${dispatch.dispatchType}"),
                  Text("Date: ${dispatch.dispatchTime}"),
                ],
              )),
        ));
  }
}
