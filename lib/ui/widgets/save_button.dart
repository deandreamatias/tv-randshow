import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:provider/provider.dart';

import '../../core/viewmodels/widgets/save_model.dart';
import '../base_widget.dart';
import '../shared/styles.dart';
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
        secureStorageService: Provider.of(context),
      ),
      onModelReady: (SaveModel model) {
        model.getDatabaseInfo(id);
      },
      builder: (BuildContext context, SaveModel model, Widget child) =>
          AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: model.tvshowInDb
            ? RaisedButton.icon(
                key: const ValueKey<String>('add'),
                icon: const Icon(
                  Unicons.favourite,
                  color: StyleColor.PRIMARY,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: const BorderSide(color: StyleColor.PRIMARY)),
                color: StyleColor.WHITE,
                label: Text(
                    FlutterI18n.translate(context, 'app.search.button_fav'),
                    style: StyleText.PRIMARY),
                onPressed: () => model.addFav(
                  id,
                  FlutterI18n.currentLocale(context).languageCode.toString(),
                ),
              )
            : RaisedButton.icon(
                key: const ValueKey<String>('delete'),
                icon: const Icon(
                  Unicons.close,
                  color: StyleColor.PRIMARY,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: const BorderSide(color: StyleColor.PRIMARY)),
                color: StyleColor.WHITE,
                label: Text(
                    FlutterI18n.translate(context, 'app.search.button_delete'),
                    style: StyleText.PRIMARY),
                onPressed: () => model.deleteFav(id),
              ),
      ),
    );
  }
}
