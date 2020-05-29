//THIS PAGE IS FOR QR CODE SCANNING - LAST STEP FOR ADDING A NEW DISPATCH

import 'package:flutter/material.dart';
import 'package:greenwaydispatch/models/Dispatch.dart';

class QRView extends StatefulWidget {
  final Dispatch dispatch;
  //final DispatchContact dispatchContact;
  QRView({Key key, @required this.dispatch}) : super(key: key);

  @override
  _QRViewState createState() => _QRViewState();
}

class _QRViewState extends State<QRView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "New dispatch ${widget.dispatch.dispatchRecord}: ${widget.dispatch.dispatchType} delivery"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          RaisedButton(
            child: Text("Finish"),
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ],
      ),
    );
  }
}
