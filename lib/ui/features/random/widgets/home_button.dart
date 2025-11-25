import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tv_randshow/ui/features/init/tab_view.dart';
import 'package:tv_randshow/ui/router.dart';
import 'package:tv_randshow/ui/shared/styles.dart';
import 'package:unicons/unicons.dart';

class HomeButton extends StatelessWidget {
  const HomeButton({super.key, required this.keyText});
  final String keyText;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key(keyText),
      padding: const EdgeInsets.only(top: Styles.standard),
      child: TextButton.icon(
        label: Text(context.tr(keyText)),
        icon: const Icon(UniconsLine.favorite),
        onPressed:
            () => Navigator.pushNamedAndRemoveUntil<TabView>(
              context,
              RoutePaths.tab,
              ModalRoute.withName(RoutePaths.tab),
            ),
      ),
    );
  }
}
