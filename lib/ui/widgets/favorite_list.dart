import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';

import '../../core/viewmodels/widgets/favorite_list_model.dart';
import '../base_widget.dart';
import '../shared/styles.dart';
import 'fav_widget.dart';

class FavoriteList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<FavoriteListModel>(
      model: FavoriteListModel(databaseService: Provider.of(context)),
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
                          style: StyleText.MESSAGES,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : Container(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                        ),
                        physics: const BouncingScrollPhysics(),
                        padding: DEFAULT_INSESTS,
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
