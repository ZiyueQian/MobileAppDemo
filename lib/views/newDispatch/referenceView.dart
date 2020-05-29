//THIS PAGE SHOWS THE FIRST PAGE OF THE FORM FOR A NEW DISPATCH

import 'package:flutter/material.dart';
import 'package:greenwaydispatch/models/Dispatch.dart';
import 'package:greenwaydispatch/views/newDispatch/truckContactView.dart';
import 'package:greenwaydispatch/views/newDispatch/logisticsContactView.dart';
import 'package:greenwaydispatch/views/newDispatch/containerContactView.dart';
import 'package:greenwaydispatch/views/newDispatch/handContactView.dart';

class DispatchReferenceView extends StatefulWidget {
  final Dispatch dispatch;
  DispatchReferenceView({Key key, @required this.dispatch}) : super(key: key);

  @override
  _DispatchReferenceViewState createState() => _DispatchReferenceViewState();
}

class _DispatchReferenceViewState extends State<DispatchReferenceView> {
  String value = "Select";

  @override
  Widget build(BuildContext context) {
    final dispatchTypes = widget.dispatch.types();
    var dispatchKeys = dispatchTypes.keys.toList();
    bool _pressAttention = false; //for the button of dispatchType

    TextEditingController _titleController = new TextEditingController();
    _titleController.text = widget.dispatch.dispatchRecord;

    return Scaffold(
      appBar: AppBar(
        title: Text('New dispatch'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10.0),
          Container(
              margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.storage,
                    color: Colors.grey[600],
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  DropdownButton(
                    items: [
                      DropdownMenuItem<String>(
                        value: "Invoice",
                        child: Center(child: Text("Invoice")),
                      ),
                      DropdownMenuItem<String>(
                        value: "Packing List",
                        child: Center(child: Text("Packing List")),
                      ),
                      DropdownMenuItem<String>(
                        value: "Confirmation number",
                        child: Center(child: Text("Confirmation number")),
                      )
                    ],
                    onChanged: (_value) => {
                      print(_value.toString()),
                      setState(() {
                        value = _value;
                      })
                    },
                    hint: Text("$value"),
                  ),
                ],
              )),
//          Container(
//              margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
//              child: TextField(
//                controller: _titleController,
//                autofocus: true,
//              )),
          Container(
              margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
              child: TextFormField(
                  decoration: InputDecoration(
                      icon: Icon(Icons.receipt),
                      labelText: 'Reference number',
                      helperText: 'e.g. 1234567890',
                      border: const OutlineInputBorder()),
                  onSaved: (val) =>
                      setState(() => widget.dispatch.dispatchRecord = val))),
          Container(
              margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
              child: TextFormField(
                  decoration: InputDecoration(
                      icon: Icon(Icons.category),
                      labelText: 'Quantity',
                      helperText: 'e.g. 5',
                      border: const OutlineInputBorder()),
                  onSaved: (val) => setState(
                      () => widget.dispatch.dispatchAmount = int.parse(val)))),
          Expanded(
              child: GridView.count(
            crossAxisCount: 4,
            scrollDirection: Axis.vertical,
            primary: false,
            children: List.generate(dispatchTypes.length, (index) {
              return FlatButton(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    dispatchTypes[dispatchKeys[index]],
                    Text(dispatchKeys[index]),
                  ],
                ),
                //color: Colors.green[100],
                splashColor: Colors.green[400],
                onPressed: () {
                  widget.dispatch.dispatchType = dispatchKeys[index];
//                  setState(() {
//                    _pressAttention = !_pressAttention;
//                  });
                },
              );
            }),
          )),
          RaisedButton(
            child: Text("Continue"),
            onPressed: () {
              widget.dispatch.dispatchRecord = _titleController.text;
              widget.dispatch.dispatchTime = DateTime.now();
              if (widget.dispatch.dispatchType == 'truck') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            TruckContactView(dispatch: widget.dispatch)));
              } else if (widget.dispatch.dispatchType == 'logistics') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            LogisticsContactView(dispatch: widget.dispatch)));
              } else if (widget.dispatch.dispatchType == 'container') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ContainerContactView(dispatch: widget.dispatch)));
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            HandContactView(dispatch: widget.dispatch)));
              }
              ;
            },
          ),
          //onSaved: (val) => setState(() => _user.truckNumber = val))),
        ],
      ),
    );
  }
}
