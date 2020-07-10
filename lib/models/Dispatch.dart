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
  @HiveField(4)
  String dispatchConfirmation;
//  @HiveField(5)
//  String truckNumber;
//  @HiveField(6)
//  String
//      contactPerson; //also used for driver's name for truck and delivery person for hand
//  @HiveField(7)
//  String contactNumber;
//  @HiveField(8)
//  String alternativeContactNumber;
//  @HiveField(9)
//  String docketNumber;
//  @HiveField(10)
//  String recipientPerson;
//  @HiveField(11)
//  String recipientContactNumber;
//  @HiveField(12)
//  String containerNumber;
//  @HiveField(13)
//  String customsClearingPoint;
//  @HiveField(14)
//  String description;

  Dispatch(
    this.dispatchRecord,
    this.dispatchTime,
    this.dispatchAmount,
    this.dispatchType,
    this.dispatchConfirmation,
//    this.truckNumber,
//    this.alternativeContactNumber,
//    this.contactNumber,
//    this.contactPerson,
//    this.containerNumber,
//    this.customsClearingPoint,
//    this.description,
//    this.docketNumber,
//    this.recipientContactNumber,
//    this.recipientPerson,
  );

  Map<String, Icon> types() => {
        "truck": Icon(Icons.local_shipping),
        "logistics": Icon(Icons.local_post_office),
        "hand": Icon(Icons.transfer_within_a_station),
        "container": Icon(MdiIcons.package),
        "other": Icon(Icons.group),
      };
}
