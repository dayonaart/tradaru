import 'package:flutter/material.dart';

class NeosBottomNavigation extends StatefulWidget {
  NeosBottomNavigation({
    @required this.items,
    this.backgroundColor = const Color(0XFF003051),
    this.itemBackgroudnColor = const Color(0XFF003051),
    this.itemOutlineColor = const Color(0XFFFFFFFF),
    this.selectedItemColor = const Color(0XFFFFFFFF),
    this.unselectedItemColor = const Color(0XFFFFFFFF),
    this.onTap,
    this.setIndex,
  })  : assert(items != null),
        assert(items.length > 1);

  final List<NeosBottomNavigationItem> items;
  final Color backgroundColor;
  final Color itemBackgroudnColor;
  final Color itemOutlineColor;
  final Color selectedItemColor;
  final Color unselectedItemColor;
  final ValueChanged<int> onTap;
  final int setIndex;
  @override
  _NeosBottomNavigationState createState() => _NeosBottomNavigationState();
}

class _NeosBottomNavigationState extends State<NeosBottomNavigation> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          _buildBackground(),
          _buildItems(),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      color: widget.backgroundColor,
      child: Container(
        width: double.infinity,
        height: 78.0 + MediaQuery.of(context).padding.bottom,
        color: widget.backgroundColor,
      ),
    );
  }

  Widget _buildItems() {
    return SafeArea(
      top: false,
      child: Container(
        height: 110.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: widget.items.map((item) {
            int index = widget.items.indexOf(item);
            return NeosBottomNavigationItemTile(
              item,
              widget.selectedItemColor,
              widget.unselectedItemColor,
              widget.itemOutlineColor,
              widget.backgroundColor,
              widget.itemBackgroudnColor,
              index,
              widget.setIndex != null ? null : _changeCurrentIndex,
              widget.setIndex != null ? widget.setIndex : _currentIndex,
            );
          }).toList(),
        ),
      ),
    );
  }

  void _changeCurrentIndex(int index) {
    setState(() {
      _currentIndex = index;
    });

    widget.onTap(_currentIndex);
  }
}

class NeosBottomNavigationItem {
  NeosBottomNavigationItem({
    @required this.icon,
    @required this.title,
    this.titleTextColor = const Color(0XFFFFFFFF),
  })  : assert(icon != null),
        assert(title.isNotEmpty);
  final Icon icon;
  final String title;
  final Color titleTextColor;
}

class NeosBottomNavigationItemTile extends StatefulWidget {
  NeosBottomNavigationItemTile(
      this.item,
      this.selectedItemColor,
      this.unselectedItemColor,
      this.itemOutlineColor,
      this.backgroundColor,
      this.itemBackgroudnColor,
      this.index,
      this.onChanged,
      this.currentIndex);

  final NeosBottomNavigationItem item;
  final Color selectedItemColor;
  final Color unselectedItemColor;
  final Color itemOutlineColor;
  final Color backgroundColor;
  final Color itemBackgroudnColor;

  final int index;
  final ValueChanged<int> onChanged;

  final int currentIndex;
  @override
  _NeosBottomNavigationItemTileState createState() =>
      _NeosBottomNavigationItemTileState();
}

class _NeosBottomNavigationItemTileState
    extends State<NeosBottomNavigationItemTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: selectItem,
      child: Container(
        height: 130.0,
        width: 70.0,
        child: _buildItem(),
      ),
    );
  }

  Widget _buildItem() {
    Widget icon;

    icon = Container(
      padding: EdgeInsets.all(15.0),
      child: Container(
        width: 30.0,
        height: 30.0,
        child: Icon(widget.item.icon.icon,
            size: widget.item.icon.size,
            color: widget.currentIndex == widget.index
                ? widget.selectedItemColor
                : widget.unselectedItemColor),
      ),
    );

    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 2.0),
          child: AnimatedAlign(
            curve: Curves.easeOutCirc,
            duration: Duration(milliseconds: 300),
            alignment: widget.currentIndex == widget.index
                ? Alignment.topCenter
                : Alignment.bottomCenter,
            child: AnimatedContainer(

                //padding: EdgeInsets.all(15.0),
                curve: Curves.easeOut,
                duration: Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(100.0),
                  ),
                  color: widget.currentIndex == widget.index
                      ? widget.itemBackgroudnColor
                      : widget.backgroundColor,
                  border: Border.all(
                      color: widget.currentIndex == widget.index
                          ? widget.itemOutlineColor
                          : widget.itemOutlineColor.withOpacity(0.0),
                      width: 6.5),
                ),
                child: icon),
          ),
        ),
        // AnimatedOpacity(
        //   opacity: widget.currentIndex == widget.index ? 1.0 : 0.0,
        //   duration: Duration(milliseconds: 150),
        //   curve: Curves.easeInOut,
        //   child: Align(
        //     alignment: Alignment.bottomCenter,
        //     child: Container(
        //       margin: EdgeInsets.only(bottom: 12.0),
        //       child: Text(
        //         widget.item.title,
        //         textAlign: TextAlign.center,
        //         style: TextStyle(color: Colors.white),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  void selectItem() {
    if (widget.onChanged != null) widget.onChanged(widget.index);
  }
}
