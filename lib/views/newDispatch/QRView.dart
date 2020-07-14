//THIS PAGE IS FOR QR CODE SCANNING - LAST STEP FOR ADDING A NEW DISPATCH

import 'package:flutter/material.dart';
import 'package:greenwaydispatch/models/Dispatch.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QRView extends StatefulWidget {
  final Dispatch dispatch;
  //final DispatchContact dispatchContact;
  QRView({Key key, @required this.dispatch}) : super(key: key);

  @override
  _QRViewState createState() => _QRViewState();
}

class _QRViewState extends State<QRView> {
  var qrResult;

  void addDispatch(Dispatch dispatch) {
    final dispatchBox = Hive.box('dispatch');
    dispatchBox.add(dispatch);
    print("adding dispatch! ");
  }

  void saveToHive() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    String dispatchRecord = shared.getString('dispatchRecord');
    int dispatchAmount = shared.getInt('dispatchAmount');
    String dispatchType = shared.getString('dispatchType');
    String dispatchConfirmation = shared.getString('dispatchConfirmation');
    print("getting values from shared preference");
    final newDispatch = Dispatch(
      dispatchRecord,
      DateTime.now(),
      dispatchAmount,
      dispatchType,
      dispatchConfirmation,
    );
    addDispatch(newDispatch);
  }

  Future scan() async {
    try {
      qrResult = await BarcodeScanner.scan();
      setState(() => widget.dispatch.dispatchRecord = qrResult);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.qrResult = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.qrResult = 'Unknown error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "New dispatch ${widget.dispatch.dispatchRecord}: ${widget.dispatch.dispatchType} delivery"),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          RaisedButton(
            child: Text("Scan QR Code"),
            onPressed: scan,
          ),
          RaisedButton(
            child: Text("Finish"),
            onPressed: () {
              saveToHive();
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ],
      ),
    );
  }
}
