import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:stacked/stacked.dart';

import '../../core/viewmodels/widgets/favorite_list_model.dart';
import 'fav_widget.dart';

class FavoriteList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FavoriteListModel>.reactive(
      viewModelBuilder: () => FavoriteListModel(),
      onModelReady: (FavoriteListModel model) async => await model.getFavs(),
      builder: (BuildContext context, FavoriteListModel model, Widget child) =>
          model.isBusy
              ? const Center(child: CircularProgressIndicator())
              : model.data != null && model.data.isNotEmpty
                  ? Container(
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
                        itemCount: model.data.length,
                        itemBuilder: (BuildContext context, int index) =>
                            FavWidget(
                          key: Key(model.data[index].id.toString()),
                          tvshowDetails: model.data[index],
                        ),
                      ),
                    )
                  : Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          translate('app.fav.empty_message'),
                          style: Theme.of(context).textTheme.subtitle1,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
    );
  }
}
