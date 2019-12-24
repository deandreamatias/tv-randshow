import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:tv_randshow/src/data/tvshow_result.dart';
import 'package:flare_loading/flare_loading.dart';

import 'package:tv_randshow/src/models/loading_model.dart';
import 'package:tv_randshow/src/data/tvshow_details.dart';
import 'package:tv_randshow/src/ui/widgets/text_widget.dart';
import 'package:tv_randshow/src/utils/constants.dart';
import 'package:tv_randshow/src/utils/states.dart';
import 'package:tv_randshow/src/utils/unicons_icons.dart';

import 'app_view.dart';
import 'base_view.dart';
import 'result_view.dart';

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
        } else if (model.state == ViewState.error) {
          // TODO(deandreamatias): Show message error
          Navigator.push<AppView>(
              context,
              MaterialPageRoute<AppView>(
                builder: (BuildContext context) => const AppView(),
              ));
        }
      });
    }, builder: (BuildContext context, Widget child, LoadingModel model) {
      return Scaffold(
        body: SafeArea(
            child: Column(
          children: <Widget>[
            const TextWidget('app.loading.title'),
            Expanded(
              child: FlareLoading(
                name: Images.LOADING,
                startAnimation: 'Loading',
                loopAnimation: 'Loading',
                onSuccess: (dynamic _) {},
                onError: (dynamic err, dynamic stack) {},
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 16.0),
              child: FlatButton.icon(
                label: Text(
                    FlutterI18n.translate(context, 'app.loading.button_home')),
                icon: const Icon(Unicons.home),
                onPressed: () => Navigator.push<AppView>(
                    context,
                    MaterialPageRoute<AppView>(
                      builder: (BuildContext context) => const AppView(),
                    )),
              ),
            )
          ],
        )),
      );
    });
  }
}
