import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import '../shared/styles.dart';
import '../widgets/favorite_list.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              FlutterI18n.translate(context, 'app.fav.title'),
              style: StyleText.MESSAGES,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(child: FavoriteList()),
        ],
      ),
    );
  }
}
