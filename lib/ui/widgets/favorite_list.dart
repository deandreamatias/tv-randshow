import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../core/viewmodels/widgets/favorite_list_model.dart';
import '../base_widget.dart';
import 'fav_widget.dart';

class FavoriteList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<FavoriteListModel>(
      model: FavoriteListModel(),
      onModelReady: (FavoriteListModel model) {
        model.loadFavs();
      },
      builder: (BuildContext context, FavoriteListModel model, Widget child) =>
          model.busy
              ? const Center(child: CircularProgressIndicator())
              : model.listFavs.isEmpty || model.listFavs == null
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          translate('app.fav.empty_message'),
                          style: Theme.of(context).textTheme.subtitle1,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : Container(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 180.0,
                          childAspectRatio: 0.8,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                        ),
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.all(16.0),
                        itemCount: model.listFavs.length,
                        itemBuilder: (BuildContext context, int index) =>
                            FavWidget(
                          key: Key(model.listFavs[index].id.toString()),
                          tvshowDetails: model.listFavs[index],
                        ),
                      ),
                    ),
    );
  }
}
