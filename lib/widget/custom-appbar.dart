import 'package:flutter/material.dart';

class CustomAppBar {
  PreferredSize appBar({
    TextStyle textStyle,
    @required IconButton prefix,
    IconButton leading,
    bool isBottomWidget = true,
  }) {
    return PreferredSize(
        child: Container(
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(3, (i) {
                  switch (i) {
                    case 0:
                      return leading;
                      break;
                    case 1:
                      return Text("XE", style: textStyle);
                      break;
                    case 2:
                      return prefix;
                      break;
                    default:
                  }
                }),
              ),
              isBottomWidget
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(2, (i) {
                          switch (i) {
                            case 0:
                              return Text(
                                "OUR PRODUCT",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              );
                              break;
                            case 1:
                              return Row(
                                children: [
                                  Text("sort by"),
                                  Icon(Icons.arrow_drop_down)
                                ],
                              );
                              break;
                            default:
                          }
                        }),
                      ),
                    )
                  : Container()
            ],
          ),
        ),
        preferredSize: Size(0, 70));
  }
}
