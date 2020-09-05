//THIS PAGE SHOWS THE CONTACT INFORMATION AFTER CHOOSING AIR DELIVERY

import 'package:flutter/material.dart';
import 'package:greenwaydispatch/models/Dispatch.dart';
import 'package:greenwaydispatch/views/newDispatch/QRView.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AirContactView extends StatefulWidget {
  final Dispatch dispatch;
  //final DispatchContact dispatchContact;
  AirContactView({Key key, @required this.dispatch}) : super(key: key);

  @override
  _AirContactViewState createState() => _AirContactViewState();
}

class _AirContactViewState extends State<AirContactView> {
  TextEditingController deliveryController = new TextEditingController();
  TextEditingController deliveryNumberController = new TextEditingController();
  TextEditingController recipientController = new TextEditingController();
  TextEditingController recipientNumberController = new TextEditingController();
  String dropDownValueLogistics = "Select logistics vendor";
  String _logisticsVendor;
  String dropDownValueFreight = "Select freight forwarders";
  String _freightForwarders;

  void setValues(String contactPerson, int contactNumber,
      String recipientPerson, int recipientContactNumber) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    shared.setString('contactPerson', contactPerson);
    shared.setInt('contactNumber', contactNumber);
    shared.setString('recipientPerson', recipientPerson);
    shared.setInt('recipientContactNumber', recipientContactNumber);
  }

  void dispose() {
    deliveryController.dispose();
    deliveryNumberController.dispose();
    recipientController.dispose();
    recipientNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New dispatch: Air delivery"),
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: deliveryController,
              decoration: InputDecoration(
                  icon: Icon(Icons.confirmation_number),
                  labelText: 'Tracking number',
                  border: const OutlineInputBorder()),
            ),
            SizedBox(height: 20.0),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              Icon(
                Icons.storage,
                color: Colors.black.withOpacity(0.5),
              ),
              SizedBox(
                width: 16.0,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
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
                          value: "FedEx",
                          child: Center(child: Text("FedEx")),
                        ),
                        DropdownMenuItem<String>(
                          value: "TNT",
                          child: Center(child: Text("TNT")),
                        ),
                        DropdownMenuItem<String>(
                          value: "DHL",
                          child: Center(child: Text("DHL")),
                        ),
                        DropdownMenuItem<String>(
                          value: "IndiaPost",
                          child: Center(child: Text("IndiaPost")),
                        )
                      ],
                      onChanged: (_value) => {
                            print(_value.toString()),
                            setState(() {
                              _logisticsVendor = _value;
                              dropDownValueLogistics = _value;
                            })
                          },
                      hint: Text(
                        "$dropDownValueLogistics",
                        style: TextStyle(
                          color: dropDownValueLogistics ==
                                  "Select logistics vendor"
                              ? Colors.grey[600]
                              : Colors.black,
                        ),
                      )),
                ),
              ),
            ]),
            SizedBox(height: 20.0),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              Icon(
                Icons.storage,
                color: Colors.black.withOpacity(0.5),
              ),
              SizedBox(
                width: 16.0,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
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
                          child: Center(child: Text("Dhanlabh Logistics")),
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
              decoration: InputDecoration(
                  icon: Icon(Icons.confirmation_number),
                  labelText: 'E-way bill number',
                  border: const OutlineInputBorder()),
            ),
            SizedBox(height: 20.0),
            TextFormField(
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
                  setValues(
                      deliveryController.text,
                      int.parse(deliveryNumberController.text),
                      recipientController.text,
                      int.parse(recipientNumberController.text));
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              QRView(dispatch: widget.dispatch)));
                },
              ),
            ),
            //onSaved: (val) => setState(() => _user.truckNumber = val))),
          ],
        ),
      ),
    );
  }
}
