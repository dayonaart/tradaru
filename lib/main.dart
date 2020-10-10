import 'package:flutter/material.dart';
import 'package:tradaru/main-tab.dart';
import 'package:tradaru/services/firebasesdk.dart';

void main() {
  runApp(StartingPage());
}

class StartingPage extends StatefulWidget {
  @override
  _StartingPageState createState() => _StartingPageState();
}

class _StartingPageState extends State<StartingPage> {
  @override
  void initState() {
    // TODO: implement initState
    FirebaseSdk().init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainTab(),
    );
  }
}
