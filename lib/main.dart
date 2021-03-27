import 'package:flutter/material.dart';
import 'package:flutter_api_fetch_provider/Screens/Dashboard1_Screen.dart';
import 'package:flutter_api_fetch_provider/Screens/Dashboard2_Screen.dart';
import 'package:flutter_api_fetch_provider/Screens/Login_Screen.dart';
import 'package:flutter_api_fetch_provider/Services/Routes_Names.dart';
import 'package:flutter_api_fetch_provider/Services/Todo_Provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers:[
      ChangeNotifierProvider<Todo_Provider>(create: (context) => Todo_Provider(),)
    ],child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      routes: {
        Routes_Names.Login_Screen : (context) => Login_Screen(),
        Routes_Names.Dashboard1_Screen : (context) => Dashboard1_Screen(),
        Routes_Names.Dashboard2_Screen : (context) => Dashboard2_Screen(),
      },
      home: Login_Screen(),
    ),);
  }
}

