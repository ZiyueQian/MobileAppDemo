import 'package:flutter/material.dart';
import '../models/Dispatch.dart';

class DispatchDetailsView extends StatelessWidget {
  var dispatch;

  DispatchDetailsView({Key key, @required this.dispatch}) : super(key: key);

//  @override
//  final dispatchBox = Hive.box('dispatch');
//  final historyBox = Hive.box('history');

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Dispatch ${dispatch.dispatchRecord}"),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
          child: Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Amount: ${dispatch.dispatchAmount}"),
                  Text("Type: ${dispatch.dispatchType}"),
                  Text("Date: ${dispatch.dispatchTime}"),
                  Text("Date: ${dispatch.dispatchConfirmation}"),
                  moreInfo(dispatch.dispatchType),
                  Center(
                      child: RaisedButton(
                          color: Colors.green,
                          child: Text("Dispatch"),
                          onPressed: () {
//                            historyBox.add(dispatch);
//                            dispatchBox.deleteAt(index);
                            Navigator.of(context)
                                .popUntil((route) => route.isFirst);
                          }))
                ],
              )),
        ));
  }

  Widget moreInfo(String dispatchType) {
    print('hello');
    dispatchType != Null
        ? Text("Contact person: ${dispatch.dispatchType}")
        : Intent.doNothing;

//    switch (dispatchType) {
//      case 'truck':
//        Text("Truck number: ${dispatch.truckNumber}");
//        Text("Contact person: ${dispatch.contactPerson}");
//        Text("Contact number: ${dispatch.contactNumber}");
//        Text("Alternative contact: ${dispatch.alternativeContactNumber}");
//        break;
//
//      case 'logistics':
//        Text("Contact person: ${dispatch.contactPerson}");
//        Text("Contact number: ${dispatch.contactNumber}");
//        Text("Docket number: ${dispatch.docketNumber}");
//        break;
//
//      case 'container':
//        Text("Contact person: ${dispatch.contactPerson}");
//        Text("Contact number: ${dispatch.contactNumber}");
//        Text("Container number: ${dispatch.containerNumber}");
//        Text("Customs clearing point: ${dispatch.customsClearingPoint}");
//        break;
//
//      case 'hand':
//        Text("Contact person: ${dispatch.contactPerson}");
//        Text("Contact number: ${dispatch.contactNumber}");
//        Text("Recipient person: ${dispatch.recipientPerson}");
//        Text("Recipient contact number: ${dispatch.recipientContactNumber}");
//        break;
//
//      case 'other':
//        Text("Contact person: ${dispatch.contactPerson}");
//        Text("Contact number: ${dispatch.contactNumber}");
//        Text("Description: ${dispatch.description}");
//        break;
//    }
  }
}
