import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:tv_randshow/ui/router.dart';
import 'package:tv_randshow/ui/shared/custom_icons.dart';
import 'package:tv_randshow/ui/views/loading_view.dart';

class RandomButton extends StatelessWidget {
  const RandomButton({super.key, required this.idTv});
  final int idTv;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(CustomIcons.diceMultiple),
      label: Text(
        translate('app.fav.button_random'),
        key: Key('app.fav.button_random.$idTv'),
      ),
      onPressed: () async {
        Navigator.pushNamed<LoadingView>(
          context,
          RoutePaths.loading,
          arguments: idTv,
        );
      },
    );
  }
}
