import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenwaydispatch/data/dispatch_bloc/dispatch_bloc.dart';
import 'home_widget.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'models/Dispatch.dart';
import 'package:greenwaydispatch/data/history_bloc/history_bloc.dart';
import 'package:get_it/get_it.dart';
import 'dispatchesService.dart';
import 'package:greenwaydispatch/loginAndSignup/interface/LoginPage.dart';
import 'package:provider/provider.dart';
import 'package:greenwaydispatch/api/post_api_service.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton(() => DispatchesService());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
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
                    fontSizeDelta: 0.0,
                  )),
//          home: Home(),
          home: Home(), //change this for testing
        ));
  }
}
