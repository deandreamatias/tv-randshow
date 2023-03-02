import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:stacked/stacked.dart';

import 'package:tv_randshow/core/viewmodels/widgets/favorite_list_model.dart';
import 'package:tv_randshow/ui/router.dart';
import 'package:tv_randshow/ui/views/loading_view.dart';
import 'package:tv_randshow/ui/widgets/fav_widget.dart';

class FavoriteList extends StatelessWidget {
  const FavoriteList({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FavoriteListModel>.reactive(
      viewModelBuilder: () => FavoriteListModel(),
      onViewModelReady: (FavoriteListModel model) async {
        await model.getFavs();
        await model.verifyAppLink().then((tvshowDetails) {
          if (tvshowDetails?.id != null) {
            Navigator.pushNamed<LoadingView>(
              context,
              RoutePaths.loading,
              arguments: tvshowDetails,
            );
          }
        });
      },
      builder: (BuildContext context, FavoriteListModel model, Widget? child) =>
          model.isBusy
              ? const Center(
                  child: CircularProgressIndicator(
                    key: Key('app.fav.loading'),
                  ),
                )
              : model.data != null && model.data!.isNotEmpty
                  ? GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 180.0,
                        childAspectRatio: 0.8,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                      ),
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(16.0),
                      itemCount: model.data!.length,
                      itemBuilder: (BuildContext context, int index) =>
                          FavWidget(
                        key: Key(model.data![index].id.toString()),
                        tvshowDetails: model.data![index],
                      ),
                    )
                  : Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          translate('app.fav.empty_message'),
                          key: const Key('app.fav.empty_message'),
                          style: Theme.of(context).textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
    );
  }
}
