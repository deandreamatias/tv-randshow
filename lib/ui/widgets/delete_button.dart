import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';

import '../../core/viewmodels/widgets/delete_model.dart';
import '../../core/viewmodels/widgets/favorite_list_model.dart';
import '../base_widget.dart';
import '../shared/unicons_icons.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({
    Key key,
    @required this.idRow,
  }) : super(key: key);
  final int idRow;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<DeleteModel>(
      model: DeleteModel(databaseService: Provider.of(context)),
      builder: (BuildContext context, DeleteModel model, Widget child) =>
          GestureDetector(
        onTap: () => _deleteConfirm(context).then(
          (bool result) async {
            if (result) {
              await model.deleteFav(idRow);
              Provider.of<FavoriteListModel>(context, listen: false)
                  .deleteFav(idRow);
            }
          },
        ),
        child: Container(
          height: 20.0,
          width: 20.0,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
            border: Border.all(),
          ),
          child: Icon(
            Unicons.times,
            size: 16.0,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }

  Future<bool> _deleteConfirm(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(translate('app.delete_dialog.title')),
          content: Text(translate('app.delete_dialog.subtitle')),
          actions: <Widget>[
            FlatButton(
              child: Text(translate('app.delete_dialog.button_cancel')),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            OutlineButton(
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
              child: Text(translate('app.delete_dialog.button_delete')),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            )
          ],
        );
      },
    );
  }
}
