import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:unicons/unicons.dart';

import '../../core/utils/constants.dart';
import '../views/tab_view.dart';

class HomeButton extends StatelessWidget {
  const HomeButton({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key(text),
      padding: const EdgeInsets.only(top: 16.0),
      child: TextButton.icon(
        label: Text(
          translate(text),
        ),
        icon: const Icon(UniconsLine.favorite),
        onPressed: () => Navigator.pushNamedAndRemoveUntil<TabView>(
          context,
          RoutePaths.TAB,
          ModalRoute.withName(RoutePaths.TAB),
        ),
      ),
    );
  }
}
