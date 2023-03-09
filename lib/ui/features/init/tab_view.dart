import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:tv_randshow/ui/features/home/home_view.dart';
import 'package:tv_randshow/ui/features/info/views/info_view.dart';
import 'package:tv_randshow/ui/features/search/search_view.dart';
import 'package:unicons/unicons.dart';

class TabView extends StatefulWidget {
  const TabView({super.key});

  @override
  TabViewState createState() => TabViewState();
}

class TabViewState extends State<TabView> {
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
        backgroundColor: Theme.of(context).colorScheme.background,
        body: LayoutBuilder(
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
                          child: SafeArea(
                            left: false,
                            child: _widgetOptions.elementAt(_selectedIndex),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: <Widget>[
                        Expanded(
                          child: SafeArea(
                            child: _widgetOptions.elementAt(_selectedIndex),
                          ),
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
                                key: Key('app.fav.tab'),
                              ),
                              label: translate('app.fav.tab'),
                            ),
                            BottomNavigationBarItem(
                              icon: const Icon(
                                UniconsLine.search,
                                key: Key('app.search.tab'),
                              ),
                              label: translate('app.search.tab'),
                            ),
                            BottomNavigationBarItem(
                              icon: const Icon(
                                UniconsLine.info_circle,
                                key: Key('app.info.tab'),
                              ),
                              label: translate('app.info.tab'),
                            ),
                          ],
                        )
                      ],
                    ),
        ),
      ),
    );
  }
}
