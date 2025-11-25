import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tv_randshow/ui/features/random/views/loading_tvshow_view.dart';
import 'package:tv_randshow/ui/router.dart';
import 'package:tv_randshow/ui/shared/custom_icons.dart';

class RandomButton extends StatelessWidget {
  const RandomButton({super.key, required this.idTv});
  final int idTv;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(CustomIcons.diceMultiple),
      label: Text(
        context.tr('app.fav.button_random'),
        key: Key('app.fav.button_random.$idTv'),
      ),
      onPressed:
          () => Navigator.pushNamed<LoadingTvshowView>(
            context,
            RoutePaths.loadingTvshow,
            arguments: idTv,
          ),
    );
  }
}
