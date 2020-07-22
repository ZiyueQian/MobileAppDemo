import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:meta/meta.dart';

class Dispatch {
  int id;

  String dispatchRecord;
  int dispatchAmount;
  String dispatchType;
  DateTime dispatchTime;
  String dispatchConfirmation;
  String truckNumber;
  String
      contactPerson; //also used for driver's name for truck and delivery person for hand
  int contactNumber;
  String alternativeContactNumber;
  String docketNumber;
  String recipientPerson;
  String recipientContactNumber;
  String containerNumber;
  String customsClearingPoint;
  String description;
//  @HiveField(0)
//  String dispatchRecord;
//  @HiveField(1)
//  int dispatchAmount;
//  @HiveField(2)
//  String dispatchType;
//  @HiveField(3)
//  DateTime dispatchTime;
//  @HiveField(4)
//  String dispatchConfirmation;
//  @HiveField(5)
//  String truckNumber;
//  @HiveField(6)
//  String
//      contactPerson; //also used for driver's name for truck and delivery person for hand
//  @HiveField(7)
//  int contactNumber;
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
    @required this.dispatchRecord,
    @required this.dispatchAmount,
    @required this.dispatchType,
    this.dispatchTime,
    this.dispatchConfirmation,
    this.truckNumber,
    this.contactPerson,
    this.contactNumber,
    this.alternativeContactNumber,
    this.docketNumber,
    this.recipientPerson,
    this.recipientContactNumber,
    this.containerNumber,
    this.customsClearingPoint,
    this.description,
  );

  Map<String, dynamic> toMap() {
    return {
      'dispatchRecord': dispatchRecord,
      'dispatchAmount': dispatchAmount,
      'dispatchType': dispatchType,
      'dispatchTime': dispatchTime,
      'dispatchConfirmation': dispatchConfirmation,
      'truckNumber': truckNumber,
      'contactPerson': contactPerson,
      'contactNumber': contactNumber,
      'alternativeContactNumber': alternativeContactNumber,
      'docketNumber': docketNumber,
      'recipientPerson': recipientPerson,
      'recipientContactNumber': recipientContactNumber,
      'containerNumber': containerNumber,
      'customsClearingPoint': customsClearingPoint,
      'description': description,
    };
  }

  static Dispatch fromMap(Map<String, dynamic> map) {
    return Dispatch(
        map['dispatchRecord'],
        map['dispatchAmount'],
        map['dispatchType'],
        map['dispatchTime'],
        map['dispatchConfirmation'],
        map['truckNumber'],
        map['contactPerson'],
        map['contactNumber'],
        map['alternativeContactNumber'],
        map['docketNumber'],
        map['recipientPerson'],
        map['recipientContactNumber'],
        map['containerNumber'],
        map['customsClearingPoint'],
        map['description']);
  }

  Map<String, Icon> types() => {
        "truck": Icon(Icons.local_shipping),
        "logistics": Icon(Icons.local_post_office),
        "hand": Icon(Icons.transfer_within_a_station),
        "container": Icon(MdiIcons.package),
        "other": Icon(Icons.group),
      };
}
