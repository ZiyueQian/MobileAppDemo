//THIS PAGE SHOWS THE FIRST PAGE OF THE FORM FOR A NEW DISPATCH

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:greenwaydispatch/models/Dispatch.dart';
import 'package:greenwaydispatch/views/newDispatch/dispatchTypesContact/roadContactView.dart';
import 'package:greenwaydispatch/views/newDispatch/dispatchTypesContact/courierContactView.dart';
import 'package:greenwaydispatch/views/newDispatch/dispatchTypesContact/containerContactView.dart';
import 'package:greenwaydispatch/views/newDispatch/dispatchTypesContact/airContactView.dart';
import 'package:greenwaydispatch/views/newDispatch/dispatchTypesContact/otherContactView.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class DispatchInfoView extends StatefulWidget {
  final Dispatch dispatch;
  final String area;
  DispatchInfoView({Key key, @required this.dispatch, @required this.area})
      : super(key: key);

  @override
  _DispatchInfoViewState createState() => _DispatchInfoViewState();
}

class _DispatchInfoViewState extends State<DispatchInfoView> {
  var _formKey = GlobalKey<FormState>();
  TextEditingController recordInputController = new TextEditingController();
  TextEditingController amountInputController = new TextEditingController();
  TextEditingController placeInputController = new TextEditingController();
  TextEditingController pinInputController = new TextEditingController();
  String _dispatchRecord;
  int _dispatchAmount;
  String _dispatchType = 'other';
  String _dispatchConfirmation;
  double screenPadding = 20.0;

  void setValues(
    String referenceDocument,
    String referenceNumber,
    String stove,
    int quantity,
    String area,
    String dispatchType,
  ) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    shared.setString('referenceDocument', referenceDocument);
    shared.setString('referenceNumber', referenceNumber);
    shared.setString('stove', stove);
    shared.setInt('quantity', quantity);
    shared.setString('area', area);
    shared.setString('dispatchType', dispatchType);
    print("values set!");
  }

  String dropDownValue = "Select reference document";
  var selectedStoveCard = '';
  var selectedAreaCard = '';
  var selectedTransportationCard = '';

  List<bool> isSelectedStove = [false, false, false];
  List<String> stoveList = ["jumbo", "prime", "smart"];
  String selectedStove = '';

  List<bool> isSelectedIntlTransportation = [false, false, false, false];
  List<String> intlTransporationList = ["Road", "Air", "Sea", "Other"];
  List<bool> isSelectedDomesticTransportation = [
    false,
    false,
    false,
    false,
    false
  ];
  List<String> domesticTransporationList = [
    "Road",
    "Air",
    "Courier",
    "Rail",
    "Other"
  ];
  String selectedTransporation = '';

  List choices = ["domestic", "international"];
  List choicesIcons = [Icon(MdiIcons.mapMarker), Icon(MdiIcons.earth)];

  List stoveChoices = ["jumbo", "prime", "smart"];
  List stoveChoicesIcons = [
    Icon(MdiIcons.mapMarker, color: Colors.transparent),
    Icon(MdiIcons.earth, color: Colors.transparent),
    Icon(MdiIcons.earth, color: Colors.transparent)
  ];

  @override
  void initState() {
    super.initState();

    print("INITIALIZED INFO PAGE");
  }

  @override
  void dispose() {
    recordInputController.dispose();
    amountInputController.dispose();
    placeInputController.dispose();
    pinInputController.dispose();
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
      body: Padding(
        padding: EdgeInsets.all(screenPadding),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10.0),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.storage,
                      color: Colors.black.withOpacity(0.5),
                    ),
                    SizedBox(
                      width: 16.0,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        border: Border.all(
                            color: Colors.black.withOpacity(0.5),
                            style: BorderStyle.solid,
                            width: 1),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                            items: [
                              DropdownMenuItem<String>(
                                value: "Invoice number",
                                child: Center(child: Text("Invoice number")),
                              ),
                              DropdownMenuItem<String>(
                                value: "Purchase order number",
                                child: Center(
                                    child: Text("Purchase order number")),
                              ),
                              DropdownMenuItem<String>(
                                value: "Order confirmation number",
                                child: Center(
                                    child: Text("Order confirmation number")),
                              )
                            ],
                            onChanged: (_value) => {
                                  print(_value.toString()),
                                  setState(() {
                                    _dispatchConfirmation = _value;
                                    dropDownValue = _value;
                                  })
                                },
                            hint: Text(
                              "$dropDownValue",
                              style: TextStyle(
                                color:
                                    dropDownValue == "Select reference document"
                                        ? Colors.grey[600]
                                        : Colors.black,
                              ),
                            )),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: recordInputController,
                  decoration: InputDecoration(
                      icon: Icon(Icons.receipt),
                      labelText: 'Reference number',
                      border: const OutlineInputBorder()),
                  onSaved: (val) => setState(() => _dispatchRecord = val),
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Please enter the reference number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                Center(
                  child: Container(
                    //  margin: EdgeInsets.only(left: 40.0, top: 20.0),
                    child: Text(
                      "Select stove type:",
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.6), fontSize: 16.0),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                    width:
                        MediaQuery.of(context).size.width - screenPadding * 2,
                    child: LayoutBuilder(builder: (context, constraints) {
                      return ToggleButtons(
                        constraints: BoxConstraints.expand(
                            height: 55.0,
                            width: constraints.maxWidth / 3 -
                                2), //3 is the number of buttons, 2 is for the borders
                        borderColor: Colors.black.withOpacity(0.5),
                        fillColor: Colors.green[200],
                        color: Colors.grey[600],
                        borderWidth: 1.0,
                        selectedBorderColor: Colors.black,
                        selectedColor: Colors.black,
                        borderRadius: BorderRadius.circular(4.0),
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Jumbo',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Prime',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Smart',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                        onPressed: (int index) {
                          setState(() {
                            for (int i = 0; i < isSelectedStove.length; i++) {
                              if (i == index) {
                                isSelectedStove[i] = true;
                                selectedStove = stoveList[i];
                              } else {
                                isSelectedStove[i] = false;
                              }
                            }
                          });
                        },
                        isSelected: isSelectedStove,
                      );
                    })),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: amountInputController,
                  decoration: InputDecoration(
                      icon: Icon(Icons.category),
                      labelText: 'Quantity',
                      border: const OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                  onSaved: (val) => _dispatchAmount = int.parse(val),
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Please enter the quantity';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: placeInputController,
                  decoration: InputDecoration(
                      icon: Icon(MdiIcons.crosshairsGps),
                      labelText: 'Place of delivery',
                      border: const OutlineInputBorder()),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: pinInputController,
                  decoration: InputDecoration(
                      icon: Icon(Icons.near_me),
                      labelText: 'Pin code',
                      border: const OutlineInputBorder()),
                ),
