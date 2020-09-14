import 'package:flutter/foundation.dart';

class DispatchInsert {
  String dispatchRecord;
  int dispatchAmount;
  String dispatchType;
  String dispatchTime;
  String dispatchConfirmation;
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

  DispatchInsert({
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
  });

  Map<String, dynamic> toJson() {
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
}
