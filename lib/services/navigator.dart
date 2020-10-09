import 'package:flutter/material.dart';

class Navigate {
  pushNewPage({@required BuildContext context, @required Widget page}) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
  }
}
