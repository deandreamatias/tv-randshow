import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import 'package:tv_randshow/src/models/loading_model.dart';
import 'package:tv_randshow/src/data/tvshow_details.dart';
import 'package:tv_randshow/src/data/tvshow_result.dart';
import 'package:tv_randshow/src/ui/views/app_view.dart';
import 'package:tv_randshow/src/ui/views/base_view.dart';
import 'package:tv_randshow/src/ui/views/loading_view.dart';
import 'package:tv_randshow/src/ui/widgets/info_box_widget.dart';
import 'package:tv_randshow/src/utils/styles.dart';
import 'package:tv_randshow/src/utils/unicons_icons.dart';

class ResultView extends StatefulWidget {
  const ResultView({Key key, this.tvshowDetails, this.tvshowResult})
      : super(key: key);
  final TvshowDetails tvshowDetails;
  final TvshowResult tvshowResult;

  @override
  _ResultViewState createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<LoadingModel>(
        onModelReady: (LoadingModel model) {},
        builder: (BuildContext context, Widget child, LoadingModel model) {
          return Scaffold(
            body: SafeArea(
                child: Padding(
              padding: DEFAULT_INSESTS,
              child: Column(
                children: <Widget>[
                  _renderHeader(),
                  _renderBody(),
                  _renderFooter()
                ],
              ),
            )),
          );
        });
  }

  Widget _renderHeader() {
    return Expanded(
      flex: 1,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          child: Text(FlutterI18n.translate(context, 'app.result.title')),
        ),
      ),
    );
  }

  Widget _renderBody() {
    return Expanded(
      flex: 6,
      child: Stack(
          overflow: Overflow.visible,
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              padding: DEFAULT_INSESTS,
              decoration: BoxDecoration(
                  borderRadius: BORDER_RADIUS, border: Border.all()),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(
                      fit: FlexFit.loose,
                      flex: 1,
                      child: Text(widget.tvshowResult.tvshowDetails.name)),
                  Flexible(
                    fit: FlexFit.loose,
                    flex: 2,
                    child: Row(
                      children: <Widget>[
                        InfoBoxWidget(
                            typeInfo: 3,
                            value: widget.tvshowResult.randomSeason),
                        InfoBoxWidget(
                            typeInfo: 4,
                            value: widget.tvshowResult.randomEpisode),
                      ],
                    ),
                  ),
                  Flexible(
                      fit: FlexFit.loose,
                      flex: 1,
                      child: Text(widget.tvshowResult.episodeName,
                          textAlign: TextAlign.left)),
                  Flexible(
                      fit: FlexFit.tight,
                      flex: 3,
                      child: SingleChildScrollView(
                        child: Text(widget.tvshowResult.episodeDescription,
                            textAlign: TextAlign.left),
                      )),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: RaisedButton.icon(
                icon:
                    const Icon(Unicons.dice_multiple, color: StyleColor.WHITE),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                color: StyleColor.PRIMARY,
                label: Text(
                    FlutterI18n.translate(context, 'app.result.button_random'),
                    style: const TextStyle(color: StyleColor.WHITE)),
                onPressed: () => Navigator.push<LoadingView>(
                    context,
                    MaterialPageRoute<LoadingView>(
                      builder: (BuildContext context) =>
                          LoadingView(tvshowDetails: widget.tvshowDetails),
                    )),
              ),
            )
          ]),
    );
  }

  Widget _renderFooter() {
    return Container(
      padding: const EdgeInsets.only(top: 16.0),
      child: FlatButton.icon(
        label: Text(FlutterI18n.translate(context, 'app.result.button_home')),
        icon: const Icon(Unicons.home),
        onPressed: () => Navigator.push<AppView>(
            context,
            MaterialPageRoute<AppView>(
              builder: (BuildContext context) => const AppView(),
            )),
      ),
    );
  }
}
