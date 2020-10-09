import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tradaru/widget/custom-appbar.dart';
import 'package:tradaru/widget/custom-gridview.dart';

class FavPage extends StatefulWidget {
  @override
  _FavPageState createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  DatabaseReference _favRef;
  List<Map<dynamic, dynamic>> _favProduct;
  TextStyle _textStyle({double fontSize, Color color}) => TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: fontSize ?? 12,
      color: color ?? Colors.black);
  @override
  void initState() {
    // TODO: implement initState
    _favRef = FirebaseDatabase.instance.reference().child("favorite/");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: Scaffold(
            // appBar: CustomAppBar().appBar(textStyle: _textStyle()),
            // body: GridView(
            //   physics: NeverScrollableScrollPhysics(),
            //   shrinkWrap: true,
            //   gridDelegate: CustomGridView(
            //       height: MediaQuery.of(context).size.height / 2.6,
            //       crossAxisCount: 2),
            //   children: List.generate(_favProduct.length, (i) => Text("data")),
            // ),
            ));
  }
}
