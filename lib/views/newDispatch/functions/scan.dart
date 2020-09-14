import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

Future<String> scanEwayBill(BuildContext context) async {
  try {
    String ewayQRResult = await BarcodeScanner.scan();
    return ewayQRResult;
    // setState(() => ewayInputController.text = ewayQRResult);
  } on PlatformException catch (e) {
    if (e.code == BarcodeScanner.CameraAccessDenied) {
      Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('The user did not grant the camera permission!')));
    } else {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Unknown error: $e')));
    }
  }
}
