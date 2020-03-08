import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:provider/provider.dart';

import '../../core/viewmodels/widgets/delete_model.dart';
import '../../core/viewmodels/widgets/favorite_list_model.dart';
import '../base_widget.dart';
import '../shared/styles.dart';
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
              print(idRow);
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
            color: StyleColor.WHITE,
            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
            border: Border.all(),
          ),
          child: const Icon(
            Unicons.times,
            size: 16.0,
            color: StyleColor.PRIMARY,
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          title:
              Text(FlutterI18n.translate(context, 'app.delete_dialog.title')),
          content: Text(
              FlutterI18n.translate(context, 'app.delete_dialog.subtitle')),
          actions: <Widget>[
            FlatButton(
              textColor: StyleColor.PRIMARY,
              color: StyleColor.WHITE,
              child: Text(FlutterI18n.translate(
                  context, 'app.delete_dialog.button_cancel')),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: const BorderSide(color: StyleColor.PRIMARY)),
                textColor: StyleColor.PRIMARY,
                color: StyleColor.WHITE,
                child: Text(FlutterI18n.translate(
                    context, 'app.delete_dialog.button_delete')),
                onPressed: () {
                  Navigator.of(context).pop(true);
                })
          ],
        );
      },
    );
  }
}
