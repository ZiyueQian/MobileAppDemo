//THIS PAGE SHOWS THE CONTACT INFORMATION AFTER CHOOSING TRUCK DELIVERY

import 'package:flutter/material.dart';
import 'package:greenwaydispatch/models/Dispatch.dart';
import 'package:greenwaydispatch/views/newDispatch/QRView.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TruckContactView extends StatefulWidget {
  final Dispatch dispatch;
  //final DispatchContact dispatchContact;
  TruckContactView({Key key, @required this.dispatch}) : super(key: key);

  @override
  _TruckContactViewState createState() => _TruckContactViewState();
}

class _TruckContactViewState extends State<TruckContactView> {
  TextEditingController truckInputController = new TextEditingController();
  TextEditingController driverInputController = new TextEditingController();
  TextEditingController contactInputController = new TextEditingController();
  TextEditingController alternativeContactInputController =
      new TextEditingController();

  void setValues(String truckNumber, String contactPerson, int contactNumber,
      int alternativeContactNumber) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    shared.setString('truckNumber', truckNumber);
    shared.setString('contactPerson', contactPerson);
    shared.setInt('contactNumber', contactNumber);
    shared.setInt('alternativeContactNumber', alternativeContactNumber);
    print("container values set!");
  }

  void dispose() {
    truckInputController.dispose();
    driverInputController.dispose();
    contactInputController.dispose();
    alternativeContactInputController.dispose();
    super.dispose();
  }

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
          SizedBox(height: 10.0),
          Container(
              margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
              child: TextFormField(
                controller: truckInputController,
                decoration: InputDecoration(
                    icon: Icon(Icons.local_shipping),
                    labelText: 'Truck number',
                    helperText: 'e.g. XX12ABC1234',
                    border: const OutlineInputBorder()),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter truck number';
                  }
                },
//                  onSaved: (val) =>
//                      setState(() => widget.dispatch.truckNumber = val)
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
              child: TextFormField(
                controller: driverInputController,
                decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: 'Driver name',
                    helperText: 'e.g. Ankit Mathur',
                    border: const OutlineInputBorder()),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter driver name';
                  }
                },
//                  onSaved: (val) =>
//                      setState(() => widget.dispatch.truckDriver = val)
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
              child: TextFormField(
                controller: contactInputController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    icon: Icon(Icons.phone),
                    labelText: 'Contact number',
                    helperText: 'e.g. 1234567890',
                    border: const OutlineInputBorder()),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter phone number';
                  }
                },
//                  onSaved: (val) => setState(
//                      () => widget.dispatch.truckDriverNumber1 = val)
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
              child: TextFormField(
                controller: alternativeContactInputController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    icon: Icon(Icons.phone),
                    labelText: 'Alternate contact number',
                    helperText: 'e.g. 1234567890',
                    border: const OutlineInputBorder()),
//                  onSaved: (val) => setState(
//                      () => widget.dispatch.truckDriverNumber2 = val)
              )),
          RaisedButton(
            child: Text("Next"),
            onPressed: () {
              setValues(
                  truckInputController.text,
                  driverInputController.text,
                  int.parse(contactInputController.text),
                  int.parse(alternativeContactInputController.text));
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => QRView(dispatch: widget.dispatch)));
            },
          ),
          //onSaved: (val) => setState(() => _user.truckNumber = val))),
        ],
      ),
    );
  }
}
