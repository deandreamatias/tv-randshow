import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:stacked/stacked.dart';

import '../../core/viewmodels/widgets/delete_model.dart';
import '../shared/unicons_icons.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({
    Key key,
    @required this.idRow,
  }) : super(key: key);
  final int idRow;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DeleteModel>.reactive(
      viewModelBuilder: () => DeleteModel(),
      builder: (BuildContext context, DeleteModel model, Widget child) =>
          InkWell(
        key: Key('delete:${idRow.toString()}'),
        onTap: () async {
          final bool result = await _deleteConfirm(context);
          if (result) await model.deleteFav(idRow);
        },
        child: Container(
          height: 20.0,
          width: 20.0,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
            border: Border.all(color: Theme.of(context).colorScheme.primary),
          ),
          child: Icon(
            Unicons.times,
            size: 16.0,
            color: Theme.of(context).accentColor,
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
          title: Text(
            translate('app.delete_dialog.title'),
            key: Key('app.delete_dialog.title'),
          ),
          content: Text(
            translate('app.delete_dialog.subtitle'),
            key: Key('app.delete_dialog.subtitle'),
          ),
          actions: <Widget>[
            FlatButton(
              key: Key('app.delete_dialog.button_cancel'),
              child: Text(translate('app.delete_dialog.button_cancel')),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            OutlineButton(
              key: Key('app.delete_dialog.button_delete'),
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
