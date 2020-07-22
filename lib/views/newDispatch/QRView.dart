//THIS PAGE IS FOR QR CODE SCANNING - LAST STEP FOR ADDING A NEW DISPATCH

import 'package:flutter/material.dart';
import 'package:greenwaydispatch/models/Dispatch.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:greenwaydispatch/dispatch_bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenwaydispatch/data/dispatch_dao.dart';

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

  @override
  void initState() {
    super.initState();
    _dispatchBloc = BlocProvider.of<DispatchBloc>(context);
    _dispatchBloc.dispatch(LoadDispatches());
    print("initialized home!");
  }

//  void addDispatch(Dispatch dispatch) {
//    final dispatchBox = Hive.box('dispatch');
//    dispatchBox.add(dispatch);
//    print("adding dispatch! ");
//  }

  void saveToDatabase() async {
    SharedPreferences shared = await SharedPreferences.getInstance();

    //basic dispatch info - exists for all dispatches
    String dispatchRecord = shared.getString('dispatchRecord');
    int dispatchAmount = shared.getInt('dispatchAmount');
    String dispatchType = shared.getString('dispatchType');
    String dispatchConfirmation = shared.getString('dispatchConfirmation');
    String contactPerson = shared.getString('contactPerson');
    int contactNumber = shared.getInt('contactNumber');

    //truck dispatch type
    var truckNumber = shared.getString('truckNumber');
    String alternativeContactNumber =
        shared.getString('alternativeContactNumber');

    //container dispatch type
    String containerNumber = shared.getString('containerNumber');
    String customsClearingPoint = shared.getString('customsClearingPoint');

    //logistics dispatch type
    String docketNumber = shared.getString('docketNumber');

    //hand dispatch type
    String recipientContactNumber = shared.getString('recipientContactNumber');
    String recipientPerson = shared.getString('recipientPerson');

    //other dispatch type
    String description = shared.getString('description');

    print("getting values from shared preference");
    final newDispatch = Dispatch(
      dispatchRecord,
      dispatchAmount,
      dispatchType,
      DateTime.now(),
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
    _dispatchBloc.dispatch(AddDispatch(newDispatch));
    //_dispatchDAO.insert(newDispatch);
    print("new dispatch adding");
    print(newDispatch.containerNumber); //shared preference works fine!
    print(newDispatch);
    await shared.clear();
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
              saveToDatabase();
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ],
      ),
    );
  }
}
