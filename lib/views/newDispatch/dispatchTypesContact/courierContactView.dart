//THIS PAGE SHOWS THE CONTACT INFORMATION AFTER CHOOSING LOGISTICS DELIVERY

import 'package:flutter/material.dart';
import 'package:greenwaydispatch/models/Dispatch.dart';
import 'package:greenwaydispatch/views/newDispatch/QRView.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CourierContactView extends StatefulWidget {
  final Dispatch dispatch;
  final String area;
  //final DispatchContact dispatchContact;
  CourierContactView({Key key, @required this.dispatch, @required this.area})
      : super(key: key);

  @override
  _CourierContactViewState createState() => _CourierContactViewState();
}

class _CourierContactViewState extends State<CourierContactView> {
  var _formKey = GlobalKey<FormState>();
  TextEditingController trackingNumberController = new TextEditingController();
  TextEditingController contactNumberController = new TextEditingController();
  TextEditingController additionalInfoController = new TextEditingController();
  String dropDownValue = "Select logistics vendor";
  String _logisticsVendor;

  void setValues(String trackingNumber, String logisticsVendor,
      int contactNumber, String additionalInfo) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    shared.setString('trackingNumber', trackingNumber);
    shared.setString('logisticsVendor', logisticsVendor);
    shared.setInt('contactNumber', contactNumber);
    shared.setString('additionalInfo', additionalInfo);
  }

  void dispose() {
    trackingNumberController.dispose();
    contactNumberController.dispose();
    additionalInfoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New dispatch: Courier delivery"),
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: trackingNumberController,
                decoration: InputDecoration(
                    icon: Icon(Icons.local_post_office),
                    labelText: 'Tracking number',
                    //              helperText: 'e.g. AB123ABC1234',
                    border: const OutlineInputBorder()),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter tracking number';
                  }
                },
//                  onSaved: (val) =>
//                      setState(() => widget.dispatch.truckNumber = val)
              ),
              SizedBox(height: 20.0),
              Row(children: <Widget>[
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
                            value: "Local",
                            child: Center(child: Text("Local")),
                          ),
                          DropdownMenuItem<String>(
                            value: "FedEx",
                            child: Center(child: Text("FedEx")),
                          ),
                          DropdownMenuItem<String>(
                            value: "VRL",
                            child: Center(child: Text("VRL")),
                          ),
                          DropdownMenuItem<String>(
                            value: "TCI",
                            child: Center(child: Text("TCI")),
                          )
                        ],
                        onChanged: (_value) => {
                              print(_value.toString()),
                              setState(() {
                                _logisticsVendor = _value;
                                dropDownValue = _value;
                              })
                            },
                        hint: Text(
                          "$dropDownValue",
                          style: TextStyle(
                            color: dropDownValue == "Select logistics vendor"
                                ? Colors.grey[600]
                                : Colors.black,
                          ),
                        )),
                  ),
                ),
              ]),
              SizedBox(height: 20.0),
              TextFormField(
                  controller: contactNumberController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      icon: Icon(Icons.phone),
                      labelText: 'Contact number',
                      border: const OutlineInputBorder()),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter contact number';
                    }
                  }),
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
                      setValues(
                          trackingNumberController.text,
                          _logisticsVendor,
                          int.parse(contactNumberController.text),
                          additionalInfoController.text);
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
