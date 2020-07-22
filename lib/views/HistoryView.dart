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

class HistoryView extends StatefulWidget {
  @override
  _HistoryViewState createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
//  final historyBox = Hive.box('history');

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(16.0),
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(15.0),
          children: <Widget>[
            Text('History of dispatches:',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green)),
            SizedBox(height: 8.0),
//            WatchBoxBuilder(
//                box: Hive.box('history'),
//                builder: (context, dispatchBox) {
//                  if (dispatchBox.isEmpty) {
//                    return Text("Nothing to dispatch!");
//                  } else {
//                    return ListView.builder(
//                      scrollDirection: Axis.vertical,
//                      shrinkWrap: true,
//                      itemCount: historyBox.length,
//                      itemBuilder: (BuildContext context, int index) =>
//                          buildDispatchCard(context, index),
//                    );
//                  }
//                }),
            SizedBox(height: 8.0),
          ],
        ));
  }

//  Widget buildDispatchCard(BuildContext context, int index) {
//    //final dispatch = historyBox.getAt(index) as Dispatch;
//
//    //matching the dispatch type to the correct icon
//    var dispatchIcon = Icon(Icons.group);
//    if (dispatch.dispatchType == 'truck') {
//      dispatchIcon = Icon(Icons.local_shipping);
//    } else if (dispatch.dispatchType == 'logistics') {
//      dispatchIcon = Icon(Icons.local_post_office);
//    } else if (dispatch.dispatchType == 'hand') {
//      dispatchIcon = Icon(Icons.transfer_within_a_station);
//    } else if (dispatch.dispatchType == 'container') {
//      dispatchIcon = Icon(MdiIcons.package);
//    }
//
//    return new Container(
//      child: InkWell(
//        child: Padding(
//            padding: const EdgeInsets.only(top: 8.0),
//            child: Column(children: <Widget>[
//              Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: <Widget>[
//                  Row(
//                    children: <Widget>[
//                      dispatchIcon,
//                      SizedBox(
//                        width: 60.0,
//                      ),
//                      Text(
//                        dispatch.dispatchRecord,
//                        style: new TextStyle(fontSize: 20.0),
//                      ),
//                    ],
//                  ),
//                  Row(
//                    children: <Widget>[
//                      Container(
//                          padding: EdgeInsets.symmetric(
//                              vertical: 3.0, horizontal: 5.0),
//                          decoration: new BoxDecoration(
//                            color: Colors.grey[300],
//                            borderRadius: BorderRadius.circular(2.0),
//                          ),
//                          child: Text(dispatch.dispatchAmount.toString())),
//                      SizedBox(width: 10.0),
//                      Icon(Icons.keyboard_arrow_right),
//                    ],
//                  ),
//                ],
//              ),
//              SizedBox(height: 8.0),
//              Divider(
//                color: Colors.grey,
//              )
//            ])),
//        onTap: () {
//          Navigator.push(
//              context,
//              MaterialPageRoute(
//                  builder: (context) => HistoryDetailsView(
//                        index: index,
//                        dispatch: dispatch,
//                      )));
//        },
//      ),
//    );
//  }
}

//Text(DateFormat('dd/MM/yyyy')
//.format(dispatch.dispatchTime)
//.toString()),
