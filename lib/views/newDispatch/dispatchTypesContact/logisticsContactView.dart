//THIS PAGE SHOWS THE CONTACT INFORMATION AFTER CHOOSING LOGISTICS DELIVERY

import 'package:flutter/material.dart';
import 'package:greenwaydispatch/models/Dispatch.dart';
import 'package:greenwaydispatch/views/newDispatch/QRView.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogisticsContactView extends StatefulWidget {
  final Dispatch dispatch;
  //final DispatchContact dispatchContact;
  LogisticsContactView({Key key, @required this.dispatch}) : super(key: key);

  @override
  _LogisticsContactViewState createState() => _LogisticsContactViewState();
}

class _LogisticsContactViewState extends State<LogisticsContactView> {
  TextEditingController docketInputController = new TextEditingController();
  TextEditingController contactInputController = new TextEditingController();
  TextEditingController contactNumberInputController =
      new TextEditingController();

  void setValues(
      String docketNumber, String contactPerson, int contactNumber) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    shared.setString('docketNumber', docketNumber);
    shared.setString('contactPerson', contactPerson);
    shared.setInt('contactNumber', contactNumber);
  }

  void dispose() {
    docketInputController.dispose();
    contactInputController.dispose();
    contactNumberInputController.dispose();
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
                controller: docketInputController,
                decoration: InputDecoration(
                    icon: Icon(Icons.local_post_office),
                    labelText: 'Docket number',
                    helperText: 'e.g. AB123ABC1234',
                    border: const OutlineInputBorder()),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter docket number';
                  }
                },
//                  onSaved: (val) =>
//                      setState(() => widget.dispatch.truckNumber = val)
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
              child: TextFormField(
                controller: contactInputController,
                decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: 'Contact person',
                    helperText: 'e.g. Ankit Mathur',
                    border: const OutlineInputBorder()),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter contact person's name";
                  }
                },
//                  onSaved: (val) =>
//                      setState(() => widget.dispatch.truckDriver = val)
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
              child: TextFormField(
                controller: contactNumberInputController,
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
          RaisedButton(
            child: Text("Next"),
            onPressed: () {
              setValues(docketInputController.text, contactInputController.text,
                  int.parse(contactNumberInputController.text));
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
