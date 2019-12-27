import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flare_loading/flare_loading.dart';

import '../../data/tvshow_details.dart';
import '../../data/tvshow_result.dart';
import '../../models/loading_model.dart';
import '../../utils/constants.dart';
import '../../utils/states.dart';
import '../../utils/styles.dart';
import '../../utils/unicons_icons.dart';
import '../widgets/text_widget.dart';
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
          Navigator.pushAndRemoveUntil<ResultView>(
              context,
              MaterialPageRoute<ResultView>(
                builder: (BuildContext context) => ResultView(
                    tvshowResult: tvshowResult,
                    tvshowDetails: widget.tvshowDetails),
              ),
              ModalRoute.withName('/'));
        } else if (model.state == ViewState.error) {
          if (model.hasConnection) {
            Flushbar<Object>(
              message:
                  FlutterI18n.translate(context, 'app.loading.general_error'),
              backgroundColor: StyleColor.PRIMARY,
              flushbarPosition: FlushbarPosition.TOP,
              duration: const Duration(seconds: 3),
            )..show(context);
          } else {
            Flushbar<Object>(
              message: FlutterI18n.translate(
                  context, 'app.loading.connection_error'),
              backgroundColor: StyleColor.PRIMARY,
              flushbarPosition: FlushbarPosition.TOP,
              flushbarStyle: FlushbarStyle.GROUNDED,
              isDismissible: false,
            )..show(context);
          }
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
                onPressed: () => Navigator.pushAndRemoveUntil<AppView>(
                  context,
                  MaterialPageRoute<AppView>(
                      builder: (BuildContext context) => const AppView()),
                  ModalRoute.withName('/'),
                ),
              ),
            )
          ],
        )),
      );
    });
  }
}
