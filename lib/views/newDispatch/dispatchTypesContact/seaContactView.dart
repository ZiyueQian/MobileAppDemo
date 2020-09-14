//THIS PAGE SHOWS THE CONTACT INFORMATION AFTER CHOOSING CONTAINER DELIVERY

import 'package:flutter/material.dart';
import 'package:greenwaydispatch/models/Dispatch.dart';
import 'package:greenwaydispatch/views/newDispatch/QRView.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:greenwaydispatch/views/newDispatch/functions/scan.dart';

class ContainerContactView extends StatefulWidget {
  final Dispatch dispatch;
  //final DispatchContact dispatchContact;
  ContainerContactView({Key key, @required this.dispatch}) : super(key: key);

  @override
  _ContainerContactViewState createState() => _ContainerContactViewState();
}

class _ContainerContactViewState extends State<ContainerContactView> {
  var _formKey = GlobalKey<FormState>();
  TextEditingController containerNumberController = new TextEditingController();
  TextEditingController portOfClearanceController = new TextEditingController();
  TextEditingController portOfLoadingController = new TextEditingController();
  TextEditingController portOfDischargeController = new TextEditingController();
  TextEditingController shippingLineController = new TextEditingController();
  TextEditingController vesselNameController = new TextEditingController();
  TextEditingController ewayBillController = new TextEditingController();
  TextEditingController additionalInfoController = new TextEditingController();
  String dropDownValue = "Select freight forwarders";
  String _freightForwarders;

  PickedFile _pickedshippingBillImage;
  PickedFile _pickedbillLadingImage;
  File _shippingBillFile;
  File _billLadingFile;
  dynamic _pickImageError;
  final ImagePicker _picker = ImagePicker();

  void setValues(
      String containerNumber,
      String portOfClearance,
      String portOfLoading,
      String portOfDischarge,
      String shippingLine,
      String vesselName,
      String ewayBillNo,
      String additional) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    shared.setString('containerNumber', containerNumber);
    shared.setString('portOfClearance', portOfClearance);
    shared.setString('portOfLoading', portOfLoading);
    shared.setString('portOfDischarge', portOfDischarge);
    shared.setString('shippingLine', shippingLine);
    shared.setString('vesselName', vesselName);
    shared.setString('ewayBillNo', ewayBillNo);
    shared.setString('additional', additional);

