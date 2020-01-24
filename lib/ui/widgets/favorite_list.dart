import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/viewmodels/widgets/favorite_list_model.dart';
import '../base_widget.dart';
import '../shared/styles.dart';

class FavoriteList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<FavoriteListModel>(
      model: FavoriteListModel(databaseService: Provider.of(context)),
      onModelReady: (FavoriteListModel model) {
        model.getFavs();
      },
      builder: (BuildContext context, FavoriteListModel model, Widget child) =>
          SafeArea(
        child: Container(
          child: model.busy
              ? const Center(child: CircularProgressIndicator())
              : Expanded(
                  /// TODO: Implement [PagewiseGridView]
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    semanticChildCount: model.listTvShow.length,
                    padding: DEFAULT_INSESTS,
                    itemCount: model.listTvShow.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 8.0,
                            crossAxisSpacing: 8.0,
                            crossAxisCount: 2),
                    itemBuilder: (BuildContext context, int index) {
                      return model.listTvShow[index];
                    },
                  ),
                ),
        ),
      ),
    );
  }

  // if (model.listTvShow == null || model.listTvShow.isEmpty) {
  //   return const Center(
  //     child: TextWidget('app.fav.empty_message'),
  //   );

}
