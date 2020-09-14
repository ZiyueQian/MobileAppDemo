//THIS PAGE SHOWS THE CONTACT INFORMATION AFTER CHOOSING RAIL DELIVERY

import 'package:flutter/material.dart';
import 'package:greenwaydispatch/models/Dispatch.dart';
import 'package:greenwaydispatch/views/newDispatch/QRView.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:greenwaydispatch/views/newDispatch/functions/scan.dart';

class RailContactView extends StatefulWidget {
  final Dispatch dispatch;
  //final DispatchContact dispatchContact;
  RailContactView({Key key, @required this.dispatch}) : super(key: key);

  @override
  _RailContactViewState createState() => _RailContactViewState();
}

class _RailContactViewState extends State<RailContactView> {
  var _formKey = GlobalKey<FormState>();
  TextEditingController trackingNumberController = new TextEditingController();
  TextEditingController ewayBillController = new TextEditingController();
  TextEditingController additionalInfoController = new TextEditingController();
  String dropDownValueFreight = "Select freight forwarders";
  String _freightForwarders;

  void setValues(String trackingNumber, String freightForwarders,
      String ewayBillNo, String additional) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    shared.setString('trackingNumber', trackingNumber);
    shared.setString('freightForwarders', freightForwarders);
    shared.setString('ewayBillNo', ewayBillNo);
    shared.setString('additional', additional);
  }

  void dispose() {
    trackingNumberController.dispose();
    ewayBillController.dispose();
    additionalInfoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New dispatch: Rail delivery"),
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: trackingNumberController,
                decoration: InputDecoration(
                    icon: Icon(Icons.confirmation_number),
                    labelText: 'Tracking number',
                    border: const OutlineInputBorder()),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter tracking number';
                  }
                },
              ),
              SizedBox(height: 20.0),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                            width: 0.80),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                            items: [
                              DropdownMenuItem<String>(
                                value: "Overseas Express",
                                child: Center(child: Text("Overseas Express")),
                              ),
                              DropdownMenuItem<String>(
                                value: "Harsiddhi",
                                child: Center(child: Text("Harsiddhi")),
                              ),
                              DropdownMenuItem<String>(
                                value: "Star Logistics",
                                child: Center(child: Text("Star Logistics")),
                              ),
                              DropdownMenuItem<String>(
                                value: "Aaditya Logistics",
                                child: Center(child: Text("Aaditya Logistics")),
                              ),
                              DropdownMenuItem<String>(
                                value: "Dhanlabh Logistics",
                                child:
                                    Center(child: Text("Dhanlabh Logistics")),
                              )
                            ],
                            onChanged: (_value) => {
                                  print(_value.toString()),
                                  setState(() {
                                    _freightForwarders = _value;
                                    dropDownValueFreight = _value;
                                  })
                                },
                            hint: Text(
                              "$dropDownValueFreight",
                              style: TextStyle(
                                color: dropDownValueFreight ==
                                        "Select freight forwarders"
                                    ? Colors.grey[600]
                                    : Colors.black,
                              ),
                            )),
                      ),
                    ),
                  ]),
              SizedBox(height: 20.0),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                controller: ewayBillController,
                decoration: InputDecoration(
                  icon: Icon(Icons.confirmation_number),
                  labelText: 'E-way bill number',
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
              SizedBox(height: 20.0),
              TextFormField(
                controller: additionalInfoController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    icon: Icon(Icons.info),
                    labelText: 'Additional information',
                    border: const OutlineInputBorder()),
              ),
              SizedBox(height: 20.0),
              Center(
                child: RaisedButton(
                  color: Colors.green,
                  textColor: Colors.white,
                  child: Text("Continue"),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  QRView(dispatch: widget.dispatch)));
                    }
                  },
                ),
              ),
              //onSaved: (val) => setState(() => _user.truckNumber = val))),
            ],
          ),
        ),
      ),
    );
  }
}
