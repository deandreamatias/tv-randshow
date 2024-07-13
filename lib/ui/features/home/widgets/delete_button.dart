import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:tv_randshow/ui/shared/styles.dart';
import 'package:tv_randshow/ui/states/tvshow_state.dart';
import 'package:unicons/unicons.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({
    super.key,
    required this.idTv,
  });
  final int idTv;

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
                ),
              ],
            );
          },
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Consumer(
      child: SizedBox.square(
        dimension: 20,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
            border:
                Border.fromBorderSide(BorderSide(color: colorScheme.primary)),
          ),
          child: Icon(
            UniconsLine.times,
            size: Styles.standard,
            color: colorScheme.primary,
          ),
        ),
      ),
      builder: (context, ref, child) {
        return InkWell(
          key: Key('delete:${idTv.toString()}'),
          onTap: () {
            // Special use case when combine dialog route with state function.
            // ignore: prefer-async-await
            _deleteConfirm(context).then((result) {
              if (result) {
                ref.watch(tvshowOnFavsProvider(idTv).notifier).deleteFromFavs();
              }
            });
          },
          child: child,
        );
      },
    );
  }
}
