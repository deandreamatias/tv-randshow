import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import '../shared/styles.dart';
import '../shared/unicons_icons.dart';
import 'home_view.dart';
import 'search_view.dart';

class TabView extends StatefulWidget {
  const TabView({Key key}) : super(key: key);

  @override
  _TabViewState createState() => _TabViewState();
}

class _TabViewState extends State<TabView> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const HomeView(),
    const SearchView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO: Implement menu to get feedback and rate app
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Unicons.favorite),
            title: Text(FlutterI18n.translate(context, 'app.fav.tab')),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Unicons.search),
            title: Text(FlutterI18n.translate(context, 'app.search.tab')),
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
