//THIS PAGE SHOWS THE CONTACT INFORMATION AFTER CHOOSING 'OTHER' DELIVERY METHOD

import 'package:flutter/material.dart';
import 'package:greenwaydispatch/models/Dispatch.dart';
import 'package:greenwaydispatch/views/newDispatch/QRView.dart';

class OtherContactView extends StatefulWidget {
  final Dispatch dispatch;
  //final DispatchContact dispatchContact;
  OtherContactView({Key key, @required this.dispatch}) : super(key: key);

  @override
  _OtherContactViewState createState() => _OtherContactViewState();
}

class _OtherContactViewState extends State<OtherContactView> {
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
                decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: 'Contact name',
                    helperText: 'e.g. Ankit Mathur',
                    border: const OutlineInputBorder()),
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
              child: TextFormField(
                decoration: InputDecoration(
                    icon: Icon(Icons.phone),
                    labelText: 'Contact number',
                    helperText: 'e.g. 1234567890',
                    border: const OutlineInputBorder()),
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
              child: TextFormField(
                decoration: InputDecoration(
                    icon: Icon(Icons.reorder),
                    labelText: 'Description',
                    border: const OutlineInputBorder()),
              )),
          RaisedButton(
            child: Text("Next"),
            onPressed: () {
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
