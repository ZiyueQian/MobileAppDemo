//THIS PAGE SHOWS THE CONTACT INFORMATION AFTER CHOOSING CONTAINER DELIVERY

import 'package:flutter/material.dart';
import 'package:greenwaydispatch/models/Dispatch.dart';
import 'package:greenwaydispatch/views/newDispatch/QRView.dart';

class ContainerContactView extends StatefulWidget {
  final Dispatch dispatch;
  //final DispatchContact dispatchContact;
  ContainerContactView({Key key, @required this.dispatch}) : super(key: key);

  @override
  _ContainerContactViewState createState() => _ContainerContactViewState();
}

class _ContainerContactViewState extends State<ContainerContactView> {
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
                    icon: Icon(Icons.directions_boat),
                    labelText: 'Container number',
                    helperText: 'e.g. ABCD123456',
                    border: const OutlineInputBorder()),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter container number';
                  }
                },
//                  onSaved: (val) =>
//                      setState(() => widget.dispatch.truckNumber = val)
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
              child: TextFormField(
                decoration: InputDecoration(
                    icon: Icon(Icons.location_on),
                    labelText: 'Customs clearing point',
                    helperText: 'e.g. Somewhere',
                    border: const OutlineInputBorder()),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter customs clearing point';
                  }
                },
//                  onSaved: (val) =>
//                      setState(() => widget.dispatch.truckNumber = val)
              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
              child: TextFormField(
                decoration: InputDecoration(
                    icon: Icon(Icons.perm_identity),
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