    print('set sea values');
  }

  _choosePicture(BuildContext context, String imageType, String source) async {
    var picture;
    try {
      if (source == "camera") {
        picture = await _picker.getImage(source: ImageSource.camera);
      } else {
        picture = await _picker.getImage(source: ImageSource.gallery);
      }
      this.setState(() {
        if (imageType == "shipping") {
          _pickedshippingBillImage = picture;
          _shippingBillFile = File(_pickedshippingBillImage.path);
        } else {
          _pickedbillLadingImage = picture;
          _billLadingFile = File(_pickedbillLadingImage.path);
        }
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
    Navigator.of(context).pop();
  }

  Future<void> _showCameraDialog(BuildContext context, String imageType) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Gallery"),
                    onTap: () {
                      _choosePicture(context, imageType, "gallery");
                    },
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                    child: Text("Camera"),
                    onTap: () {
                      _choosePicture(context, imageType, "camera");
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget _shippingBillSelection() {
    if (_shippingBillFile != null) {
      return Image.file(_shippingBillFile, width: 200);
    } else if (_shippingBillFile != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return Text("Select shipping bill image",
          style: TextStyle(fontSize: 16.0));
    }
  }

  Widget _billLadingSelection() {
    if (_billLadingFile != null) {
      return Image.file(_billLadingFile, width: 200);
    } else if (_billLadingFile != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return Text("Select bill of lading image",
          style: TextStyle(fontSize: 16.0));
    }
  }

  void dispose() {
    containerNumberController.dispose();
    portOfClearanceController.dispose();
    portOfLoadingController.dispose();
    portOfDischargeController.dispose();
    shippingLineController.dispose();
    vesselNameController.dispose();
    ewayBillController.dispose();
    additionalInfoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New dispatch: sea delivery"),
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: SizedBox(
          height: 1000.0,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    controller: containerNumberController,
                    decoration: InputDecoration(
                        icon: Icon(Icons.directions_boat),
                        labelText: 'Container number',
                        border: const OutlineInputBorder()),
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Please enter the container number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: portOfClearanceController,
                    decoration: InputDecoration(
                        icon: Icon(Icons.location_on),
                        labelText: 'Port of clearance',
                        border: const OutlineInputBorder()),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: portOfLoadingController,
                    decoration: InputDecoration(
                        icon: Icon(Icons.location_on),
                        labelText: 'Port of loading',
                        border: const OutlineInputBorder()),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: portOfDischargeController,
                    decoration: InputDecoration(
                        icon: Icon(Icons.location_on),
                        labelText: 'Port of discharge',
                        border: const OutlineInputBorder()),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: shippingLineController,
                    decoration: InputDecoration(
                        icon: Icon(Icons.business),
                        labelText: 'Shipping line',
                        border: const OutlineInputBorder()),
                  ),
                  SizedBox(height: 20.0),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: <
                      Widget>[
                    Icon(
                      Icons.storage,
                      color: Colors.black.withOpacity(0.5),
                    ),
                    SizedBox(
                      width: 16.0,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        border: Border.all(
                            color: Colors.black.withOpacity(0.5),
                            style: BorderStyle.solid,
                            width: 0.80),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                            items: [
                              DropdownMenuItem<String>(
                                value: "Star Logistics",
                                child: Center(child: Text("Star Logistics")),
                              ),
                              DropdownMenuItem<String>(
                                value: "Aaditya Logistics",
                                child: Center(child: Text("Aaditya Logistics")),
                              ),
                              DropdownMenuItem<String>(
                                value: "Dhanlabh Logistics",
                                child:
                                    Center(child: Text("Dhanlabh Logistics")),
                              )
                            ],
                            onChanged: (_value) => {
                                  print(_value.toString()),
                                  setState(() {
                                    _freightForwarders = _value;
                                    dropDownValue = _value;
                                  })
                                },
                            hint: Text(
                              "$dropDownValue",
                              style: TextStyle(
                                color:
                                    dropDownValue == "Select freight forwarders"
                                        ? Colors.grey[600]
                                        : Colors.black,
                              ),
                            )),
                      ),
                    ),
                  ]),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: vesselNameController,
                    decoration: InputDecoration(
                        icon: Icon(Icons.directions_boat),
                        labelText: 'Vessel name',
                        border: const OutlineInputBorder()),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    margin: EdgeInsets.only(left: 40.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        _shippingBillSelection(),
                        RaisedButton(
                          onPressed: () {
                            _showCameraDialog(context, "shipping");
                          },
                          child: Icon(Icons.camera_alt),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    margin: EdgeInsets.only(left: 40.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        _billLadingSelection(),
                        RaisedButton(
                          onPressed: () {
                            _showCameraDialog(context, "lading");
                          },
                          child: Icon(Icons.camera_alt),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: ewayBillController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.confirmation_number),
                      labelText: 'E-way bill number',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.camera_alt,
                        ),
                        onPressed: () {
                          scanEwayBill(context).then((val) => setState(() {
                                ewayBillController.text = val;
                              }));
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: additionalInfoController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        icon: Icon(Icons.info),
                        labelText: 'Additional information',
                        border: const OutlineInputBorder()),
                  ),
                  SizedBox(height: 20.0),
                  Center(
                    child: RaisedButton(
                      color: Colors.green,
                      textColor: Colors.white,
                      child: Text("Continue"),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
//                          setValues(
//                              containerNumberController.text,
//                              portOfClearanceController.text,
//                              portOfLoadingController.text,
//                              portOfDischargeController.text,
//                              shippingLineController.text,
//                              vesselNameController.text,
//                              ewayBillController.text,
//                              additionalInfoController.text);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      QRView(dispatch: widget.dispatch)));
                        }
                      },
                    ),
                  ),
                  //onSaved: (val) => setState(() => _user.truckNumber = val))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
