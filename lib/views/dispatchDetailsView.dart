import 'package:flutter/material.dart';
import '../models/Dispatch.dart';
import 'package:greenwaydispatch/data/dispatch_bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenwaydispatch/data/dispatch_dao.dart';
import 'package:greenwaydispatch/data/history_dao.dart';
import 'package:greenwaydispatch/data/history_bloc/historyBloc.dart';

class DispatchDetailsView extends StatefulWidget {
  var dispatch;
  bool dispatchNow;

  DispatchDetailsView(
      {Key key, @required this.dispatch, @required this.dispatchNow})
      : super(key: key);

  @override
  _DispatchDetailsViewState createState() => _DispatchDetailsViewState();
}

class _DispatchDetailsViewState extends State<DispatchDetailsView> {
  @override
  DispatchBloc _dispatchBloc;
  DispatchDAO _dispatchDAO = DispatchDAO();
  HistoryBloc _historyBloc;
  HistoryDAO _historyDAO = HistoryDAO();

  void initState() {
    super.initState();
    _dispatchBloc = BlocProvider.of<DispatchBloc>(context);
    _dispatchBloc.add(LoadDispatches());
    _historyBloc = BlocProvider.of<HistoryBloc>(context);
    _historyBloc.add(LoadHistory());
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Reference number: ${widget.dispatch.dispatchRecord}"),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
          child: Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Amount: ${widget.dispatch.dispatchAmount}"),
                  SizedBox(height: 5.0),
                  Text("Type: ${widget.dispatch.dispatchType}"),
                  SizedBox(height: 5.0),
                  Text("Date: ${widget.dispatch.dispatchTime}"),
                  SizedBox(height: 5.0),
                  Text("Confirmation: ${widget.dispatch.dispatchConfirmation}"),
                  SizedBox(height: 20.0),
                  moreInfo(widget.dispatch),
                  dispatchButton(widget.dispatchNow, context)
                ],
              )),
        ));
  }

  Widget dispatchButton(bool dispatchNow, BuildContext context) {
    if (dispatchNow == true) {
      return Expanded(
        child: FlatButton(
            child: Container(
              height: 50,
              // margin: EdgeInsets.symmetric(horizontal: 60),
              child: Center(
                child: Text(
                  "Dispatch now",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
              ),
              decoration: BoxDecoration(
                  // color: Color(0xFF8BC34A),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.green),
            ),
            onPressed: () {
              _historyBloc.add(AddHistory(widget.dispatch));
              _dispatchBloc.add(DeleteDispatch(widget.dispatch));
              Navigator.of(context).popUntil((route) => route.isFirst);
            }),
      );
    } else {
      return Text("");
    }
  }

  Widget moreInfo(Dispatch dispatch) {
    if (dispatch.dispatchType == 'road') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Road delivery", style: TextStyle(fontWeight: FontWeight.bold)),
          Text("Truck number: ${dispatch.truckNumber}"),
          Text("Contact person: ${dispatch.contactPerson}"),
          Text("Contact number: ${dispatch.contactNumber}"),
          Text("Alternative contact: ${dispatch.alternativeContactNumber}"),
        ],
      );
    } else if (dispatch.dispatchType == 'courier') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Courier delivery",
              style: TextStyle(fontWeight: FontWeight.bold)),
          Text("Contact person: ${dispatch.contactPerson}"),
          Text("Contact number: ${dispatch.contactNumber}"),
          Text("Docket number: ${dispatch.docketNumber}"),
        ],
      );
    } else if (dispatch.dispatchType == 'sea') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Sea delivery", style: TextStyle(fontWeight: FontWeight.bold)),
          Text("Contact person: ${dispatch.contactPerson}"),
          Text("Contact number: ${dispatch.contactNumber}"),
          Text("Container number: ${dispatch.containerNumber}"),
          Text("Customs clearing point: ${dispatch.customsClearingPoint}"),
        ],
      );
    } else if (dispatch.dispatchType == 'air') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Air delivery", style: TextStyle(fontWeight: FontWeight.bold)),
          Text("Contact person: ${dispatch.contactPerson}"),
          Text("Contact number: ${dispatch.contactNumber}"),
          Text("Recipient person: ${dispatch.recipientPerson}"),
          Text("Recipient contact number: ${dispatch.recipientContactNumber}"),
        ],
      );
    } else if (dispatch.dispatchType == 'rail') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Rail delivery", style: TextStyle(fontWeight: FontWeight.bold)),
          Text("Contact person: ${dispatch.contactPerson}"),
          Text("Contact number: ${dispatch.contactNumber}"),
          Text("Description: ${dispatch.description}"),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Other delivery", style: TextStyle(fontWeight: FontWeight.bold))
        ],
      );
    }
  }
}
