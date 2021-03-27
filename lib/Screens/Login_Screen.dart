

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_api_fetch_provider/Services/Routes_Names.dart';


class Login_Screen extends StatefulWidget {
  @override
  _Login_ScreenState createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    return SafeArea(child: Scaffold(
      body: Column(
        children: [
          Center(
            child: ElevatedButton(child: Text("Dashboard1 In"),onPressed: (){
              Navigator.pushNamed(context, Routes_Names.Dashboard1_Screen);
            },),
          ),
          Center(
            child: ElevatedButton(child: Text("Dashboard2 In"),onPressed: (){
              Navigator.pushNamed(context, Routes_Names.Dashboard2_Screen);
            },),
          ),
        ],
      ), 
    ));
  }
}
