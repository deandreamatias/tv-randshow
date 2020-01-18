import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import '../../data/tvshow_details.dart';
import '../../data/tvshow_result.dart';
import '../../models/loading_model.dart';
import '../../utils/styles.dart';
import '../../utils/unicons_icons.dart';
import '../widgets/info_box_widget.dart';
import '../widgets/text_widget.dart';
import 'app_view.dart';
import 'base_view.dart';
import 'loading_view.dart';

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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const TextWidget('app.result.title'),
                  const SizedBox(height: 8),
                  _renderBody(),
                  _renderFooter()
                ],
              ),
            )),
          );
        });
  }

  Widget _renderBody() {
    return Expanded(
      child: Stack(
          overflow: Overflow.visible,
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              right: 0.0,
              left: 0.0,
              top: 0.0,
              bottom: 36.0,
              child: Container(
                padding: DEFAULT_INSESTS,
                decoration: BoxDecoration(
                    borderRadius: BORDER_RADIUS, border: Border.all()),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      widget.tvshowResult.tvshowDetails.name,
                      style: StyleText.TITLE,
                    ),
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
                    Text(widget.tvshowResult.episodeName,
                        style: StyleText.MESSAGES),
                    const SizedBox(height: 8),
                    Flexible(
                        fit: FlexFit.loose,
                        flex: 3,
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Text(widget.tvshowResult.episodeDescription),
                        )),
                  ],
                ),
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
                    style: StyleText.WHITE),
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
        onPressed: () => Navigator.pushAndRemoveUntil<AppView>(
            context,
            MaterialPageRoute<AppView>(
              builder: (BuildContext context) => const AppView(),
            ),
            ModalRoute.withName('/')),
      ),
    );
  }
}
