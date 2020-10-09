import 'package:flutter/material.dart';
import 'package:tradaru/pages/bill-page.dart';
import 'package:tradaru/pages/fav-page.dart';
import 'package:tradaru/pages/home-page.dart';
import 'package:tradaru/pages/profile-page.dart';
import 'package:tradaru/pages/shop-page.dart';
import 'package:tradaru/tab-navigation/custom-navigation.dart';

class MainTab extends StatefulWidget {
  @override
  _MainTabState createState() => _MainTabState();
}

class _MainTabState extends State<MainTab> {
  int _index = 0;
  Widget _buildBody({int index}) {
    switch (index) {
      case 0:
        return HomePage();
        // return Container();

        break;
      case 1:
        return FavPage();
        break;
      case 2:
        return ShopPage();
        // return Container();
        break;
      case 3:
        return BillPage();
        break;
      case 4:
        return ProfilePage();
        break;
      default:
    }
  }

  Widget _buildNavBar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: NeosBottomNavigation(
        itemOutlineColor: Colors.white,
        backgroundColor: Colors.grey[200],
        unselectedItemColor: Colors.blue,
        //setIndex: _setIndex,
        items: [
          NeosBottomNavigationItem(
            icon: Icon(Icons.home),
            title: "Map",
          ),
          NeosBottomNavigationItem(
            icon: Icon(Icons.favorite),
            title: "Directions",
          ),
          NeosBottomNavigationItem(
            icon: Icon(Icons.shopping_cart),
            title: "shop",
          ),
          NeosBottomNavigationItem(
            icon: Icon(Icons.event_note),
            title: "shop",
          ),
          NeosBottomNavigationItem(
            icon: Icon(Icons.person),
            title: "shop",
          ),
        ],
        onTap: (index) {
          setState(() {
            _index = index;
          });
          // _pageController.animateToPage(index,
          //     curve: Curves.fastLinearToSlowEaseIn,
          //     duration: Duration(milliseconds: 600));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              _buildBody(index: _index),
              _buildNavBar(),
            ],
          ),
        ));
  }
}
