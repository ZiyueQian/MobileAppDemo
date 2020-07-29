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
          title: Text("Dispatch ${widget.dispatch.dispatchRecord}"),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
          child: Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Amount: ${widget.dispatch.dispatchAmount}"),
                  Text("Type: ${widget.dispatch.dispatchType}"),
                  Text("Date: ${widget.dispatch.dispatchTime}"),
                  Text("Confirmation: ${widget.dispatch.dispatchConfirmation}"),
                  moreInfo(widget.dispatch),
                  dispatchButton(widget.dispatchNow, context)
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
                  _historyBloc.add(AddHistory(widget.dispatch));
                  _dispatchBloc.add(DeleteDispatch(widget.dispatch));
                  Navigator.of(context).popUntil((route) => route.isFirst);
                })),
      );
    } else {
      return Text("");
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
