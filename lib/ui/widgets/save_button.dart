import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:stacked/stacked.dart';

import '../../core/viewmodels/widgets/save_model.dart';
import '../shared/unicons_icons.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({Key key, this.id}) : super(key: key);
  final int id;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SaveModel>.reactive(
      viewModelBuilder: () => SaveModel(),
      builder: (BuildContext context, SaveModel model, Widget child) =>
          AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: model.tvshowInDb
            ? RaisedButton.icon(
                key: const ValueKey<String>('delete'),
                icon: const Icon(Unicons.times),
                label: Text(
                  translate('app.search.button_delete'),
                  key: Key('app.search.button_delete.$id'),
                ),
                onPressed: () => model.deleteFav(id),
              )
            : RaisedButton.icon(
                key: const ValueKey<String>('add'),
                icon: const Icon(Unicons.favorite),
                label: Text(
                  translate('app.search.button_fav'),
                  key: Key('app.search.button_fav.$id'),
                ),
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
