import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:tv_randshow/core/utils/constants.dart';
import 'package:tv_randshow/ui/views/tab_view.dart';
import 'package:unicons/unicons.dart';

class HomeButton extends StatelessWidget {
  const HomeButton({super.key, required this.text});
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
          RoutePaths.tab,
          ModalRoute.withName(RoutePaths.tab),
        ),
      ),
    );
  }
}
