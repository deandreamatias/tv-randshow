import 'package:flutter/material.dart';

import 'package:tv_randshow/src/data/tvshow_details.dart';
import 'package:tv_randshow/src/ui/views/loading_view.dart';
import 'package:tv_randshow/src/utils/styles.dart';
import 'package:tv_randshow/src/utils/unicons_icons.dart';

class RandomButtonWidget extends StatelessWidget {
  const RandomButtonWidget({Key key, this.tvshowDetails}) : super(key: key);
  final TvshowDetails tvshowDetails;

  @override
  Widget build(BuildContext context) {
    return RaisedButton.icon(
      icon: const Icon(Unicons.dice_multiple, color: StyleColor.WHITE),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      color: StyleColor.PRIMARY,
      label: const Text('Random', style: TextStyle(color: StyleColor.WHITE)),
      onPressed: () => Navigator.push<LoadingView>(
          context,
          MaterialPageRoute<LoadingView>(
            builder: (BuildContext context) =>
                LoadingView(tvshowDetails: tvshowDetails),
          )),
    );
  }
}
