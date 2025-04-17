import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:tv_randshow/ui/features/home/home_view.dart';
import 'package:tv_randshow/ui/features/info/views/info_view.dart';
import 'package:tv_randshow/ui/features/random/views/loading_trending_tvshow_view.dart';
import 'package:tv_randshow/ui/features/random/views/loading_tvshows_view.dart';
import 'package:tv_randshow/ui/features/search/search_view.dart';
import 'package:tv_randshow/ui/router.dart';
import 'package:tv_randshow/ui/widgets/expandable_fab/expandable_fab.dart';
import 'package:tv_randshow/ui/widgets/expandable_fab/fab_action_button.dart';
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
    const bigSize = 600;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
            Theme.of(context).colorScheme.brightness == Brightness.dark
                ? Brightness.light
                : Brightness.dark,
      ),
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton:
            _selectedIndex == 0 ? const _RandomActions(bigSize: bigSize) : null,
        body: LayoutBuilder(
          builder:
              (BuildContext context, BoxConstraints constraints) =>
                  constraints.maxWidth > bigSize
                      ? Row(
                        children: <Widget>[
                          _BigScreenMenu(
                            onChange: (index) {
                              setState(() {
                                _selectedIndex = index;
                              });
                            },
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
                          _SmallScreenMenu(
                            onChange: (index) {
                              setState(() {
                                _selectedIndex = index;
                              });
                            },
                            selectedIndex: _selectedIndex,
                          ),
                        ],
                      ),
        ),
      ),
    );
  }
}

class _BigScreenMenu extends StatelessWidget {
  final int selectedIndex;
  final void Function(int index) onChange;
  const _BigScreenMenu({required this.selectedIndex, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      labelType: NavigationRailLabelType.all,
      onDestinationSelected: onChange,
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
          icon: const Icon(UniconsLine.setting),
          label: Text(translate('app.info.tab')),
        ),
      ],
      selectedIndex: selectedIndex,
    );
  }
}

class _SmallScreenMenu extends StatelessWidget {
  final int selectedIndex;
  final void Function(int index) onChange;
  const _SmallScreenMenu({required this.selectedIndex, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onChange,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: const Icon(UniconsLine.favorite, key: Key('app.fav.tab')),
          label: translate('app.fav.tab'),
        ),
        BottomNavigationBarItem(
          icon: const Icon(UniconsLine.search, key: Key('app.search.tab')),
          label: translate('app.search.tab'),
        ),
        BottomNavigationBarItem(
          icon: const Icon(UniconsLine.setting, key: Key('app.info.tab')),
          label: translate('app.info.tab'),
        ),
      ],
    );
  }
}

class _RandomActions extends StatelessWidget {
  const _RandomActions({required this.bigSize});

  final int bigSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ExpandableFab(
          startAngle: 45,
          children: [
            FabActionButton(
              icon: const Icon(UniconsLine.tv_retro),
              onPressed:
                  () => Navigator.of(
                    context,
                  ).pushNamed<LoadingTvshowsView>(RoutePaths.loadingTvshows),
            ),
            FabActionButton(
              icon: const Icon(UniconsLine.arrow_growth),
              onPressed:
                  () => Navigator.of(
                    context,
                  ).pushNamed<LoadingTrendingTvshowView>(
                    RoutePaths.loadingTrendingTvshow,
                  ),
            ),
          ],
        ),
        if (MediaQuery.of(context).size.width <= bigSize)
          const SizedBox(height: 56),
      ],
    );
  }
}
