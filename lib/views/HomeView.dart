//THIS IS THE PAGE FOR THE HOME TAB ON THE HOME SCREEN.
//CURRENTLY USING DUMMY DATA TO SIMULATE INFORMATION FOR WHAT'S BEEN DISPATCHED.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/Dispatch.dart';
import 'dispatchDetailsView.dart';
import 'dashBoardView.dart';
import 'newDispatch/infoView.dart';
import 'chart.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:greenwaydispatch/data/dispatch_bloc/bloc.dart';

class HomeView extends StatefulWidget {
  @override
  HomeView({Key key}) : super(key: key);

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
    Future.delayed(Duration.zero, () async {
      _dispatchBloc = BlocProvider.of<DispatchBloc>(context);
      //_dispatchBloc.fetchDispatches();
      //_dispatchBloc.postDispatches();
      _dispatchBloc.add(LoadDispatches());
    });

    super.initState();

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
            Text('To be dispatched',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green)),
            SizedBox(height: 20.0),
            BlocBuilder(
                cubit: _dispatchBloc,
                builder: (BuildContext context, DispatchState state) {
                  if (state is DispatchesLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is DispatchesLoaded &&
                      state.dispatches.length == 0) {
                    return Text(
                      "Nothing to dispatch!",
                    );
                  } else if (state is DispatchesLoaded &&
                      state.dispatches.length != 0) {
                    return SingleChildScrollView(
                      physics: ScrollPhysics(),
                      child: ListView.builder(
                          itemCount: state.dispatches.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            final displayedDispatch = state.dispatches[index];
                            print("LENGTH:");
                            print(state.dispatches.length);
                            return buildDispatchCard(displayedDispatch);
                          }),
                    );
                  } else {
                    return SizedBox(width: 20.0);
                  }
                }),
            SizedBox(height: 8.0),
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
