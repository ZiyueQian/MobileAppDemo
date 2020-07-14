//THIS PAGE SHOWS THE FIRST PAGE OF THE FORM FOR A NEW DISPATCH

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:greenwaydispatch/models/Dispatch.dart';
import 'package:greenwaydispatch/views/newDispatch/dispatchTypesContact/truckContactView.dart';
import 'package:greenwaydispatch/views/newDispatch/dispatchTypesContact/logisticsContactView.dart';
import 'package:greenwaydispatch/views/newDispatch/dispatchTypesContact/containerContactView.dart';
import 'package:greenwaydispatch/views/newDispatch/dispatchTypesContact/handContactView.dart';
import 'package:greenwaydispatch/views/newDispatch/dispatchTypesContact/otherContactView.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DispatchInfoView extends StatefulWidget {
  final Dispatch dispatch;
  DispatchInfoView({Key key, @required this.dispatch}) : super(key: key);

  @override
  _DispatchInfoViewState createState() => _DispatchInfoViewState();
}

class _DispatchInfoViewState extends State<DispatchInfoView> {
  TextEditingController recordInputController = new TextEditingController();
  TextEditingController amountInputController = new TextEditingController();
  String _dispatchRecord;
  int _dispatchAmount;
  String _dispatchType;
  String _dispatchConfirmation;

  void setValues(String dispatchRecord, int dispatchAmount, String dispatchType,
      String dispatchConfirmation) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    shared.setString('dispatchRecord', dispatchRecord);
    shared.setInt('dispatchAmount', dispatchAmount);
    shared.setString('dispatchType', dispatchType);
    shared.setString('dispatchConfirmation', dispatchConfirmation);
    print("values set!");
  }

  String value = "Select dispatch confirmation";
  var selectedCard = 'OTHER'; //dispatch types buttons

  @override
  void initState() {
    super.initState();

    print("INITIALIZED INFO PAGE");
  }

  @override
  void dispose() {
    recordInputController.dispose();
    amountInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dispatchTypes = widget.dispatch.types();
    var dispatchKeys = dispatchTypes.keys.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('New dispatch'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10.0),
            Container(
                margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.storage,
                      color: Colors.black.withOpacity(0.5),
                    ),
                    SizedBox(
                      width: 16.0,
                    ),
                    Container(
                      width: 341.0, //fill screen. double.infinity doesn't work.
                      padding:
                          EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        border: Border.all(
                            color: Colors.black.withOpacity(0.5),
                            style: BorderStyle.solid,
                            width: 0.80),
                      ),
                      child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                        items: [
                          DropdownMenuItem<String>(
                            value: "Invoice",
                            child: Center(child: Text("Invoice")),
                          ),
                          DropdownMenuItem<String>(
                            value: "Packing List",
                            child: Center(child: Text("Packing List")),
                          ),
                          DropdownMenuItem<String>(
                            value: "Confirmation number",
                            child: Center(child: Text("Confirmation number")),
                          )
                        ],
                        onChanged: (_value) => {
                          print(_value.toString()),
                          setState(() {
                            _dispatchConfirmation = _value;
                          })
                        },
                        hint: Text("$value"),
                      )),
                    ),
                  ],
                )),
            SizedBox(height: 15.0),
            Container(
                margin: EdgeInsets.symmetric(vertical: 5.0),
                child: TextFormField(
                    controller: recordInputController,
                    decoration: InputDecoration(
                        icon: Icon(Icons.receipt),
                        labelText: 'Reference number',
                        helperText: 'e.g. 1234567890',
                        border: const OutlineInputBorder()),
                    onSaved: (val) => setState(() => _dispatchRecord = val))),
            Container(
                margin: EdgeInsets.symmetric(vertical: 5.0),
                child: TextFormField(
                    controller: amountInputController,
                    decoration: InputDecoration(
                        icon: Icon(Icons.category),
                        labelText: 'Quantity',
                        helperText: 'e.g. 5',
                        border: const OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    onSaved: (val) => _dispatchAmount = int.parse(val))),
            SizedBox(
              height: 15.0,
            ),
            Text(
              "Dispatch type:",
              style: TextStyle(
                  color: Colors.black.withOpacity(0.6), fontSize: 16.0),
            ),
            SizedBox(
              height: 15.0,
            ),
            Expanded(
                child: GridView.count(
              crossAxisCount: 5,
              scrollDirection: Axis.vertical,
              primary: false,
              children: List.generate(dispatchTypes.length, (index) {
                return _buildInfoCard(
                    dispatchTypes[dispatchKeys[index]], dispatchKeys[index]);
              }),
            )),
            Center(
              child: RaisedButton(
                color: Colors.green,
                child: Text("Continue"),
                onPressed: () {
                  widget.dispatch.dispatchTime = DateTime.now();
                  widget.dispatch.dispatchType = selectedCard;
                  _dispatchType = selectedCard;
                  //valueInputController.text = selectedCard;
//                  final newDispatch = Dispatch(
//                    recordInputController.text,
//                    DateTime.now(),
//                    int.parse(amountInputController.text),
//                    _dispatchType,
//                    _dispatchConfirmation,
//                  );
                  //addDispatch(newDispatch);
                  setValues(
                    recordInputController.text,
                    int.parse(amountInputController.text),
                    _dispatchType,
                    _dispatchConfirmation,
                  );
                  if (widget.dispatch.dispatchType == 'truck') {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                TruckContactView(dispatch: widget.dispatch)));
                  } else if (widget.dispatch.dispatchType == 'logistics') {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LogisticsContactView(
                                dispatch: widget.dispatch)));
                  } else if (widget.dispatch.dispatchType == 'container') {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ContainerContactView(
                                dispatch: widget.dispatch)));
                  } else if (widget.dispatch.dispatchType == 'hand') {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                HandContactView(dispatch: widget.dispatch)));
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                OtherContactView(dispatch: widget.dispatch)));
                  }
                  ;
                },
              ),
            ),
            //onSaved: (val) => setState(() => _user.truckNumber = val))),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(Icon iconName, String text) {
    return InkWell(
        onTap: () {
          selectCard(text);
        },
        child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            curve: Curves.easeIn,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              color: text == selectedCard ? Colors.green : Colors.white,
              border: Border.all(
                  color: text == selectedCard
                      ? Colors.transparent
                      : Colors.grey.withOpacity(0.3),
                  style: BorderStyle.solid,
                  width: 0.75),
            ),
            height: 50.0,
            width: 50.0,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: iconName,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(text,
                    style: TextStyle(
                      fontSize: 12.0,
                      //color: text == selectedCard ? Colors.white : Colors.black,
                    )),
              ),
            ])));
  }

  selectCard(text) {
    setState(() {
      selectedCard = text;
    });
  }
}

