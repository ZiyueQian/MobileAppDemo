import 'package:flutter/material.dart';
import 'home_widget.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'models/Dispatch.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentaryDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentaryDirectory.path);
  Hive.registerAdapter(DispatchAdapter());
  runApp(MyApp());
  final dispatchBox = await Hive.openBox('dispatch');
  final historyBox = await Hive.openBox('history');
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Dispatch Executive App',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: FutureBuilder(
            future: Hive.openBox('dispatch'),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError)
                  return Text(snapshot.error.toString());
                else
                  return Home();
              } else
                return Scaffold();
            }));
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}
