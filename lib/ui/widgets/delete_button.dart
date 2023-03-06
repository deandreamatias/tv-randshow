import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:stacked/stacked.dart';
import 'package:tv_randshow/ui/viewmodels/widgets/delete_model.dart';
import 'package:unicons/unicons.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({
    super.key,
    required this.id,
  });
  final int id;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DeleteModel>.reactive(
      viewModelBuilder: () => DeleteModel(),
      builder: (BuildContext context, DeleteModel model, Widget? child) =>
          InkWell(
        key: Key('delete:${id.toString()}'),
        onTap: () async {
          final bool result = await _deleteConfirm(context);
          if (result) await model.deleteFav(id);
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
            UniconsLine.times,
            size: 16.0,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }

  Future<bool> _deleteConfirm(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                translate('app.delete_dialog.title'),
                key: const Key('app.delete_dialog.title'),
              ),
              content: Text(
                translate('app.delete_dialog.subtitle'),
                key: const Key('app.delete_dialog.subtitle'),
              ),
              actions: <Widget>[
                TextButton(
                  key: const Key('app.delete_dialog.button_cancel'),
                  child: Text(translate('app.delete_dialog.button_cancel')),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                OutlinedButton(
                  key: const Key('app.delete_dialog.button_delete'),
                  child: Text(translate('app.delete_dialog.button_delete')),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                )
              ],
            );
          },
        ) ??
        false;
  }
}
