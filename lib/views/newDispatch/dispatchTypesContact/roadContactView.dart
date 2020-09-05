//THIS PAGE SHOWS THE CONTACT INFORMATION AFTER CHOOSING TRUCK DELIVERY

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greenwaydispatch/models/Dispatch.dart';
import 'package:greenwaydispatch/views/newDispatch/QRView.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

class RoadContactView extends StatefulWidget {
  final Dispatch dispatch;
  final String area;
  //final DispatchContact dispatchContact;
  RoadContactView({Key key, @required this.dispatch, @required this.area})
      : super(key: key);

  @override
  _RoadContactViewState createState() => _RoadContactViewState();
}

class _RoadContactViewState extends State<RoadContactView> {
  TextEditingController truckInputController = new TextEditingController();
  TextEditingController driverInputController = new TextEditingController();
  TextEditingController contactInputController = new TextEditingController();
  TextEditingController alternativeContactInputController =
      new TextEditingController();
  TextEditingController ewayInputController = new TextEditingController();

  void setValues(String truckNumber, String contactPerson, int contactNumber,
      int alternativeContactNumber) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    shared.setString('truckNumber', truckNumber);
    shared.setString('contactPerson', contactPerson);
    shared.setInt('contactNumber', contactNumber);
    shared.setInt('alternativeContactNumber', alternativeContactNumber);
    print("container values set!");
  }

  String dropDownValue = "Select freight forwarders";
  String _freightForwarders;

  PickedFile _pickedLicenseImage;
  PickedFile _pickedRegistrationImage;
  File _licenseFile;
  File _registrationFile;
  dynamic _pickImageError;
  final ImagePicker _picker = ImagePicker();
  Future<SharedPreferences> shared = SharedPreferences.getInstance();
  String _area = '';

  _choosePicture(BuildContext context, String imageType, String source) async {
    var picture;
    try {
      if (source == "camera") {
        picture = await _picker.getImage(source: ImageSource.camera);
      } else {
        picture = await _picker.getImage(source: ImageSource.gallery);
      }
      this.setState(() {
        if (imageType == "license") {
          _pickedLicenseImage = picture;
          _licenseFile = File(_pickedLicenseImage.path);
        } else {
          _pickedRegistrationImage = picture;
          _registrationFile = File(_pickedRegistrationImage.path);
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

  Widget _licenseSelection() {
    if (_licenseFile != null) {
      return Image.file(_licenseFile, width: 200);
    } else if (_licenseFile != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return Text("Select driver's license image",
          style: TextStyle(fontSize: 16.0));
    }
  }

  Widget _registrationSelection() {
    if (_registrationFile != null) {
      return Image.file(_registrationFile, width: 200);
    } else if (_registrationFile != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return Text("Select registration copy image",
          style: TextStyle(fontSize: 16.0));
    }
  }

  Widget _internationalFields() {
    if (widget.area == 'international') {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        child: TextFormField(
          //              controller: driverInputController,
          decoration: InputDecoration(
              icon: Icon(Icons.location_on),
              labelText: 'Border clearance point',
              border: const OutlineInputBorder()),
//                  onSaved: (val) =>
//                      setState(() => widget.dispatch.truckDriver = val)
        ),
      );
    } else {
      return SizedBox(height: 20.0);
    }
  }

  void dispose() {
    truckInputController.dispose();
    driverInputController.dispose();
    contactInputController.dispose();
    alternativeContactInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New dispatch: ${widget.dispatch.dispatchType} delivery"),
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: SizedBox(
          height: 1000.0,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: truckInputController,
                  decoration: InputDecoration(
                      icon: Icon(Icons.local_shipping),
                      labelText: 'Truck number',
                      //                        helperText: 'e.g. XX12ABC1234',
                      border: const OutlineInputBorder()),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter truck number';
                    }
                  },
//                  onSaved: (val) =>
//                      setState(() => widget.dispatch.truckNumber = val)
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: driverInputController,
                  decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: 'Driver name',
                      //                        helperText: 'e.g. Ankit',
                      border: const OutlineInputBorder()),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter driver name';
                    }
                  },
//                  onSaved: (val) =>
//                      setState(() => widget.dispatch.truckDriver = val)
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: contactInputController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      icon: Icon(Icons.phone),
                      labelText: 'Contact number',
                      border: const OutlineInputBorder()),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter phone number';
                    }
                  },
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
                              value: "Union Roadways",
                              child: Center(child: Text("Union Roadways")),
                            ),
                            DropdownMenuItem<String>(
                              value: "Om Shakti Logistics",
                              child: Center(child: Text("Om Shakti Logistics")),
                            ),
                            DropdownMenuItem<String>(
                              value: "Core Logistics",
                              child: Center(child: Text("Core Logistics")),
                            ),
                            DropdownMenuItem<String>(
                              value: "Allways Best Carrier",
                              child:
                                  Center(child: Text("Allways Best Carrier")),
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
                //               SizedBox(height: 20.0),
//                TextFormField(
//                  controller: driverInputController,
//                  decoration: InputDecoration(
//                      icon: Icon(Icons.person),
//                      labelText: 'Logistics partner name',
//                      border: const OutlineInputBorder()),
//                  validator: (value) {
//                    if (value.isEmpty) {
//                      return 'Please enter driver name';
//                    }
//                  },
//                  onSaved: (val) =>
//                      setState(() => widget.dispatch.truckDriver = val)
//                ),
                SizedBox(height: 20.0),
                Container(
                  margin: EdgeInsets.only(left: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _licenseSelection(),
                      RaisedButton(
                        onPressed: () {
                          _showCameraDialog(context, "license");
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
                      _registrationSelection(),
                      RaisedButton(
                        onPressed: () {
                          _showCameraDialog(context, "registration");
                        },
                        child: Icon(Icons.camera_alt),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  //   focusNode: nodeStoveID,
                  keyboardType: TextInputType.visiblePassword,
                  controller: ewayInputController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.confirmation_number),
                    labelText: 'E-way bill number',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                        icon: Icon(
                          Icons.camera_alt,
                        ),
                        onPressed: scan),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your Stove Id';
                    }
                    return null;
                  },
                  onSaved: (val) => print(val),
                ),
                _internationalFields(),
                TextFormField(
                  //       controller: ,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      icon: Icon(Icons.info),
                      labelText: 'Additional information',
                      border: const OutlineInputBorder()),
//                  onSaved: (val) => setState(
//                      () => widget.dispatch.truckDriverNumber2 = val)
                ),
                SizedBox(height: 20.0),
                Center(
                  child: RaisedButton(
                    color: Colors.green,
                    textColor: Colors.white,
                    child: Text("Continue"),
                    onPressed: () {
                      setValues(
                          truckInputController.text,
                          driverInputController.text,
                          int.parse(contactInputController.text),
                          int.parse(alternativeContactInputController.text));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  QRView(dispatch: widget.dispatch)));
                    },
                  ),
                ),
                //onSaved: (val) => setState(() => _user.truckNumber = val))),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future scan() async {
    try {
      String ewayQRResult = await BarcodeScanner.scan();
      setState(() => ewayInputController.text = ewayQRResult);
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
}
