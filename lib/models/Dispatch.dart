import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:hive/hive.dart';

part 'Dispatch.g.dart';

@HiveType()
class Dispatch {
  @HiveField(0)
  String dispatchRecord;
  @HiveField(1)
  int dispatchAmount;
  @HiveField(2)
  String dispatchType;
  @HiveField(3)
  DateTime dispatchTime;

  Dispatch(this.dispatchRecord, this.dispatchTime, this.dispatchAmount,
      this.dispatchType);

  Map<String, Icon> types() => {
        "truck": Icon(Icons.local_shipping),
        "logistics": Icon(Icons.local_post_office),
        "hand": Icon(Icons.transfer_within_a_station),
        "container": Icon(MdiIcons.package),
        "other": Icon(Icons.group),
      };
}

//class DispatchDashboard {
//  //record of the last 15 days
//  int totalDispatch;
//  int delivered;
//  int delivering;
//
//  DispatchDashboard(this.totalDispatch, this.delivered, this.delivering);
//}
