import 'package:flutter/material.dart';

import 'package:tv_randshow/src/models/loading_model.dart';
import 'package:tv_randshow/src/data/tvshow_result.dart';
import 'package:tv_randshow/src/ui/views/app_view.dart';
import 'package:tv_randshow/src/ui/views/base_view.dart';
import 'package:tv_randshow/src/ui/widgets/info_box_widget.dart';
import 'package:tv_randshow/src/utils/styles.dart';

class ResultView extends StatefulWidget {
  final TvshowResult tvshowResult;
  ResultView({Key key, this.tvshowResult}) : super(key: key);

  _ResultViewState createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<LoadingModel>(
        onModelReady: (model) {},
        builder: (context, child, model) {
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
          child: Text('TV show random result!'),
        ),
      ),
    );
  }

  Widget _renderBody() {
    return Expanded(
      flex: 6,
      child: Stack(overflow: Overflow.visible, children: <Widget>[
        Container(
          padding: DEFAULT_INSESTS,
          decoration:
              BoxDecoration(borderRadius: BORDER_RADIUS, border: Border.all()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  flex: 1, child: Text(widget.tvshowResult.tvshowDetails.name)),
              Expanded(
                flex: 2,
                child: Row(
                  children: <Widget>[
                    InfoBoxWidget(
                        typeInfo: 3, value: widget.tvshowResult.randomSeason),
                    InfoBoxWidget(
                        typeInfo: 4, value: widget.tvshowResult.randomEpisode),
                  ],
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Text(widget.tvshowResult.episodeName,
                      textAlign: TextAlign.left)),
              Expanded(
                  flex: 3,
                  child: SingleChildScrollView(
                    child: Text(widget.tvshowResult.episodeDescription,
                        textAlign: TextAlign.left),
                  )),
            ],
          ),
        ),
        Positioned(
          left: 50.0,
          bottom: -18.0,
          child: RaisedButton.icon(
            icon: const Icon(Icons.local_play, color: StyleColor.WHITE),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            color: StyleColor.PRIMARY,
            label: const Text('Pick a new random episode',
                style: TextStyle(color: StyleColor.WHITE)),
            onPressed: () => {},
            // onPressed: () => Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => AppView(),
            //     )),
          ),
        )
      ]),
    );
  }

  Widget _renderFooter() {
    return Container(
      padding: EdgeInsets.only(top: 16.0),
      child: FlatButton.icon(
        label: const Text('Home'),
        icon: const Icon(Icons.home),
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AppView(),
            )),
      ),
    );
  }
}
