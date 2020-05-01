import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';

import '../../core/models/tvshow_details.dart';
import '../../core/utils/constants.dart';
import '../../core/viewmodels/widgets/random_model.dart';
import '../base_widget.dart';
import '../shared/styles.dart';
import '../shared/unicons_icons.dart';
import '../views/loading_view.dart';

class RandomButton extends StatelessWidget {
  RandomButton({Key key, this.tvshowDetails, this.id}) : super(key: key);
  TvshowDetails tvshowDetails;
  final int id;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<RandomModel>(
      model: RandomModel(
        apiService: Provider.of(context),
        secureStorageService: Provider.of(context),
      ),
      builder: (BuildContext context, RandomModel model, Widget child) =>
          RaisedButton.icon(
        icon: const Icon(Unicons.dice_multiple, color: StyleColor.WHITE),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        color: StyleColor.PRIMARY,
        label: Text(
          translate('app.fav.button_random'),
          style: StyleText.WHITE,
        ),
        onPressed: () async {
          tvshowDetails ??= await model.getDetails(
            id,
            LocalizedApp.of(context)
                .delegate
                .currentLocale
                .languageCode
                .toString(),
          );
          Navigator.pushNamed<LoadingView>(
            context,
            RoutePaths.LOADING,
            arguments: tvshowDetails,
          );
        },
      ),
    );
  }
}
