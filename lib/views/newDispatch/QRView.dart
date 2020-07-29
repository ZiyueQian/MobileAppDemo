//THIS PAGE IS FOR QR CODE SCANNING - LAST STEP FOR ADDING A NEW DISPATCH

import 'package:flutter/material.dart';
import 'package:greenwaydispatch/models/Dispatch.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:greenwaydispatch/data/dispatch_bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenwaydispatch/data/dispatch_dao.dart';
import 'package:greenwaydispatch/data/history_dao.dart';
import 'package:greenwaydispatch/data/history_bloc/historyBloc.dart';
import 'package:intl/intl.dart';

class QRView extends StatefulWidget {
  final Dispatch dispatch;
  //final DispatchContact dispatchContact;
  QRView({Key key, @required this.dispatch}) : super(key: key);

  @override
  _QRViewState createState() => _QRViewState();
}

class _QRViewState extends State<QRView> {
  var qrResult;
  DispatchBloc _dispatchBloc;
  DispatchDAO _dispatchDAO = DispatchDAO();
  HistoryBloc _historyBloc;
  HistoryDAO _historyDAO = HistoryDAO();

  @override
  void initState() {
    super.initState();
    _dispatchBloc = BlocProvider.of<DispatchBloc>(context);
    _dispatchBloc.add(LoadDispatches());
    _historyBloc = BlocProvider.of<HistoryBloc>(context);
    _historyBloc.add(LoadHistory());
  }

  void saveToDatabase(bool dispatchNow) async {
    SharedPreferences shared = await SharedPreferences.getInstance();

    //basic dispatch info - exists for all dispatches
    String dispatchRecord = shared.getString('dispatchRecord');
    int dispatchAmount = shared.getInt('dispatchAmount');
    String dispatchType = shared.getString('dispatchType');
    String dispatchConfirmation = shared.getString('dispatchConfirmation');
    String contactPerson = shared.getString('contactPerson');
    int contactNumber = shared.getInt('contactNumber');
    DateTime now = DateTime.now();
    String dispatchTime = DateFormat('yyyy-MM-dd – kk:mm').format(now);

    //truck dispatch type
    String truckNumber = shared.getString('truckNumber');
    int alternativeContactNumber = shared.getInt('alternativeContactNumber');

    //container dispatch type
    String containerNumber = shared.getString('containerNumber');
    String customsClearingPoint = shared.getString('customsClearingPoint');

    //logistics dispatch type
    String docketNumber = shared.getString('docketNumber');

    //hand dispatch type
    int recipientContactNumber = shared.getInt('recipientContactNumber');
    String recipientPerson = shared.getString('recipientPerson');

    //other dispatch type
    String description = shared.getString('description');

    print("getting values from shared preference");
    final newDispatch = Dispatch(
      dispatchRecord,
      dispatchAmount,
      dispatchType,
      dispatchTime,
      dispatchConfirmation,
      truckNumber,
      contactPerson,
      contactNumber,
      alternativeContactNumber,
      docketNumber,
      recipientPerson,
      recipientContactNumber,
      containerNumber,
      customsClearingPoint,
      description,
    );
    if (dispatchNow == false) {
      _dispatchBloc.add(AddDispatch(newDispatch));
    } else {
      _historyBloc.add(AddHistory(newDispatch));
    }

    await shared.clear();
    //    print("new dispatch adding");
//    print(newDispatch.containerNumber);
//    print(newDispatch.contactPerson);
//    print(newDispatch.contactNumber);
//    print(newDispatch.truckNumber);
//    print(newDispatch.alternativeContactNumber);
//    print(newDispatch.docketNumber);
//    print(newDispatch.recipientPerson);
//    print(newDispatch.recipientContactNumber);
//    print(newDispatch.customsClearingPoint);
//    print(newDispatch.description);
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
          Row(
            children: <Widget>[
              RaisedButton(
                child: Text("Dispatch Later"),
                onPressed: () {
                  saveToDatabase(false);
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              ),
              RaisedButton(
                child: Text("Dispatch Now"),
                onPressed: () {
                  saveToDatabase(true);
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
