//THIS PAGE SHOWS THE CONTACT INFORMATION AFTER CHOOSING 'OTHER' DELIVERY METHOD

import 'package:flutter/material.dart';
import 'package:greenwaydispatch/models/Dispatch.dart';
import 'package:greenwaydispatch/views/newDispatch/QRView.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:greenwaydispatch/views/newDispatch/functions/scan.dart';

class OtherContactView extends StatefulWidget {
  final Dispatch dispatch;
  //final DispatchContact dispatchContact;
  OtherContactView({Key key, @required this.dispatch}) : super(key: key);

  @override
  _OtherContactViewState createState() => _OtherContactViewState();
}

class _OtherContactViewState extends State<OtherContactView> {
  var _formKey = GlobalKey<FormState>();
  TextEditingController trackingNumberController = new TextEditingController();
  TextEditingController contactNameController = new TextEditingController();
  TextEditingController contactNumberController = new TextEditingController();
  TextEditingController ewayBillController = new TextEditingController();
  String dropDownValue = "Select delivery type";
  String _deliveryType;

  void setValues(String trackingNumber, String deliveryType, String contactName,
      int contactNumber, String ewayBillNo) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    shared.setString('trackingNumber', trackingNumber);
    shared.setString('deliveryType', deliveryType);
    shared.setString('contactName', contactName);
    shared.setInt('contactNumber', contactNumber);
    shared.setString('ewayBillNo', ewayBillNo);
  }

  PickedFile _pickedLicenseImage;
  PickedFile _pickedRegistrationImage;
  File _licenseFile;
  File _registrationFile;
  dynamic _pickImageError;
  final ImagePicker _picker = ImagePicker();

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

  void dispose() {
    trackingNumberController.dispose();
    contactNameController.dispose();
    contactNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New dispatch: other delivery"),
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: SizedBox(
          height: 1500.0,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    controller: trackingNumberController,
                    decoration: InputDecoration(
                        icon: Icon(Icons.confirmation_number),
                        labelText: 'Tracking number',
                        border: const OutlineInputBorder()),
                  ),
                  SizedBox(height: 20.0),
                  Row(children: <Widget>[
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
                                value: "Hand delivery",
                                child: Center(child: Text("Hand delivery")),
                              ),
                              DropdownMenuItem<String>(
                                value: "Own car delivery",
                                child: Center(child: Text("Own car delivery")),
                              ),
                              DropdownMenuItem<String>(
                                value: "Local vendor",
                                child: Center(child: Text("Local vendor")),
                              )
                            ],
                            onChanged: (_value) => {
                                  print(_value.toString()),
                                  setState(() {
                                    _deliveryType = _value;
                                    dropDownValue = _value;
                                  })
                                },
                            hint: Text(
                              "$dropDownValue",
                              style: TextStyle(
                                color: dropDownValue == "Select delivery type"
                                    ? Colors.grey[600]
                                    : Colors.black,
                              ),
                            )),
                      ),
                    ),
                  ]),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: contactNameController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        icon: Icon(Icons.person),
                        labelText: "Person's name",
                        border: const OutlineInputBorder()),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: contactNumberController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        icon: Icon(Icons.phone),
                        labelText: 'Contact number',
                        border: const OutlineInputBorder()),
                  ),
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
                    onSaved: (val) => print(val),
                  ),
                  SizedBox(height: 40.0),
                  FlatButton(
                    child: Container(
                      height: 50,
                      child: Center(
                        child: Text(
                          "Continue",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.green),
                    ),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        int _contactNumber;
                        if (contactNumberController.text != "") {
                          _contactNumber =
                              int.parse(contactNumberController.text);
                          print("not null");
                        }
                        setValues(
                            trackingNumberController.text,
                            _deliveryType,
                            contactNameController.text,
                            _contactNumber,
                            ewayBillController.text);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    QRView(dispatch: widget.dispatch)));
                      }
                    },
                  ),
                  SizedBox(
                    height: 40.0,
                  )
//                  Center(
//                    child: RaisedButton(
//                      color: Colors.green,
//                      textColor: Colors.white,
//                      child: Text("Continue"),
//                      onPressed: () {
//                        if (_formKey.currentState.validate()) {
//                          int _contactNumber;
//                          if (contactNumberController.text != "") {
//                            _contactNumber =
//                                int.parse(contactNumberController.text);
//                            print("not null");
//                          }
//                          setValues(
//                              trackingNumberController.text,
//                              _deliveryType,
//                              contactNameController.text,
//                              _contactNumber,
//                              ewayBillController.text);
//                          Navigator.push(
//                              context,
//                              MaterialPageRoute(
//                                  builder: (context) =>
//                                      QRView(dispatch: widget.dispatch)));
//                        }
//                      },
//                    ),
//                  ),
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
