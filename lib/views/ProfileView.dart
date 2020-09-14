import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  @override
  ProfileView({Key key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(20.0),
        child: Center(
          child: FlatButton(
              child: Container(
                height: 50,
                child: Center(
                  child: Text(
                    "LOG OUT",
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
                Navigator.pushReplacementNamed(context, '/');
                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text('Logging out')));
              }),
        ));
  }
}
