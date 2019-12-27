import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import '../../models/app_model.dart';
import '../../utils/styles.dart';
import '../../utils/unicons_icons.dart';
import 'base_view.dart';
import 'fav_view.dart';
import 'search_view.dart';

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
                icon: Icon(Unicons.favourite),
                title: Text(FlutterI18n.translate(context, 'app.fav.tab'))),
            BottomNavigationBarItem(
                icon: Icon(Unicons.search),
                title: Text(FlutterI18n.translate(context, 'app.search.tab'))),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: StyleColor.PRIMARY,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
