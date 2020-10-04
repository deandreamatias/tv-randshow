import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import '../widgets/favorite_list.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            translate('app.fav.title'),
            key: const Key('app.fav.title'),
            style: Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(child: FavoriteList()),
      ],
    );
  }
}
