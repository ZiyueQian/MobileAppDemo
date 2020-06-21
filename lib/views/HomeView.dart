//THIS IS THE PAGE FOR THE HISTORY TAB ON THE HOME SCREEN.
//CURRENTLY USING DUMMY DATA TO SIMULATE INFORMATION FOR WHAT'S BEEN DISPATCHED.

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/Dispatch.dart';
import 'dispatchDetailsView.dart';
import 'dashBoardView.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with AutomaticKeepAliveClientMixin<HomeView> {
  final List<Dispatch> dispatchList = [
    Dispatch("2020-05-1111", DateTime.now(), 5, "local_shipping"),
    Dispatch("2020-05-1112", DateTime.now(), 100, "local_post_office"),
    Dispatch("2020-05-1113", DateTime.now(), 2, "transfer_within_a_station"),
    Dispatch("2020-05-1114", DateTime.now(), 20, "flight_takeoff")
  ];

  final dispatchDashboard = [150, 100, 50];

  var showData;
  Future _loadData;
  File jsonFile;
  Directory dir;
  String fileName = "myFile.json";
  bool fileExists = false;
  Map<String, dynamic> fileContent;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    getApplicationDocumentsDirectory().then((Directory directory) {
      dir = directory;
      jsonFile = new File(dir.path + "/" + fileName);
      fileExists = jsonFile.existsSync();
      if (fileExists)
        this.setState(
            () => fileContent = json.decode(jsonFile.readAsStringSync()));
    });
    //Future loadData =  // only create the future once.
    //_loadData = loadData;
    print("initialized home!");
  }

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
//            FutureBuilder(
//              future: _loadData,
//              builder: (context, snapshot) {
//                showData = json.decode(snapshot.data.toString());
//                return showData != null
//                    ? ListView.builder(
//                  scrollDirection: Axis.vertical,
//                  shrinkWrap: true,
//                  itemBuilder: (BuildContext context, int index) =>
//                      buildDispatchCard(context, index),
//                  itemCount: showData.length,
//                )
//                    : Container(
//                  child: Text("Nothing to dispatch!",
//                      style: new TextStyle(fontSize: 20.0)),
//                );
//              },
//            ),
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) =>
                  buildDispatchCard(context, index),
              itemCount: 3,
            ),
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
    String indexString = index.toString();
    final dispatch = fileContent[indexString];

    //matching the dispatch type to the correct icon
    var dispatchIcon = Icon(Icons.group);
    if (dispatch['dispatchType'] == 'truck') {
      dispatchIcon = Icon(Icons.local_shipping);
    } else if (dispatch['dispatchType'] == 'logistics') {
      dispatchIcon = Icon(Icons.local_post_office);
    } else if (dispatch['dispatchType'] == 'hand') {
      dispatchIcon = Icon(Icons.transfer_within_a_station);
    } else if (dispatch['dispatchType'] == 'container') {
      dispatchIcon = Icon(Icons.directions_boat);
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
                        dispatch['dispatchRecord'],
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
                          child: Text(dispatch['dispatchAmount'])),
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

class Chart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChartState();
  }
}

class _ChartState extends State<Chart> {
  List<PieChartSectionData> _sections = List<PieChartSectionData>();

  @override
  void initState() {
    super.initState();
    PieChartSectionData _dispatching = PieChartSectionData(
        color: Colors.lightGreenAccent,
        value: 50,
        title: 'In delivery: 50',
        titleStyle: TextStyle(color: Colors.black),
        radius: 50);
    PieChartSectionData _delivered = PieChartSectionData(
        color: Colors.yellow,
        value: 100,
        title: 'Delivered: 100',
        titleStyle: TextStyle(color: Colors.black),
        radius: 50);
    _sections = [_dispatching, _delivered];
  }

  Widget build(BuildContext context) {
    return Container(
      child: AspectRatio(
        aspectRatio: 1,
        child: FlChart(
            chart: PieChart(PieChartData(
          sections: _sections,
          borderData: FlBorderData(show: false),
          centerSpaceRadius: 40,
          sectionsSpace: 0,
        ))),
      ),
    );
  }
}

//Text(DateFormat('dd/MM/yyyy')
//.format(dispatch.dispatchTime)
//.toString()),
