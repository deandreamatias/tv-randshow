import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:stacked/stacked.dart';
import 'package:tv_randshow/core/models/tvshow_details.dart';
import 'package:tv_randshow/core/utils/constants.dart';
import 'package:tv_randshow/core/viewmodels/views/loading_view_model.dart';
import 'package:tv_randshow/ui/views/result_view.dart';
import 'package:tv_randshow/ui/widgets/home_button.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key, required this.tvshowDetails});
  final TvshowDetails tvshowDetails;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoadingViewModel>.nonReactive(
      viewModelBuilder: () => LoadingViewModel(),
      onViewModelReady: (LoadingViewModel model) async {
        await model
            .sortRandomEpisode(
          tvshowDetails,
          LocalizedApp.of(context)
              .delegate
              .currentLocale
              .languageCode
              .toString(),
        )
            .then((value) {
          if (model.canNavigate) {
            Navigator.pushNamedAndRemoveUntil<ResultView>(
              context,
              RoutePaths.result,
              ModalRoute.withName(RoutePaths.tab),
              arguments: model.tvshowResult,
            );
          }
        });
      },
      builder: (BuildContext context, LoadingViewModel model, Widget? child) {
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
                        key: const Key('app.loading.title'),
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: !model.isBusy && !model.canNavigate
                          ? Center(
                              child: Text(
                                translate('app.loading.general_error'),
                                style: Theme.of(context).textTheme.titleMedium,
                                textAlign: TextAlign.center,
                              ),
                            )
                          : const FlareActor(
                              Assets.loading,
                              animation: 'Loading',
                            ),
                    ),
                    const HomeButton(text: 'app.loading.button_fav')
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
