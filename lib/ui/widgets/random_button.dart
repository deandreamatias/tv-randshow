import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:stacked/stacked.dart';

import 'package:tv_randshow/core/models/tvshow_details.dart';
import 'package:tv_randshow/core/utils/constants.dart';
import 'package:tv_randshow/core/viewmodels/widgets/random_model.dart';
import 'package:tv_randshow/ui/shared/custom_icons.dart';
import 'package:tv_randshow/ui/views/loading_view.dart';

class RandomButton extends StatelessWidget {
  const RandomButton({
    super.key,
    required this.tvshowDetails,
  });
  final TvshowDetails tvshowDetails;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RandomModel>.nonReactive(
      viewModelBuilder: () => RandomModel(),
      builder: (BuildContext context, RandomModel model, Widget? child) =>
          ElevatedButton.icon(
        icon: const Icon(CustomIcons.diceMultiple),
        label: Text(
          translate('app.fav.button_random'),
          key: Key('app.fav.button_random.${tvshowDetails.id}'),
        ),
        onPressed: () async {
          Navigator.pushNamed<LoadingView>(
            context,
            RoutePaths.loading,
            arguments: tvshowDetails,
          );
        },
      ),
    );
  }
}
