//THIS PAGE SHOWS THE CONTACT INFORMATION AFTER CHOOSING 'OTHER' DELIVERY METHOD

import 'package:flutter/material.dart';
import 'package:greenwaydispatch/models/Dispatch.dart';
import 'package:greenwaydispatch/views/newDispatch/QRView.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class OtherContactView extends StatefulWidget {
  final Dispatch dispatch;
  //final DispatchContact dispatchContact;
  OtherContactView({Key key, @required this.dispatch}) : super(key: key);

  @override
  _OtherContactViewState createState() => _OtherContactViewState();
}

class _OtherContactViewState extends State<OtherContactView> {
  TextEditingController contactInputController = new TextEditingController();
  TextEditingController numberInputController = new TextEditingController();
  TextEditingController descriptionInputController =
      new TextEditingController();
  String dropDownValue = "Select delivery type";
  String _deliveryType;

  void setValues(
      String contactPerson, int contactNumber, String description) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    shared.setString('contactPerson', contactPerson);
    shared.setInt('contactNumber', contactNumber);
    shared.setString('description', description);
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
    contactInputController.dispose();
    numberInputController.dispose();
    descriptionInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "New dispatch ${widget.dispatch.dispatchRecord}: ${widget.dispatch.dispatchType} delivery"),
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
                  controller: contactInputController,
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
                  controller: numberInputController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: "Person's name",
                      border: const OutlineInputBorder()),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: numberInputController,
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
                  decoration: InputDecoration(
                      icon: Icon(Icons.confirmation_number),
                      labelText: 'E-way bill number',
                      border: const OutlineInputBorder()),
                ),
                SizedBox(height: 20.0),
                Center(
                  child: RaisedButton(
                    color: Colors.green,
                    textColor: Colors.white,
                    child: Text("Continue"),
                    onPressed: () {
                      setValues(
                          contactInputController.text,
                          int.parse(numberInputController.text),
                          descriptionInputController.text);
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
}
