//THIS IS THE PAGE FOR THE HISTORY TAB ON THE HOME SCREEN.
//CURRENTLY USING DUMMY DATA TO SIMULATE INFORMATION FOR WHAT'S BEEN DISPATCHED.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/Dispatch.dart';
import 'dispatchDetailsView.dart';
import 'dashBoardView.dart';
import '../views/newDispatch/infoView.dart';
import 'chart.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:greenwaydispatch/dispatch_bloc/bloc.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with AutomaticKeepAliveClientMixin<HomeView> {
  final dispatchDashboard = [150, 100, 50];

  DispatchBloc _dispatchBloc;

  @override
  bool get wantKeepAlive => false;

  @override
  void initState() {
    super.initState();
    _dispatchBloc = BlocProvider.of<DispatchBloc>(context);
    _dispatchBloc.dispatch(LoadDispatches());
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
            BlocBuilder(
                bloc: _dispatchBloc,
                builder: (BuildContext context, DispatchState state) {
                  if (state is DispatchesLoading) {
                    print("dispatches loading");
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is DispatchesLoaded) {
                    print("building listView");
                    return SingleChildScrollView(
                      physics: ScrollPhysics(),
                      child: ListView.builder(
                          itemCount: state.dispatches.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            print("printing dispatches");
                            final displayedDispatch = state.dispatches[index];
                            return buildDispatchCard(displayedDispatch);
                          }),
                    );
                  }
                }),
//            WatchBoxBuilder(
//                box: Hive.box('dispatch'),
//                builder: (context, dispatchBox) {
//                  if (dispatchBox.isEmpty) {
//                    return Text("Nothing to dispatch!");
//                  } else {
//                    return ListView.builder(
//                      scrollDirection: Axis.vertical,
//                      shrinkWrap: true,
//                      itemCount: dispatchBox.length,
//                      itemBuilder: (BuildContext context, int index) =>
//                          buildDispatchCard(context, index),
//                    );
//                  }
//                }),
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

  Widget buildDispatchCard(Dispatch dispatch) {
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
    } else {
      dispatchIcon = Icon(Icons.group);
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
                        dispatch: dispatch,
                        dispatchNow: true,
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
