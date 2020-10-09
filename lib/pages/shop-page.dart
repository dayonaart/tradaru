import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter/rendering.dart';
import 'package:tradaru/pages/detail-product.dart';
import 'package:tradaru/services/navigator.dart';
import 'package:tradaru/widget/custom-appbar.dart';
import 'package:tradaru/widget/custom-gridview.dart';
import 'package:tradaru/widget/rating.dart';

class ShopPage extends StatefulWidget {
  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  DatabaseReference _productRef;
  List<Map<dynamic, dynamic>> _dataProduct;
  TextStyle _textStyle({double fontSize, Color color}) => TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: fontSize ?? 12,
      color: color ?? Colors.black);
  int _totalProduct = 4;
  List<double> _rating = [];
  List<bool> _favController = [];

  _categoryItem({String title, Widget widget}) {
    return RaisedButton(
      color: Colors.white,
      child: Row(
        children: List.generate(2, (i) {
          switch (i) {
            case 0:
              return Padding(
                  padding: EdgeInsetsDirectional.only(end: 5), child: widget);
              break;
            case 1:
              return Text(title);
              break;
            default:
          }
        }),
      ),
      onPressed: () {},
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }

  _category() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(3, (i) {
        switch (i) {
          case 0:
            return _categoryItem(
                title: "Sneaker",
                widget: Image.asset(
                  'assets/nike1.png',
                  scale: 25,
                ));
            break;
          case 1:
            return _categoryItem(title: "Watch", widget: Icon(Icons.watch));
            break;
          case 2:
            return _categoryItem(
                title: "Wallet", widget: Icon(Icons.account_balance_wallet));

            break;
          default:
        }
      }),
    );
  }

  _itemCard({@required int index}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.green,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(_dataProduct[index]['off'],
                        style: _textStyle(fontSize: 12)),
                  ),
                ),
                Container(
                  height: 30,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          _favController[index] ? Colors.pink : Colors.white),
                  child: Center(
                    child: IconButton(
                        icon: Icon(Icons.favorite, size: 15),
                        onPressed: () {
                          setState(() {
                            _favController[index] = !_favController[index];
                          });
                        },
                        color:
                            _favController[index] ? Colors.white : Colors.grey),
                  ),
                )
              ],
            ),
            _productImg(),
            SizedBox(height: 10),
            Column(
              children: [
                Text(
                  _dataProduct[index]['name'],
                  style: _textStyle(fontSize: 16),
                ),
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "\$",
                      style: _textStyle(fontSize: 12),
                    ),
                    Text(
                        int.tryParse(_dataProduct[index]['price'])
                            .toStringAsFixed(2),
                        style: _textStyle(fontSize: 18, color: Colors.blue))
                  ],
                ),
                SizedBox(height: 10),
                _ratingProduct(index: index)
              ],
            )
          ],
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }

  _productImg() {
    return GestureDetector(
      onTap: () {
        Navigate().pushNewPage(
            context: context,
            page: DetailProduct(
              product: _dataProduct,
            ));
      },
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 7,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: Colors.orange[100]),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  height: MediaQuery.of(context).size.height / 8,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.white),
                      shape: BoxShape.circle,
                      color: Colors.orange[100])),
            ),
          ),
          Center(
            child: Transform.rotate(
              angle: -math.pi / 10,
              child: Image.asset(
                'assets/nike1.png',
                scale: 7.5,
              ),
            ),
          )
        ],
      ),
    );
  }

  Row _ratingProduct({int index}) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      StarRating(
          rating: _rating[index],
          onRatingChanged: (rating) {
            setState(() {
              _rating[index] = rating;
            });
          }),
      Text("(${_rating[index]})")
    ]);
  }

  _initializeAll() async {
    _productRef.onChildAdded.listen((event) {
      _productRef.once().then((value) {
        List<Map<dynamic, dynamic>> _tempData = [];
        value.value.forEach((k, v) {
          _tempData.add(v);
        });
        if (!mounted) return;
        setState(() {
          _dataProduct = _tempData;
        });
      });
    });
    _productRef.onValue.listen((event) {
      _productRef.once().then((value) {
        List<Map<dynamic, dynamic>> _tempData = [];
        value.value.forEach((k, v) {
          _tempData.add(v);
        });
        if (!mounted) return;

        setState(() {
          _dataProduct = _tempData;
        });
      });
    });
    await _productRef.once().then((value) {
      List<Map<dynamic, dynamic>> _tempData = [];
      value.value.forEach((k, v) {
        _tempData.add(v);
      });
      if (!mounted) return;

      setState(() {
        _dataProduct = _tempData;
      });
    });
    _rating = List.generate(_dataProduct.length, (i) => 0);
    _favController = List.generate(_dataProduct.length, (i) => false);
  }

  @override
  void initState() {
    // TODO: implement initState
    _productRef = FirebaseDatabase.instance.reference().child('products/');
    _initializeAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: Scaffold(
          key: _scaffoldKey,
          drawer: Drawer(),
          appBar: CustomAppBar().appBar(
            leading: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  _scaffoldKey.currentState.openDrawer();
                }),
            textStyle: _textStyle(fontSize: 14),
            prefix: IconButton(icon: Icon(Icons.search), onPressed: () {}),
          ),
          body: Padding(
            padding:
                const EdgeInsetsDirectional.only(bottom: 80, start: 5, end: 5),
            child: ListView(children: [
              _category(),
              Builder(builder: (context) {
                switch (_dataProduct != null) {
                  case true:
                    return GridView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: CustomGridView(
                          height: MediaQuery.of(context).size.height / 2.6,
                          crossAxisCount: 2),
                      children: List.generate(
                          _dataProduct.length, (i) => _itemCard(index: i)),
                    );
                    break;
                  case false:
                    return CupertinoActivityIndicator();
                    break;
                  default:
                }
              })
            ]),
          ),
        ));
  }
}
