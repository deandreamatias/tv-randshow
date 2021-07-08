import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:unicons/unicons.dart';

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
    const HomeView(),
    const SearchView(),
    const InfoView(),
  ];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
            Theme.of(context).colorScheme.brightness == Brightness.dark
                ? Brightness.light
                : Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) =>
                constraints.maxWidth > 600
                    ? Row(
                        children: <Widget>[
                          NavigationRail(
                            labelType: NavigationRailLabelType.all,
                            onDestinationSelected: (int value) {
                              setState(() {
                                _selectedIndex = value;
                              });
                            },
                            destinations: <NavigationRailDestination>[
                              NavigationRailDestination(
                                icon: const Icon(UniconsLine.favorite),
                                label: Text(translate('app.fav.tab')),
                              ),
                              NavigationRailDestination(
                                icon: const Icon(UniconsLine.search),
                                label: Text(translate('app.search.tab')),
                              ),
                              NavigationRailDestination(
                                icon: const Icon(UniconsLine.info_circle),
                                label: Text(translate('app.info.tab')),
                              )
                            ],
                            selectedIndex: _selectedIndex,
                          ),
                          const VerticalDivider(thickness: 1, width: 1),
                          Expanded(
                            child: _widgetOptions.elementAt(_selectedIndex),
                          ),
                        ],
                      )
                    : Column(
                        children: <Widget>[
                          Expanded(
                            child: _widgetOptions.elementAt(_selectedIndex),
                          ),
                          BottomNavigationBar(
                            currentIndex: _selectedIndex,
                            onTap: (int value) {
                              setState(() {
                                _selectedIndex = value;
                              });
                            },
                            items: <BottomNavigationBarItem>[
                              BottomNavigationBarItem(
                                icon: const Icon(
                                  UniconsLine.favorite,
                                  key: const Key('app.fav.tab'),
                                ),
                                label: translate('app.fav.tab'),
                              ),
                              BottomNavigationBarItem(
                                icon: const Icon(
                                  UniconsLine.search,
                                  key: const Key('app.search.tab'),
                                ),
                                label: translate('app.search.tab'),
                              ),
                              BottomNavigationBarItem(
                                icon: const Icon(
                                  UniconsLine.info_circle,
                                  key: const Key('app.info.tab'),
                                ),
                                label: translate('app.info.tab'),
                              ),
                            ],
                          )
                        ],
                      ),
          ),
        ),
      ),
    );
  }
}
