import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import '../../core/models/tvshow_details.dart';
import '../shared/styles.dart';
import '../shared/unicons_icons.dart';

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
      onPressed: () => Navigator.push<LoadingView>(
        context,
        MaterialPageRoute<LoadingView>(
          builder: (BuildContext context) =>
              LoadingView(_tvshowDetails: tvshowDetails),
        ),
      ),
    );
  }
}
