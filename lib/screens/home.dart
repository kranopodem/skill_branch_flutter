import 'dart:async';

import 'package:FlutterGalleryApp/res/res.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'feed_screen.dart';

class Home extends StatefulWidget {
  Home(this.onConnectivityChanged);
  final Stream<ConnectivityResult> onConnectivityChanged;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  StreamSubscription subscription;
  int currentTab = 0;

  List<Widget> pages = [
    Feed(),
    Container(),
    Container(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavyBar(
        itemCornetRadius: 8,
        curve: Curves.ease,
        onItemSelected: (int index) {
          setState(() {
            currentTab = index;
          });
        },
        currentTab: currentTab,
        items: [
          BottomNavyBarItem(
            asset: AppIcons.home,
            title: Text('Feed'),
            activeColor: AppColors.dodgerBlue,
            inactiveColor: AppColors.manatee,
          ),
          BottomNavyBarItem(
            asset: AppIcons.home,
            title: Text('Search'),
            activeColor: AppColors.dodgerBlue,
            inactiveColor: AppColors.manatee,
          ),
          BottomNavyBarItem(
            asset: AppIcons.home,
            title: Text('User'),
            activeColor: AppColors.dodgerBlue,
            inactiveColor: AppColors.manatee,
          ),
        ],
      ),
      body: pages[currentTab],
    );
  }

  @override
  void initState() {
    super.initState();

    subscription =
        widget.onConnectivityChanged.listen((ConnectivityResult result) {
      var overlay = ConnectivityOverlay();
      switch (result) {
        case ConnectivityResult.wifi:
          overlay.removeOverlay(context);
// Вызовете удаление Overlay тут
          break;
        case ConnectivityResult.mobile:
          overlay.removeOverlay(context);
// Вызовете удаление Overlay тут
          break;
        case ConnectivityResult.none:
          overlay.showOverlay(context, null);
// Вызовете отображения Overlay тут
          break;
      }
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}

class BottomNavyBar extends StatelessWidget {
  BottomNavyBar({
    Key key,
    this.backgroundColor = Colors.white,
    this.showElevation = true,
    this.containerHeight = 56,
    this.items,
    this.onItemSelected,
    this.currentTab,
    this.animationDuration = const Duration(milliseconds: 270),
    this.itemCornetRadius = 24,
    this.curve,
  }) : super(key: key);

  final Color backgroundColor;
  final bool showElevation;
  final double containerHeight;
  final List<BottomNavyBarItem> items;
  final ValueChanged<int> onItemSelected;
  final int currentTab;
  final Duration animationDuration;
  final double itemCornetRadius;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          if (showElevation)
            const BoxShadow(color: Colors.black12, blurRadius: 2)
        ],
      ),
      child: SafeArea(
        child: Container(
            width: double.infinity,
            height: containerHeight,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: items.map((e) {
                var index = items.indexOf(e);
                return GestureDetector(
                  onTap: () => onItemSelected(index),
                  child: _ItemWidget(
                      isSelected: currentTab == index,
                      item: e,
                      backgroundColor: backgroundColor,
                      animationDuration: animationDuration,
                      curve: curve,
                      itemCornetRadius: itemCornetRadius),
                );
              }).toList(),
            )),
      ),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  _ItemWidget({
    @required this.isSelected,
    @required this.item,
    @required this.backgroundColor,
    @required this.animationDuration,
    this.curve = Curves.linear,
    @required this.itemCornetRadius,
  })  : assert(animationDuration != null, 'animationDuration is null'),
        assert(isSelected != null, 'isSelected is null'),
        assert(backgroundColor != null, 'backgroundColor is null'),
        assert(itemCornetRadius != null, 'itemCornetRadius is null'),
        assert(item != null, 'item is null');

  final bool isSelected;
  final BottomNavyBarItem item;
  final Color backgroundColor;
  final Duration animationDuration;
  final Curve curve;
  final double itemCornetRadius;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: animationDuration,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      width: isSelected
          ? 150
          : (MediaQuery.of(context).size.width - 150 - 8 * 4 - 4 * 2) / 2,
      height: double.maxFinite,
      curve: curve,
      decoration: BoxDecoration(
        color: isSelected ? item.activeColor.withOpacity(0.2) : backgroundColor,
        borderRadius: BorderRadius.circular(itemCornetRadius),
      ),
      child: Row(children: <Widget>[
        Icon(item.asset,
            size: 20,
            color: isSelected ? item.activeColor : item.inactiveColor),
        SizedBox(width: 4),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 4,
            ),
            child: DefaultTextStyle.merge(
              child: item.title,
              textAlign: item.textAlign,
              maxLines: 1,
              style: TextStyle(
                color: isSelected ? item.activeColor : item.inactiveColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        )
      ]),
    );
  }
}

class BottomNavyBarItem {
  BottomNavyBarItem({
    this.asset,
    this.title,
    this.activeColor,
    this.inactiveColor,
    this.textAlign,
  }) {
    assert(asset != null, 'Asset is null');
    assert(title != null, 'title is null');
  }

  final IconData asset;
  final Text title;
  final Color activeColor;
  final Color inactiveColor;
  final TextAlign textAlign;
}
