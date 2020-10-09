import 'package:flutter/material.dart';
import 'package:tradaru/main-tab.dart';
import 'package:tradaru/services/firebasesdk.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseSdk().init();
  runApp(StartingPage());
}

class StartingPage extends StatefulWidget {
  @override
  _StartingPageState createState() => _StartingPageState();
}

class _StartingPageState extends State<StartingPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainTab(),
    );
  }
}
