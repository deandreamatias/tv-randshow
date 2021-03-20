import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:stacked/stacked.dart';

import '../../core/models/tvshow_details.dart';
import '../../core/utils/constants.dart';
import '../../core/viewmodels/widgets/random_model.dart';
import '../shared/custom_icons.dart';
import '../views/loading_view.dart';

class RandomButton extends StatelessWidget {
  const RandomButton({Key key, this.tvshowDetails, this.id}) : super(key: key);
  final TvshowDetails tvshowDetails;
  final int id;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RandomModel>.nonReactive(
      viewModelBuilder: () => RandomModel(),
      builder: (BuildContext context, RandomModel model, Widget child) =>
          ElevatedButton.icon(
        icon: const Icon(CustomIcons.dice_multiple),
        label: Text(
          translate('app.fav.button_random'),
          key: Key('app.fav.button_random.${tvshowDetails?.id ?? id}'),
        ),
        onPressed: () async {
          if (tvshowDetails == null) {
            await model.getDetails(
              id,
              LocalizedApp.of(context)
                  .delegate
                  .currentLocale
                  .languageCode
                  .toString(),
            );
          }
          Navigator.pushNamed<LoadingView>(
            context,
            RoutePaths.LOADING,
            arguments: tvshowDetails ?? model.tvshowDetails,
          );
        },
      ),
    );
  }
}
