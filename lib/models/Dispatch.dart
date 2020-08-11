import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

Dispatch dispatchFromJson(String str) => Dispatch.fromJson(json.decode(str));
String dispatchToJson(Dispatch data) => json.encode(data.toMap());

class Dispatch {
  int id;

  //all will have
  String dispatchRecord;
  int dispatchAmount;
  String dispatchType;
  String dispatchTime;
  String dispatchConfirmation;

  //based on their dispatch type, some fields will be filled and others will be null
  String truckNumber;
  String
      contactPerson; //also used for driver's name for truck and delivery person for hand
  int contactNumber;
  int alternativeContactNumber;
  String docketNumber;
  String recipientPerson;
  int recipientContactNumber;
  String containerNumber;
  String customsClearingPoint;
  String description;
  //invoice number and OC number that the dispatch executive will already have, will have either
  //change drop down to invoice number, order confirmation number, packing list

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

  factory Dispatch.fromJson(Map<String, dynamic> json) {
    return Dispatch(
      json["dispatchRecord"] as String,
      json["dispatchAmount"] as int,
      json["dispatchType"] as String,
      json["dispatchTime"] as String,
      json["dispatchConfirmation"] as String,
      json["truckNumber"] as String,
      json["contactPerson"] as String,
      json["contactNumber"] as int,
      json["alternativeContactNumber"] as int,
      json["docketNumber"] as String,
      json["recipientPerson"] as String,
      json["recipientContactNumber"] as int,
      json["containerNumber"] as String,
      json["customsClearingPoint"] as String,
      json["description"] as String,
    );
  }

  Map<String, dynamic> toJson() => {
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

  Map<String, Icon> types() => {
        "truck": Icon(Icons.local_shipping),
        "logistics": Icon(Icons.local_post_office),
        "hand": Icon(Icons.transfer_within_a_station),
        "container": Icon(MdiIcons.package),
        "other": Icon(Icons.group),
      };
}
