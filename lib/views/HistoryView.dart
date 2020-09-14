//THIS IS THE PAGE FOR THE HISTORY TAB ON THE HOME SCREEN.
//CURRENTLY USING DUMMY DATA TO SIMULATE INFORMATION FOR WHAT'S BEEN DISPATCHED.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greenwaydispatch/views/dispatchDetailsView.dart';
import 'package:intl/intl.dart';
import '../models/Dispatch.dart';
import 'dispatchDetailsView.dart';
//import 'package:hive/hive.dart';
//import 'package:hive_flutter/hive_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'historyDetailsView.dart';
import 'package:greenwaydispatch/data/history_bloc/historyBloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryView extends StatefulWidget {
  @override
  _HistoryViewState createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  HistoryBloc _historyBloc;

  @override
  void initState() {
    super.initState();
    _historyBloc = BlocProvider.of<HistoryBloc>(context);
    _historyBloc.add(LoadHistory());
    print("initialized history!");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(16.0),
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(15.0),
          children: <Widget>[
            Text('History of dispatches',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green)),
            SizedBox(height: 20.0),
            BlocBuilder(
                cubit: _historyBloc,
                builder: (BuildContext context, HistoryState state) {
                  if (state is HistoryLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is HistoryLoaded &&
                      state.dispatches.length == 0) {
                    return Text(
                      "No dispatches!",
                    );
                  } else if (state is HistoryLoaded &&
                      state.dispatches.length != 0) {
                    print("building listView");
                    return SingleChildScrollView(
                      physics: ScrollPhysics(),
                      child: ListView.builder(
                          itemCount: state.dispatches.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            print("printing history");
                            final displayedDispatch = state.dispatches[index];
                            return buildDispatchCard(displayedDispatch);
                          }),
                    );
                  } else {
                    return SizedBox(width: 20.0);
                  }
                }),
            SizedBox(height: 8.0),
          ],
        ));
  }

  Widget buildDispatchCard(Dispatch dispatch) {
    //matching the dispatch type to the correct icon
    var dispatchIcon = Icon(Icons.group);
    if (dispatch.dispatchType != null) {
      if (dispatch.dispatchType.toLowerCase() == 'road') {
        dispatchIcon = Icon(Icons.local_shipping);
      } else if (dispatch.dispatchType.toLowerCase() == 'courier') {
        dispatchIcon = Icon(Icons.local_post_office);
      } else if (dispatch.dispatchType.toLowerCase() == 'air') {
        dispatchIcon = Icon(Icons.airplanemode_active);
      } else if (dispatch.dispatchType.toLowerCase() == 'rail') {
        dispatchIcon = Icon(MdiIcons.package);
      } else if (dispatch.dispatchType.toLowerCase() == 'sea') {
        dispatchIcon = Icon(Icons.directions_boat);
      } else {
        dispatchIcon = Icon(Icons.group);
      }
    }
    String _dispatchRecord = "";
    if (dispatch.dispatchRecord != null) {
      _dispatchRecord = dispatch.dispatchRecord;
    }
    String _dispatchAmount = "";
    if (dispatch.dispatchAmount != null) {
      _dispatchAmount = dispatch.dispatchAmount.toString();
    }

    return new Container(
      child: InkWell(
        child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      dispatchIcon,
                      SizedBox(
                        width: 60.0,
                      ),
                      Text(
                        _dispatchRecord,
                        style: new TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 3.0, horizontal: 5.0),
                          decoration: new BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(2.0),
                          ),
                          child: Text(_dispatchAmount)),
                      SizedBox(width: 10.0),
                      Icon(Icons.keyboard_arrow_right),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Divider(
                color: Colors.grey,
              )
            ])),
        onTap: () {
          print("history -> details view");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DispatchDetailsView(
                        dispatch: dispatch,
                        dispatchNow: false,
                      )));
        },
      ),
    );
  }
}

//Text(DateFormat('dd/MM/yyyy')
//.format(dispatch.dispatchTime)
//.toString()),
