import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenwaydispatch/data/dispatch_bloc/dispatch_bloc.dart';
import 'home_widget.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'models/Dispatch.dart';
import 'package:greenwaydispatch/data/history_bloc/history_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (BuildContext context) {
            return DispatchBloc();
          }),
          BlocProvider(create: (BuildContext context) {
            return HistoryBloc();
          }),
        ],
        child: MaterialApp(
          title: 'Dispatch Executive App',
          theme: ThemeData(
              primarySwatch: Colors.green,
              textTheme: Theme.of(context).textTheme.apply(
                    fontSizeDelta: 2.0,
                  )),
          home: Home(),
        ));
  }
}
