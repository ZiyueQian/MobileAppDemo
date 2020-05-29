//THIS IS THE PAGE FOR THE HISTORY TAB ON THE HOME SCREEN.
//CURRENTLY USING DUMMY DATA TO SIMULATE INFORMATION FOR WHAT'S BEEN DISPATCHED.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/Dispatch.dart';

class HistoryView extends StatelessWidget {
  final List<Dispatch> dispatchList = [
    Dispatch("2020-05-1111", DateTime.now(), 5, "local_shipping"),
    Dispatch("2020-05-1112", DateTime.now(), 100, "local_post_office"),
    Dispatch("2020-05-1113", DateTime.now(), 2, "transfer_within_a_station"),
    Dispatch("2020-05-1114", DateTime.now(), 20, "flight_takeoff")
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new ListView.builder(
        itemCount: dispatchList.length,
        itemBuilder: (BuildContext context, int index) =>
            buildDispatchCard(context, index),
      ),
    );
  }

  Widget buildDispatchCard(BuildContext context, int index) {
    final dispatch = dispatchList[index];
    return new Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.local_shipping),
                SizedBox(
                  width: 60.0,
                ),
                Text(
                  dispatch.dispatchRecord,
                  style: new TextStyle(fontSize: 20.0),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 3.0, horizontal: 5.0),
                    decoration: new BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                    child: Text(dispatch.dispatchAmount.toString())),
                SizedBox(width: 10.0),
                Icon(Icons.keyboard_arrow_right),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//Text(DateFormat('dd/MM/yyyy')
//.format(dispatch.dispatchTime)
//.toString()),
