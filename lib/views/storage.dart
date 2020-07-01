////THIS IS THE PAGE FOR THE HISTORY TAB ON THE HOME SCREEN.
////CURRENTLY USING DUMMY DATA TO SIMULATE INFORMATION FOR WHAT'S BEEN DISPATCHED.
//
//import 'package:fl_chart/fl_chart.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
//import '../models/Dispatch.dart';
//import 'dispatchDetailsView.dart';
//import 'dashBoardView.dart';
//import 'dart:convert';
//
//class HomeView extends StatelessWidget {
//  final List<Dispatch> dispatchList = [
//    Dispatch("2020-05-1111", DateTime.now(), 5, "local_shipping"),
//    Dispatch("2020-05-1112", DateTime.now(), 100, "local_post_office"),
//    Dispatch("2020-05-1113", DateTime.now(), 2, "transfer_within_a_station"),
//    Dispatch("2020-05-1114", DateTime.now(), 20, "flight_takeoff")
//  ];
//
//  final dispatchDashboard = [150, 100, 50];
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//        margin: EdgeInsets.all(16.0),
//        child: ListView(
//          shrinkWrap: true,
//          padding: EdgeInsets.all(15.0),
//          children: <Widget>[
//            Text('Dispatch now',
//                style: TextStyle(
//                    fontSize: 20.0,
//                    fontWeight: FontWeight.bold,
//                    color: Colors.green)),
//            SizedBox(height: 8.0),
//            Container(
//              child: new ListView.builder(
//                scrollDirection: Axis.vertical,
//                shrinkWrap: true,
//                itemCount: dispatchList.length,
//                itemBuilder: (BuildContext context, int index) =>
//                    buildDispatchCard(context, index),
//              ),
//            ),
//            SizedBox(height: 8.0),
//            Text('Last 15 days',
//                style: TextStyle(
//                    fontSize: 20.0,
//                    fontWeight: FontWeight.bold,
//                    color: Colors.green)),
//            SizedBox(height: 8.0),
//            Container(child: Chart()),
//            Container(
//              child: new ListView.builder(
//                scrollDirection: Axis.vertical,
//                shrinkWrap: true,
//                itemCount: dispatchDashboard.length,
//                itemBuilder: (BuildContext context, int index) =>
//                    buildDashboard(context, index),
//              ),
//            ),
//          ],
//        ));
//  }
//
//  Widget buildDispatchCard(BuildContext context, int index) {
//    final dispatch = dispatchList[index];
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
//                      Icon(Icons.local_shipping),
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
//                  builder: (context) => DispatchDetailsView(
//                    dispatch: dispatch,
//                  )));
//        },
//      ),
//    );
//  }
//
//  Widget buildDashboard(BuildContext context, int index) {
//    final dashboardText = ['Total dispatched', 'Delivered', 'In delivery'];
//    final dispatchAmount = dispatchDashboard[index];
//    return new Container(
//      child: Padding(
//          padding: const EdgeInsets.only(top: 8.0),
//          child: Column(children: <Widget>[
//            Row(
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//              children: <Widget>[
//                Row(
//                  children: <Widget>[
//                    Text(
//                      dashboardText[index],
//                      style: new TextStyle(fontSize: 20.0),
//                    ),
//                  ],
//                ),
//                Row(
//                  children: <Widget>[
//                    Container(
//                        padding: EdgeInsets.symmetric(
//                            vertical: 3.0, horizontal: 5.0),
//                        decoration: new BoxDecoration(
//                          color: Colors.grey[300],
//                          borderRadius: BorderRadius.circular(2.0),
//                        ),
//                        child: Text(dispatchAmount.toString())),
//                    SizedBox(width: 10.0),
//                    Icon(Icons.keyboard_arrow_right),
//                  ],
//                ),
//              ],
//            ),
//            SizedBox(height: 8.0),
//            Divider(
//              color: Colors.grey,
//            )
//          ])),
//    );
//  }
//}
//
//class Chart extends StatefulWidget {
//  @override
//  State<StatefulWidget> createState() {
//    return _ChartState();
//  }
//}
//
//class _ChartState extends State<Chart> {
//  List<PieChartSectionData> _sections = List<PieChartSectionData>();
//
//  @override
//  void initState() {
//    super.initState();
//    PieChartSectionData _dispatching = PieChartSectionData(
//        color: Colors.lightGreenAccent,
//        value: 50,
//        title: 'In delivery: 50',
//        titleStyle: TextStyle(color: Colors.black),
//        radius: 50);
//    PieChartSectionData _delivered = PieChartSectionData(
//        color: Colors.yellow,
//        value: 100,
//        title: 'Delivered: 100',
//        titleStyle: TextStyle(color: Colors.black),
//        radius: 50);
//    _sections = [_dispatching, _delivered];
//  }
//
//  Widget build(BuildContext context) {
//    return Container(
//      child: AspectRatio(
//        aspectRatio: 1,
//        child: FlChart(
//            chart: PieChart(PieChartData(
//              sections: _sections,
//              borderData: FlBorderData(show: false),
//              centerSpaceRadius: 40,
//              sectionsSpace: 0,
//            ))),
//      ),
//    );
//  }
//}
//
////Text(DateFormat('dd/MM/yyyy')
////.format(dispatch.dispatchTime)
////.toString()),
