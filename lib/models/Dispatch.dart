import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dispatch {
  String dispatchRecord;
  DateTime dispatchTime;
  int dispatchAmount;
  String dispatchType;

  Dispatch(this.dispatchRecord, this.dispatchTime, this.dispatchAmount,
      this.dispatchType);

  Map<String, Icon> types() => {
        "truck": Icon(Icons.local_shipping),
        "logistics": Icon(Icons.local_post_office),
        "hand": Icon(Icons.transfer_within_a_station),
        "container": Icon(Icons.flight_takeoff),
        "other": Icon(Icons.group),
      };
}