//                Container(
//                  margin: EdgeInsets.only(top: 20.0, left: 40.0),
//                  child: Text(
//                    "Dispatch type:",
//                    style: TextStyle(
//                        color: Colors.black.withOpacity(0.6), fontSize: 16.0),
//                  ),
//                ),
                SizedBox(height: 20.0),
                Center(
                  child: Container(
                    //  margin: EdgeInsets.only(left: 40.0, top: 20.0),
                    child: Text(
                      "Select transporation type:",
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.6), fontSize: 16.0),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                _transporation(),
                SizedBox(
                  height: 20.0,
                ),
//                Center(
//                  child: Container(
//                    height: 100.0,
//                    child: Expanded(
//                        child: GridView.count(
//                      crossAxisCount: 5,
//                      scrollDirection: Axis.vertical,
//                      primary: false,
//                      children: List.generate(dispatchTypes.length, (index) {
//                        return _buildInfoCard(
//                            dispatchTypes[dispatchKeys[index]],
//                            dispatchKeys[index],
//                            "transportation");
//                      }),
//                    )),
//                  ),
//                ),
                Center(
                  child: RaisedButton(
                    color: Colors.green,
                    textColor: Colors.white,
                    child: Text("Continue"),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        widget.dispatch.dispatchType =
                            selectedTransportationCard;
                        _dispatchType = selectedTransportationCard;
                        setValues(
                          _dispatchConfirmation,
                          recordInputController.text,
                          selectedStove,
                          int.parse(amountInputController.text),
                          widget.area,
                          _dispatchType,
                        );
                        if (selectedTransporation == 'Road') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RoadContactView(
                                      dispatch: widget.dispatch,
                                      area: widget.area)));
                        } else if (selectedTransporation == 'Courier') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CourierContactView(
                                      dispatch: widget.dispatch,
                                      area: widget.area)));
                        } else if (selectedTransporation == 'Sea') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ContainerContactView(
                                      dispatch: widget.dispatch)));
                        } else if (selectedTransporation == 'Air') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AirContactView(
                                      dispatch: widget.dispatch)));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OtherContactView(
                                      dispatch: widget.dispatch)));
                        }
                        ;
                      }
                    },
                  ),
                ),
                //onSaved: (val) => setState(() => _user.truckNumber = val))),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _transporation() {
    if (widget.area == 'international') {
      return Container(
          width: MediaQuery.of(context).size.width - screenPadding * 2,
          child: LayoutBuilder(builder: (context, constraints) {
            return ToggleButtons(
              constraints: BoxConstraints.expand(
                  width: constraints.maxWidth / 4 -
                      2), //3 is the number of buttons, 2 is for the borders
              borderColor: Colors.grey[500],
              fillColor: Colors.green[200],
              borderWidth: 1.0,
              color: Colors.grey[600],
              selectedBorderColor: Colors.black,
              selectedColor: Colors.black,
              borderRadius: BorderRadius.circular(4.0),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.local_shipping),
                      Text('Road', style: TextStyle(fontSize: 16))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.airplanemode_active),
                      Text('Air', style: TextStyle(fontSize: 16))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.directions_boat),
                      Text('Sea', style: TextStyle(fontSize: 16))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.group),
                      Text('Other', style: TextStyle(fontSize: 16))
                    ],
                  ),
                )
              ],
              onPressed: (int index) {
                setState(() {
                  for (int i = 0;
                      i < isSelectedIntlTransportation.length;
                      i++) {
                    if (i == index) {
                      isSelectedIntlTransportation[i] = true;
                      selectedTransporation = intlTransporationList[i];
                      print(selectedTransporation);
                    } else {
                      isSelectedIntlTransportation[i] = false;
                    }
                  }
                });
              },
              isSelected: isSelectedIntlTransportation,
            );
          }));
    } else {
      return Container(
          width: MediaQuery.of(context).size.width - screenPadding * 2,
          child: LayoutBuilder(builder: (context, constraints) {
            return ToggleButtons(
              constraints: BoxConstraints.expand(
                  width: constraints.maxWidth / 5 -
                      2), //3 is the number of buttons, 2 is for the borders
              borderColor: Colors.grey[500],
              fillColor: Colors.green[200],
              borderWidth: 1.0,
              color: Colors.grey[600],
              selectedBorderColor: Colors.black,
              selectedColor: Colors.black,
              borderRadius: BorderRadius.circular(4.0),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.local_shipping),
                      Text('Road', style: TextStyle(fontSize: 16))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.airplanemode_active),
                      Text('Air', style: TextStyle(fontSize: 16))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.mail),
                      Text('Courier', style: TextStyle(fontSize: 16))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.train),
                      Text('Rail', style: TextStyle(fontSize: 16))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.group),
                      Text('Other', style: TextStyle(fontSize: 16))
                    ],
                  ),
                )
              ],
              onPressed: (int index) {
                setState(() {
                  for (int i = 0;
                      i < isSelectedDomesticTransportation.length;
                      i++) {
                    if (i == index) {
                      isSelectedDomesticTransportation[i] = true;
                      selectedTransporation = domesticTransporationList[i];
                      print(selectedTransporation);
                    } else {
                      isSelectedDomesticTransportation[i] = false;
                    }
                  }
                });
              },
              isSelected: isSelectedDomesticTransportation,
            );
          }));
    }
  }

  Widget _buildInfoCard(Icon iconName, String text, String source) {
    return InkWell(
        onTap: () {
          selectCard(text, source);
        },
        child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            curve: Curves.easeIn,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              color: (text == selectedStoveCard ||
                      text == selectedAreaCard ||
                      text == selectedTransportationCard)
                  ? Colors.green.withOpacity(0.7)
                  : Colors.white,
              border: Border.all(
                  color: (text == selectedStoveCard ||
                          text == selectedAreaCard ||
                          text == selectedTransportationCard)
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

  selectCard(text, source) {
    if (source == "stove") {
      setState(() {
        selectedStoveCard = text;
      });
    } else if (source == "area") {
      setState(() {
        selectedAreaCard = text;
      });
    } else if (source == "transportation") {
      setState(() {
        selectedTransportationCard = text;
      });
    }
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
