import 'package:flutter/material.dart';

import 'package:tv_randshow/src/models/app_model.dart';
import 'package:tv_randshow/src/ui/views/base_view.dart';
import 'package:tv_randshow/src/ui/views/fav_view.dart';
import 'package:tv_randshow/src/ui/views/search_view.dart';
import 'package:tv_randshow/src/utils/styles.dart';
import 'package:tv_randshow/src/utils/unicons_icons.dart';

class AppView extends StatefulWidget {
  const AppView({Key key}) : super(key: key);

  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const FavView(),
    const SearchView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<AppModel>(
      onModelReady: (AppModel model) => model.init(),
      builder: (BuildContext context, Widget child, AppModel model) => Scaffold(
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Unicons.favourite), title: const Text('Favorites')),
            BottomNavigationBarItem(
                icon: Icon(Unicons.search), title: const Text('Search')),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: StyleColor.PRIMARY,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
