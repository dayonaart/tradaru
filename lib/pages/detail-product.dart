import 'package:flutter/material.dart';
import 'package:tradaru/widget/carousel.dart';
import 'package:tradaru/widget/custom-appbar.dart';

class DetailProduct extends StatefulWidget {
  List<Map<dynamic, dynamic>> product;
  DetailProduct({@required this.product});
  @override
  _DetailProductState createState() => _DetailProductState(product: product);
}

class _DetailProductState extends State<DetailProduct> {
  List<Map<dynamic, dynamic>> product;
  _DetailProductState({@required this.product});
  List<bool> _indexProduct = [];
  _cicleContainer({
    @required double padding,
    Color color,
    double border,
  }) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: border ?? 0, color: Colors.brown[100]),
          color: color ?? Colors.white,
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    _indexProduct = List.generate(product.length, (i) {
      if (i == 0) {
        return true;
      } else {
        return false;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: Scaffold(
          appBar: CustomAppBar().appBar(
              leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              prefix: IconButton(icon: Icon(Icons.favorite), onPressed: () {}),
              isBottomWidget: false),
          body: ListView(
            children: [
              Column(
                children: [
                  Builder(builder: (context) {
                    return Align(
                      alignment: Alignment.center,
                      child: Card(
                          color: Colors.blue[200],
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Text(
                              product[_indexProduct.indexOf(true)]['off'],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )),
                    );
                  }),
                  buildCarouselSlider(context),
                  buildIndexProduct()
                ],
              ),
              buildBottomWidget(context)
            ],
          ),
        ));
  }

  Container buildBottomWidget(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.grey[300],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product[_indexProduct.indexOf(true)]['name'],
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.orange,
                        ),
                        Text("(4.0)")
                      ],
                    )
                  ],
                ),
                SizedBox(height: 10),
                Text(product[_indexProduct.indexOf(true)]['desc']),
                SizedBox(height: 20),
                _actualSizeProduct(),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      "Available Colors : ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: List.generate(4, (i) {
                        switch (i) {
                          case 0:
                            return buildAvailableColors(color: Colors.yellow);
                            break;
                          case 1:
                            return buildAvailableColors(color: Colors.red);
                            break;
                          case 2:
                            return buildAvailableColors(color: Colors.pink);
                            break;
                          case 3:
                            return buildAvailableColors(
                                color: Colors.blue[200]);
                            break;
                          default:
                        }
                      }),
                    )
                  ],
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height / 8,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(30)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text("\$"),
                        Text(
                            int.tryParse(product[_indexProduct.indexOf(true)]
                                    ['price'])
                                .toStringAsFixed(2),
                            style: TextStyle(
                                fontWeight: FontWeight.w900, fontSize: 30)),
                      ],
                    ),
                    RaisedButton(
                      color: Colors.grey[100],
                      child: Row(children: [
                        Icon(Icons.add_shopping_cart),
                        Text("Add To Cart")
                      ]),
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  buildAvailableColors({
    Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      ),
    );
  }

  Padding buildIndexProduct() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
            product.length,
            (i) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Container(
                    width: _indexProduct[i] ? 20 : 10,
                    height: 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: _indexProduct[i] ? Colors.blue[300] : Colors.grey,
                    ),
                  ),
                )),
      ),
    );
  }

  CarouselSlider buildCarouselSlider(BuildContext context) {
    return CarouselSlider(
      onPageChanged: (index) {
        for (var i = 0; i < _indexProduct.length; i++) {
          if (i == index) {
            setState(() {
              _indexProduct[i] = true;
            });
          } else {
            setState(() {
              _indexProduct[i] = false;
            });
          }
        }
      },
      enableInfiniteScroll: false,
      height: MediaQuery.of(context).size.height / 2.5,
      viewportFraction: 0.90,
      items: List.generate(
        product.length,
        (i) => Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 1, color: Colors.brown[100])),
            child: Stack(
              children: [
                _cicleContainer(padding: 10, color: Colors.white),
                _cicleContainer(padding: 20, color: Colors.white),
                _cicleContainer(padding: 30, color: Colors.brown[200]),
                _cicleContainer(padding: 60, color: Colors.brown[100]),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/nike1.png',
                    scale: 4,
                  ),
                )
              ],
            )),
      ),
    );
  }

  Row _actualSizeProduct() {
    return Row(
      children: [
        Text(
          "Size : ",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Row(
          children: List.generate(4, (i) {
            var _size = product[_indexProduct.indexOf(true)]['size'];
            switch (i) {
              case 0:
                return _sizeProduct(
                    title: "US 6",
                    isColor:
                        int.tryParse(_size) >= 30 && int.tryParse(_size) <= 35);
                break;
              case 1:
                return _sizeProduct(
                    title: "US 7",
                    isColor:
                        int.tryParse(_size) >= 35 && int.tryParse(_size) <= 38);
                break;
              case 2:
                return _sizeProduct(
                    title: "US 8",
                    isColor:
                        int.tryParse(_size) >= 38 && int.tryParse(_size) <= 40);
                break;
              case 3:
                return _sizeProduct(
                    title: "US 9", isColor: int.tryParse(_size) > 40);
                break;
              default:
            }
          }),
        )
      ],
    );
  }

  _sizeProduct({
    String title,
    bool isColor = false,
  }) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Card(
            color: isColor ? Colors.blue[200] : Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )));
  }
}
