//THIS PAGE SHOWS THE CONTACT INFORMATION AFTER CHOOSING 'OTHER' DELIVERY METHOD

import 'package:flutter/material.dart';
import 'package:greenwaydispatch/models/Dispatch.dart';
import 'package:greenwaydispatch/views/newDispatch/QRView.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtherContactView extends StatefulWidget {
  final Dispatch dispatch;
  //final DispatchContact dispatchContact;
  OtherContactView({Key key, @required this.dispatch}) : super(key: key);

  @override
  _OtherContactViewState createState() => _OtherContactViewState();
}

class _OtherContactViewState extends State<OtherContactView> {
  TextEditingController contactInputController = new TextEditingController();
  TextEditingController numberInputController = new TextEditingController();
  TextEditingController descriptionInputController =
      new TextEditingController();

  void setValues(
      String contactPerson, int contactNumber, String description) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    shared.setString('contactPerson', contactPerson);
    shared.setInt('contactNumber', contactNumber);
    shared.setString('description', description);
  }

  void dispose() {
    contactInputController.dispose();
    numberInputController.dispose();
    descriptionInputController.dispose();
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
                controller: contactInputController,
                decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: 'Contact name',
                    helperText: 'e.g. Ankit Mathur',
                    border: const OutlineInputBorder()),
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
              child: TextFormField(
                controller: numberInputController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    icon: Icon(Icons.phone),
                    labelText: 'Contact number',
                    helperText: 'e.g. 1234567890',
                    border: const OutlineInputBorder()),
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
              child: TextFormField(
                controller: descriptionInputController,
                decoration: InputDecoration(
                    icon: Icon(Icons.reorder),
                    labelText: 'Description',
                    border: const OutlineInputBorder()),
              )),
          RaisedButton(
            child: Text("Next"),
            onPressed: () {
              setValues(
                  contactInputController.text,
                  int.parse(numberInputController.text),
                  descriptionInputController.text);
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
