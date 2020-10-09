import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _fieldFocusChange({
    @required BuildContext context,
    @required FocusNode currentFocus,
    @required FocusNode nextFocus,
  }) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  DatabaseReference _reference;
  _snackBar({String message}) => SnackBar(content: Text(message));
  List<FocusNode> _textFocus = List.generate(5, (i) => FocusNode());
  List<TextEditingController> _textController =
      List.generate(5, (i) => TextEditingController(text: null));
  _addedProduct() async {
    _reference = FirebaseDatabase.instance.reference().child('products/');
    await _reference.push().set({
      "name": _textController[0].text,
      "price": _textController[1].text,
      "off": _textController[2].text,
      "size": _textController[3].text,
      "desc": _textController[4].text,
    });
  }

  _textField({int index}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: CupertinoTextField(
        focusNode: _textFocus[index],
        textInputAction:
            index == 5 ? TextInputAction.done : TextInputAction.next,
        onEditingComplete: () {
          if (index == 5) {
            _textFocus.forEach((element) {
              element.unfocus();
            });
          } else {
            _fieldFocusChange(
                context: context,
                currentFocus: _textFocus[index],
                nextFocus: _textFocus[++index]);
          }
        },
        maxLines: index == 4 ? null : 1,
        controller: _textController[index],
        placeholder: _placeHolder(index: index),
      ),
    );
  }

  String _placeHolder({int index}) {
    switch (index) {
      case 0:
        return "Product Name";
        break;
      case 1:
        return "Price (exp : 220)";
        break;
      case 2:
        return "Off (exp : 30%)";
        break;
      case 3:
        return "Size (exp : 41)";
        break;
      case 4:
        return "Description";
        break;
      default:
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_textController.length, (i) {
              switch (i != 4) {
                case true:
                  return _textField(index: i);
                  break;
                case false:
                  return Column(
                    children: [
                      _textField(index: i),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: FlatButton(
                          onPressed: () {
                            var _validationField = _textController.where(
                                (element) =>
                                    element.text == null || element.text == "");
                            if (_validationField.length > 0) {
                              Scaffold.of(context).showSnackBar(
                                  _snackBar(message: "Field can\'t be empty"));
                            } else {
                              _addedProduct();
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Text("Add Product"),
                          ),
                          shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      )
                    ],
                  );
                default:
              }
            }),
          ),
        ));
  }
}
