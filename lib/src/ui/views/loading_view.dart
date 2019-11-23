import 'package:flutter/material.dart';

import 'package:tv_randshow/src/models/loading_model.dart';
import 'package:tv_randshow/src/data/tvshow_details.dart';
import 'package:tv_randshow/src/ui/views/base_view.dart';
import 'package:tv_randshow/src/utils/states.dart';

class LoadingView extends StatefulWidget {
  final TvshowDetails tvshowDetails;
  LoadingView({Key key, this.tvshowDetails}) : super(key: key);

  _LoadingViewState createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<LoadingModel>(onModelReady: (model) {
      model.getEpisode(widget.tvshowDetails).then((empty) {
        if (model.state == ViewState.init) {
          print('Init');
        }
      });
    }, builder: (context, child, model) {
      return Scaffold(
        body: SafeArea(
            child: Center(
          child: CircularProgressIndicator(),
        )),
      );
    });
  }
}
