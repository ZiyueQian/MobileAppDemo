//THIS IS THE PAGE FOR THE HISTORY TAB ON THE HOME SCREEN.
//CURRENTLY USING DUMMY DATA TO SIMULATE INFORMATION FOR WHAT'S BEEN DISPATCHED.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greenwaydispatch/views/dispatchDetailsView.dart';
import 'package:intl/intl.dart';
import '../models/Dispatch.dart';
import 'dispatchDetailsView.dart';

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
        margin: EdgeInsets.all(16.0),
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(15.0),
          children: <Widget>[
            Text('2020-05-19',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green)),
            SizedBox(height: 8.0),
            Container(
              child: new ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: dispatchList.length,
                itemBuilder: (BuildContext context, int index) =>
                    buildDispatchCard(context, index),
              ),
            ),
            SizedBox(height: 8.0),
          ],
        ));
  }

  Widget buildDispatchCard(BuildContext context, int index) {
    final dispatch = dispatchList[index];
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
                          padding: EdgeInsets.symmetric(
                              vertical: 3.0, horizontal: 5.0),
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
              SizedBox(height: 8.0),
              Divider(
                color: Colors.grey,
              )
            ])),
        onTap: () {
//          Navigator.push(
//              context,
//              MaterialPageRoute(
//                  builder: (context) => DispatchDetailsView(
//                        dispatch: dispatch,
//                      ))
//          );
        },
      ),
    );
  }
}

//Text(DateFormat('dd/MM/yyyy')
//.format(dispatch.dispatchTime)
//.toString()),
