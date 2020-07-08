//THIS IS THE PAGE FOR THE HISTORY TAB ON THE HOME SCREEN.
//CURRENTLY USING DUMMY DATA TO SIMULATE INFORMATION FOR WHAT'S BEEN DISPATCHED.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import '../models/Dispatch.dart';
import 'dispatchDetailsView.dart';
import 'dashBoardView.dart';
import '../views/newDispatch/infoView.dart';
import 'chart.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:hive/hive.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with AutomaticKeepAliveClientMixin<HomeView> {
  final dispatchDashboard = [150, 100, 50];

  @override
  bool get wantKeepAlive => false;

  @override
  void initState() {
    super.initState();
    print("initialized home!");
  }

  final dispatchBox = Hive.box('dispatch');

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
        margin: EdgeInsets.all(16.0),
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(15.0),
          children: <Widget>[
            Text('Dispatch now',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green)),
            SizedBox(height: 8.0),
            WatchBoxBuilder(
                box: Hive.box('dispatch'),
                builder: (context, dispatchBox) {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: dispatchBox.length,
                    itemBuilder: (BuildContext context, int index) =>
                        buildDispatchCard(context, index),
                  );
                }),
            SizedBox(height: 8.0),
            Text('Last 15 days',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green)),
            SizedBox(height: 8.0),
            Container(child: Chart()),
            Container(
              child: new ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: dispatchDashboard.length,
                itemBuilder: (BuildContext context, int index) =>
                    buildDashboard(context, index),
              ),
            ),
          ],
        ));
  }

  Widget buildDispatchCard(BuildContext context, int index) {
    final dispatch = dispatchBox.getAt(index) as Dispatch;

    //matching the dispatch type to the correct icon
    var dispatchIcon = Icon(Icons.group);
    if (dispatch.dispatchType == 'truck') {
      dispatchIcon = Icon(Icons.local_shipping);
    } else if (dispatch.dispatchType == 'logistics') {
      dispatchIcon = Icon(Icons.local_post_office);
    } else if (dispatch.dispatchType == 'hand') {
      dispatchIcon = Icon(Icons.transfer_within_a_station);
    } else if (dispatch.dispatchType == 'container') {
      dispatchIcon = Icon(MdiIcons.package);
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
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DispatchDetailsView(
                        data: dispatch,
                      )));
        },
      ),
    );
  }

  Widget buildDashboard(BuildContext context, int index) {
    final dashboardText = ['Total dispatched', 'Delivered', 'In delivery'];
    final dispatchAmount = dispatchDashboard[index];
    return new Container(
      child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      dashboardText[index],
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
                        child: Text(dispatchAmount.toString())),
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
    );
  }
}