//Expanded(
//child: GridView.count(
//crossAxisCount: 5,
//scrollDirection: Axis.vertical,
//primary: false,
//children: List.generate(dispatchTypes.length, (index) {
//return FlatButton(
//child: Column(
//mainAxisAlignment: MainAxisAlignment.center,
//children: <Widget>[
//dispatchTypes[dispatchKeys[index]],
//Text(
//dispatchKeys[index],
//style: TextStyle(fontSize: 11.0),
//),
//],
//),
////color: Colors.green[100],
//splashColor: Colors.green[400],
//onPressed: () {
//widget.dispatch.dispatchType = dispatchKeys[index];
////                  setState(() {
////                    _pressAttention = !_pressAttention;
////                  });
//},
//);
//}),
//)),

//Container(
//margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
//child: Row(
//children: <Widget>[
//Icon(
//Icons.storage,
//color: Colors.grey[600],
//),
//SizedBox(
//width: 20.0,
//),
//DropdownButton(
//items: [
//DropdownMenuItem<String>(
//value: "Invoice",
//child: Center(child: Text("Invoice")),
//),
//DropdownMenuItem<String>(
//value: "Packing List",
//child: Center(child: Text("Packing List")),
//),
//DropdownMenuItem<String>(
//value: "Confirmation number",
//child: Center(child: Text("Confirmation number")),
//)
//],
//onChanged: (_value) => {
//print(_value.toString()),
//setState(() {
//value = _value;
//})
//},
//hint: Text("$value"),
//),
//],
//)),
