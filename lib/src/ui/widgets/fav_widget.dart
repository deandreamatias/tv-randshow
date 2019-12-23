import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:tv_randshow/src/models/fav_model.dart';
import 'package:tv_randshow/src/data/tvshow_details.dart';
import 'package:tv_randshow/src/ui/widgets/image_widget.dart';
import 'package:tv_randshow/src/ui/widgets/modal_sheet_widget.dart';
import 'package:tv_randshow/src/ui/widgets/random_button_widget.dart';
import 'package:tv_randshow/src/utils/styles.dart';
import 'package:tv_randshow/src/utils/unicons_icons.dart';

class FavWidget extends StatelessWidget {
  const FavWidget({Key key, @required this.tvshowDetails}) : super(key: key);
  final TvshowDetails tvshowDetails;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(borderRadius: BORDER_RADIUS),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            right: 8.0,
            left: 8.0,
            top: 8.0,
            bottom: 24.0,
            child: _image(context),
          ),
          Align(
            alignment: Alignment.topRight,
            child: _deleteButton(context),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: RandomButtonWidget(tvshowDetails: tvshowDetails),
          ),
        ],
      ),
    );
  }

  Widget _image(BuildContext context) {
    return GestureDetector(
        onTap: () => _showModalSheet(context),
        child: ImageWidget(
            name: tvshowDetails.name,
            url: tvshowDetails.posterPath,
            isModal: false));
  }

  Widget _deleteButton(BuildContext context) {
    return GestureDetector(
      onTap: () => _deleteConfirm(context).then((bool result) {
        if (result) {
          ScopedModel.of<FavModel>(context).deleteFav(tvshowDetails.rowId);
          ScopedModel.of<FavModel>(context).getFavs();
        }
      }),
      child: Container(
        height: 20.0,
        width: 20.0,
        decoration: BoxDecoration(
          color: StyleColor.WHITE,
          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
          border: Border.all(),
        ),
        child: Icon(
          Unicons.close,
          size: 12.0,
          color: StyleColor.PRIMARY,
        ),
      ),
    );
  }

  Future<bool> _deleteConfirm(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title:
              Text(FlutterI18n.translate(context, 'app.delete_dialog.title')),
          content: Text(
              FlutterI18n.translate(context, 'app.delete_dialog.subtitle')),
          actions: <Widget>[
            RaisedButton(
              textColor: StyleColor.WHITE,
              color: StyleColor.PRIMARY,
              child: Text(FlutterI18n.translate(
                  context, 'app.delete_dialog.button_cancel')),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            FlatButton(
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

  void _showModalSheet(BuildContext context) {
    showModalBottomSheet<Container>(
        isScrollControlled: true,
        elevation: 16.0,
        shape: const RoundedRectangleBorder(
          borderRadius:
              BorderRadiusDirectional.vertical(top: Radius.circular(16.0)),
        ),
        context: context,
        builder: (BuildContext builder) {
          return Container(
              height: 400,
              child: MenuPanelWidget(
                tvshowDetails: tvshowDetails,
                inDatabase: true,
              ));
        });
  }
}
