import 'package:flutter/material.dart';

import 'package:tv_randshow/src/models/app_model.dart';
import 'package:tv_randshow/src/ui/views/base_view.dart';
import 'package:tv_randshow/src/ui/views/fav_view.dart';
import 'package:tv_randshow/src/ui/views/search_view.dart';
import 'package:tv_randshow/src/utils/styles.dart';

class AppView extends StatefulWidget {
  AppView({Key key}) : super(key: key);

  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    FavView(),
    SearchView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<AppModel>(
      onModelReady: (model) => model.init(),
      builder: (context, child, model) => Scaffold(
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.star), title: Text('Favorites')),
            BottomNavigationBarItem(
                icon: Icon(Icons.search), title: Text('Search')),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: StyleColor.PRIMARY,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
