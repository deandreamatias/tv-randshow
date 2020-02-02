import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import '../../core/models/tvshow_details.dart';
import '../../core/utils/constants.dart';
import '../shared/styles.dart';
import '../shared/unicons_icons.dart';
import '../views/loading_view.dart';

class RandomButton extends StatelessWidget {
  const RandomButton({Key key, this.tvshowDetails}) : super(key: key);
  final TvshowDetails tvshowDetails;

  @override
  Widget build(BuildContext context) {
    return RaisedButton.icon(
      icon: const Icon(Unicons.dice_multiple, color: StyleColor.WHITE),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      color: StyleColor.PRIMARY,
      label: Text(
        FlutterI18n.translate(context, 'app.fav.button_random'),
        style: StyleText.WHITE,
      ),
      onPressed: () => Navigator.pushNamed<LoadingView>(
        context,
        RoutePaths.LOADING,
        arguments: tvshowDetails,
      ),
    );
  }
}
