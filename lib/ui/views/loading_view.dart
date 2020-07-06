import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../core/models/tvshow_details.dart';
import '../../core/utils/constants.dart';
import '../../core/viewmodels/views/loading_view_model.dart';
import '../base_widget.dart';
import '../widgets/home_button.dart';
import 'result_view.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({Key key, this.tvshowDetails}) : super(key: key);
  final TvshowDetails tvshowDetails;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<LoadingViewModel>(
      model: LoadingViewModel(),
      onModelReady: (LoadingViewModel model) async {
        await model.sortRandomEpisode(
          tvshowDetails,
          LocalizedApp.of(context)
              .delegate
              .currentLocale
              .languageCode
              .toString(),
        );
        if (model.canNavigate) {
          Navigator.pushNamedAndRemoveUntil<ResultView>(
            context,
            RoutePaths.RESULT,
            ModalRoute.withName(RoutePaths.TAB),
            arguments: model.tvshowResult,
          );
        }
      },
      builder: (BuildContext context, LoadingViewModel model, Widget child) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        translate('app.loading.title'),
                        style: Theme.of(context).textTheme.headline6,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: !model.busy && !model.canNavigate
                          ? Center(
                              child: Text(
                                translate('app.loading.general_error'),
                                style: Theme.of(context).textTheme.subtitle1,
                                textAlign: TextAlign.center,
                              ),
                            )
                          : const FlareActor(
                              Assets.LOADING,
                              animation: 'Loading',
                            ),
                    ),
                    const HomeButton()
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
