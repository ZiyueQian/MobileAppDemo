//THIS PAGE IS FOR QR CODE SCANNING - LAST STEP FOR ADDING A NEW DISPATCH

import 'dart:convert';

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
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:greenwaydispatch/models/Dispatch_insert.dart';
import 'package:greenwaydispatch/data/api_response.dart';
import 'package:greenwaydispatch/views/newDispatch/functions/scan.dart';

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
  Future<Dispatch> _futureDispatch;
  TextEditingController ewayBillController = new TextEditingController();

  String dispatchRecord;
  int dispatchAmount;
  String dispatchType;
  String dispatchTime;
  String dispatchConfirmation;
  String truckNumber;
  String
      contactPerson; //also used for driver's name for truck and delivery person for hand
  int contactNumber;
  int alternativeContactNumber;
  String docketNumber;
  String recipientPerson;
  int recipientContactNumber;
  String containerNumber;
  String customsClearingPoint;
  String description;

  var apiURL =
      "https://my-json-server.typicode.com/ZiyueQian/MobileAppDemo/dispatches";
  static const headers = {
    'apiKey': '08d771e2-7c49-1789-0eaa-32aff09f1471',
    'Content-Type': 'application/json'
  };

  @override
  void initState() {
    super.initState();
    _dispatchBloc = BlocProvider.of<DispatchBloc>(context);
    _dispatchBloc.add(LoadDispatches());
    _historyBloc = BlocProvider.of<HistoryBloc>(context);
    _historyBloc.add(LoadHistory());
  }

  Future saveToDatabase(bool dispatchNow) async {
    SharedPreferences shared = await SharedPreferences.getInstance();

    //basic dispatch info - exists for all dispatches
    dispatchRecord = shared.getString('referenceNumber');
    dispatchAmount = shared.getInt('quantity');
    dispatchType = shared.getString('dispatchType');
    dispatchConfirmation = shared.getString('referenceDocument');
    contactPerson = shared.getString('contactName');
    contactNumber = shared.getInt('contactNumber');
    DateTime now = DateTime.now();
    dispatchTime = DateFormat('yyyy-MM-dd kk:mm').format(now);

    //truck dispatch type
    truckNumber = shared.getString('truckNumber');
    int alternativeContactNumber = shared.getInt('alternativeContactNumber');

    //container dispatch type
    containerNumber = shared.getString('containerNumber');
    customsClearingPoint = shared.getString('customsClearingPoint');

    //logistics dispatch type
    docketNumber = shared.getString('docketNumber');

    //hand dispatch type
    recipientContactNumber = shared.getInt('recipientContactNumber');
    recipientPerson = shared.getString('recipientPerson');

    //other dispatch type
    description = shared.getString('description');

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
  }

  Future<Dispatch> savetoServer() async {
    final newDispatch = DispatchInsert(
        dispatchRecord: dispatchRecord,
        dispatchAmount: dispatchAmount,
        dispatchType: dispatchType,
        dispatchTime: dispatchTime,
        dispatchConfirmation: dispatchConfirmation,
        truckNumber: truckNumber,
        contactPerson: contactPerson,
        contactNumber: contactNumber,
        alternativeContactNumber: alternativeContactNumber,
        docketNumber: docketNumber,
        recipientPerson: recipientPerson,
        recipientContactNumber: recipientContactNumber,
        containerNumber: containerNumber,
        customsClearingPoint: customsClearingPoint,
        description: description);
    final result = await createDispatch(newDispatch);
  }

  Future<APIResponse<bool>> createDispatch(DispatchInsert item) {
    var dispatch = {
      "dispatchRecord": "testing",
      "dispatchAmount": 5,
      "dispatchType": "truck",
      "dispatchTime": "2020-02-02 21:40",
      "dispatchConfirmation": "confirm",
      "truckNumber": "A11",
      "contactPerson": "Ankit",
      "contactNumber": 123456,
      "alternativeContactNumber": 1234567,
      "docketNumber": "ABC123",
      "recipientPerson": "Mohit",
      "recipientContactNumber": 12345678,
      "containerNumber": "ABCDEF",
      "customsClearingPoint": "Delhi",
      "description": "describing dispatch"
    };

    return http
        .post(apiURL, headers: headers, body: convert.jsonEncode(item.toJson()))
        .then((data) {
      if (data.statusCode == 201) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    }).catchError((_) =>
            APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New dispatch: ${widget.dispatch.dispatchType} delivery"),
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(children: <Widget>[
          TextFormField(
            keyboardType: TextInputType.visiblePassword,
            controller: ewayBillController,
            decoration: InputDecoration(
              icon: Icon(Icons.confirmation_number),
              labelText: 'Stove ID',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.camera_alt,
                ),
                onPressed: () {
                  scanEwayBill(context).then((val) => setState(() {
                        ewayBillController.text = val;
                      }));
                },
              ),
            ),
            onSaved: (val) => print(val),
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text("To be dispatched"),
                onPressed: () {
                  saveToDatabase(false);
                  setState(() {
                    _futureDispatch = savetoServer();
                  });
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              ),
              SizedBox(
                width: 20.0,
              ),
              RaisedButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text("Dispatch Now"),
                onPressed: () {
                  saveToDatabase(true);
                  setState(() {
                    _futureDispatch = savetoServer();
                  });
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              )
            ],
          ),
        ]),
      ),
    );
  }
}
