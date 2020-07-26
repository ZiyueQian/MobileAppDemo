import 'package:flutter/material.dart';
import '../models/Dispatch.dart';

class DispatchDetailsView extends StatelessWidget {
  var dispatch;
  bool dispatchNow;

  DispatchDetailsView(
      {Key key, @required this.dispatch, @required this.dispatchNow})
      : super(key: key);

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
                  Text("Confirmation: ${dispatch.dispatchConfirmation}"),
                  moreInfo(dispatch),
                  dispatchButton(dispatchNow, context)
                ],
              )),
        ));
  }

  Widget dispatchButton(bool dispatchNow, BuildContext context) {
    if (dispatchNow == true) {
      return Expanded(
        child: Align(
            alignment: Alignment.bottomCenter,
            child: RaisedButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text("Dispatch"),
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                })),
      );
    }
  }

  Widget moreInfo(Dispatch dispatch) {
    print('hello');
    if (dispatch.dispatchType == 'truck') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Truck number: ${dispatch.truckNumber}"),
          Text("Contact person: ${dispatch.contactPerson}"),
          Text("Contact number: ${dispatch.contactNumber}"),
          Text("Alternative contact: ${dispatch.alternativeContactNumber}"),
        ],
      );
    } else if (dispatch.dispatchType == 'logistics') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Contact person: ${dispatch.contactPerson}"),
          Text("Contact number: ${dispatch.contactNumber}"),
          Text("Docket number: ${dispatch.docketNumber}"),
        ],
      );
    } else if (dispatch.dispatchType == 'container') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Contact person: ${dispatch.contactPerson}"),
          Text("Contact number: ${dispatch.contactNumber}"),
          Text("Container number: ${dispatch.containerNumber}"),
          Text("Customs clearing point: ${dispatch.customsClearingPoint}"),
        ],
      );
    } else if (dispatch.dispatchType == 'hand') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Contact person: ${dispatch.contactPerson}"),
          Text("Contact number: ${dispatch.contactNumber}"),
          Text("Recipient person: ${dispatch.recipientPerson}"),
          Text("Recipient contact number: ${dispatch.recipientContactNumber}"),
        ],
      );
    } else if (dispatch.dispatchType == 'other') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Contact person: ${dispatch.contactPerson}"),
          Text("Contact number: ${dispatch.contactNumber}"),
          Text("Description: ${dispatch.description}"),
        ],
      );
    }
  }
}
