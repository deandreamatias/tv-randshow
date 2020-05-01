import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../shared/styles.dart';
import '../shared/unicons_icons.dart';
import 'home_view.dart';
import 'info_view.dart';
import 'search_view.dart';

class TabView extends StatefulWidget {
  const TabView({Key key}) : super(key: key);

  @override
  _TabViewState createState() => _TabViewState();
}

class _TabViewState extends State<TabView> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    if (!kIsWeb) const HomeView(),
    const SearchView(),
    const InfoView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          if (!kIsWeb)
            BottomNavigationBarItem(
              icon: const Icon(Unicons.favorite),
              title: Text(translate('app.fav.tab')),
            ),
          BottomNavigationBarItem(
            icon: const Icon(Unicons.search),
            title: Text(translate('app.search.tab')),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Unicons.info_circle),
            title: Text(translate('app.info.tab')),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: StyleColor.PRIMARY,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
