import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';

import '../../core/viewmodels/widgets/save_model.dart';
import '../base_widget.dart';
import '../shared/unicons_icons.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({Key key, this.id}) : super(key: key);
  final int id;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<SaveModel>(
      model: SaveModel(
        apiService: Provider.of(context),
        databaseService: Provider.of(context),
      ),
      builder: (BuildContext context, SaveModel model, Widget child) =>
          AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: model.tvshowInDb
            ? RaisedButton.icon(
                key: const ValueKey<String>('delete'),
                icon: const Icon(Unicons.times),
                label: Text(translate('app.search.button_delete')),
                color: Theme.of(context).colorScheme.secondary,
                onPressed: () => model.deleteFav(id),
                textColor: Theme.of(context).colorScheme.primary,
              )
            : RaisedButton.icon(
                key: const ValueKey<String>('add'),
                icon: const Icon(Unicons.favorite),
                label: Text(translate('app.search.button_fav')),
                color: Theme.of(context).colorScheme.secondary,
                textColor: Theme.of(context).colorScheme.primary,
                onPressed: () => model.addFav(
                  id,
                  LocalizedApp.of(context)
                      .delegate
                      .currentLocale
                      .languageCode
                      .toString(),
                ),
              ),
      ),
    );
  }
}
