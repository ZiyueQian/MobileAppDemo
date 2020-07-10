import 'package:flutter/material.dart';
import '../models/Dispatch.dart';
import 'package:hive/hive.dart';

class DispatchDetailsView extends StatelessWidget {
  var index;
  var dispatch;

  DispatchDetailsView({Key key, @required this.index, @required this.dispatch})
      : super(key: key);

  @override
  final dispatchBox = Hive.box('dispatch');
  final historyBox = Hive.box('history');

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
                  Center(
                      child: RaisedButton(
                          color: Colors.green,
                          child: Text("Dispatch"),
                          onPressed: () {
                            historyBox.add(dispatch);
                            dispatchBox.deleteAt(index);
                            Navigator.of(context)
                                .popUntil((route) => route.isFirst);
                          }))
                ],
              )),
        ));
  }
}
