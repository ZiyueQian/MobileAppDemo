//THIS PAGE SHOWS THE CONTACT INFORMATION AFTER CHOOSING HAND DELIVERY

import 'package:flutter/material.dart';
import 'package:greenwaydispatch/models/Dispatch.dart';
import 'package:greenwaydispatch/views/newDispatch/QRView.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HandContactView extends StatefulWidget {
  final Dispatch dispatch;
  //final DispatchContact dispatchContact;
  HandContactView({Key key, @required this.dispatch}) : super(key: key);

  @override
  _HandContactViewState createState() => _HandContactViewState();
}

class _HandContactViewState extends State<HandContactView> {
  TextEditingController deliveryController = new TextEditingController();
  TextEditingController deliveryNumberController = new TextEditingController();
  TextEditingController recipientController = new TextEditingController();
  TextEditingController recipientNumberController = new TextEditingController();

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
        title: Text(
            "New dispatch ${widget.dispatch.dispatchRecord}: ${widget.dispatch.dispatchType} delivery"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 15.0),
          Container(
              margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
              child: TextFormField(
                controller: deliveryController,
                decoration: InputDecoration(
                    icon: Icon(Icons.transfer_within_a_station),
                    labelText: 'Delivery person',
                    helperText: 'e.g. Ankit Mathur',
                    border: const OutlineInputBorder()),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter delivery person's name";
                  }
                },
//                  onSaved: (val) =>
//                      setState(() => widget.dispatch.truckNumber = val)
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              child: TextFormField(
                controller: deliveryNumberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    icon: Icon(Icons.phone),
                    labelText: 'Contact number',
                    helperText: 'e.g. 1234567890',
                    border: const OutlineInputBorder()),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter receive person's phone number";
                  }
                },
//                  onSaved: (val) => setState(
//                      () => widget.dispatch.truckDriverNumber1 = val)
              )),
          Icon(Icons.arrow_downward, color: Colors.grey[600]),
          Container(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              child: TextFormField(
                controller: recipientController,
                decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: 'Recipient person',
                    helperText: 'e.g. Ankit Mathur',
                    border: const OutlineInputBorder()),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter receive person's name";
                  }
                },
//                  onSaved: (val) =>
//                      setState(() => widget.dispatch.truckDriver = val)
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
              child: TextFormField(
                controller: recipientNumberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    icon: Icon(Icons.phone),
                    labelText: 'Contact number',
                    helperText: 'e.g. 1234567890',
                    border: const OutlineInputBorder()),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter receive person's phone number";
                  }
                },
//                  onSaved: (val) => setState(
//                      () => widget.dispatch.truckDriverNumber1 = val)
              )),
          RaisedButton(
            child: Text("Next"),
            onPressed: () {
              setValues(
                  deliveryController.text,
                  int.parse(deliveryNumberController.text),
                  recipientController.text,
                  int.parse(recipientNumberController.text));
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
