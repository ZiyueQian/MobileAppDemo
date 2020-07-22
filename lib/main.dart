import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenwaydispatch/dispatch_bloc/dispatch_bloc.dart';
import 'home_widget.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'models/Dispatch.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
//  final appDocumentaryDirectory =
//      await path_provider.getApplicationDocumentsDirectory();
//  Hive.init(appDocumentaryDirectory.path);
//  Hive.registerAdapter(DispatchAdapter());
  runApp(MyApp());
//  final dispatchBox = await Hive.openBox('dispatch');
//  final historyBox = await Hive.openBox('history');
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        bloc: DispatchBloc(),
        child: MaterialApp(
          title: 'Dispatch Executive App',
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          home: Home(),
        ));
  }

//  @override
//  void dispose() {
//    Hive.close();
//    super.dispose();
//  }
}
