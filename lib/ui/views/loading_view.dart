import 'package:flutter/material.dart';
import 'package:flare_loading/flare_loading.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';

import '../../core/models/tvshow_details.dart';
import '../../core/models/tvshow_result.dart';
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
      model: LoadingViewModel(
        randomService: Provider.of(context),
      ),
      onModelReady: (LoadingViewModel model) {
        model
            .sortRandomEpisode(
          tvshowDetails,
          LocalizedApp.of(context).delegate.currentLocale.languageCode.toString(),
        )
            .then(
          (TvshowResult tvshowResult) {
            if (tvshowResult != null) {
              Navigator.pushNamedAndRemoveUntil<ResultView>(
                context,
                RoutePaths.RESULT,
                ModalRoute.withName(RoutePaths.TAB),
                arguments: tvshowResult,
              );
            }
            // TODO: Implement get error
          },
        );
      },
      builder: (BuildContext context, LoadingViewModel model, Widget child) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
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
                    child: FlareLoading(
                      name: Assets.LOADING,
                      startAnimation: 'Loading',
                      loopAnimation: 'Loading',
                      onSuccess: (dynamic _) {},
                      onError: (dynamic err, dynamic stack) {},
                    ),
                  ),
                  const HomeButton()
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
