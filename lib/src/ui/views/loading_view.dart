import 'package:flutter/material.dart';
import 'package:tv_randshow/src/data/tvshow_result.dart';

import 'package:tv_randshow/src/models/loading_model.dart';
import 'package:tv_randshow/src/data/tvshow_details.dart';
import 'package:tv_randshow/src/ui/views/base_view.dart';
import 'package:tv_randshow/src/ui/views/result_view.dart';
import 'package:tv_randshow/src/utils/states.dart';

class LoadingView extends StatefulWidget {
  const LoadingView({Key key, this.tvshowDetails}) : super(key: key);
  final TvshowDetails tvshowDetails;

  @override
  _LoadingViewState createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<LoadingModel>(onModelReady: (LoadingModel model) {
      model.getEpisode(widget.tvshowDetails).then((TvshowResult tvshowResult) {
        if (model.state == ViewState.init) {
          Navigator.push<ResultView>(
              context,
              MaterialPageRoute<ResultView>(
                builder: (BuildContext context) => ResultView(
                    tvshowResult: tvshowResult,
                    tvshowDetails: widget.tvshowDetails),
              ));
        }
      });
    }, builder: (BuildContext context, Widget child, LoadingModel model) {
      return const Scaffold(
        body: SafeArea(
            child: Center(
          child: CircularProgressIndicator(),
        )),
      );
    });
  }
}
