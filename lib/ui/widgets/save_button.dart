import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:stacked/stacked.dart';
import 'package:unicons/unicons.dart';

import '../../core/viewmodels/widgets/save_model.dart';

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
                icon: const Icon(UniconsLine.times),
                label: Text(
                  translate('app.search.button_delete'),
                  key: Key('app.search.button_delete.$id'),
                ),
                onPressed: () => model.deleteFav(id),
              )
            : RaisedButton.icon(
                key: const ValueKey<String>('add'),
                icon: const Icon(UniconsLine.favorite),
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
