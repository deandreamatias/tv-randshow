import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:tv_randshow/src/models/fav_model.dart';
import 'package:tv_randshow/src/data/tvshow_details.dart';
import 'package:tv_randshow/src/ui/widgets/image_widget.dart';
import 'package:tv_randshow/src/ui/widgets/menu_details_widget.dart';
import 'package:tv_randshow/src/ui/widgets/random_button_widget.dart';
import 'package:tv_randshow/src/utils/styles.dart';
import 'package:tv_randshow/src/utils/unicons_icons.dart';

class FavWidget extends StatelessWidget {
  const FavWidget({Key key, @required this.tvshowDetails}) : super(key: key);
  final TvshowDetails tvshowDetails;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, left: 8.0),
      child: Container(
        height: 154.0,
        width: 144.0,
        decoration: BoxDecoration(borderRadius: BORDER_RADIUS),
        child: Stack(
          children: <Widget>[
            Positioned(
              right: 6.0,
              left: 0.0,
              top: 6.0,
              bottom: 18.0,
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
          title: const Text('Delete Tv show'),
          content: const Text('Do you want delete this tv show?'),
          actions: <Widget>[
            RaisedButton(
              textColor: StyleColor.WHITE,
              color: StyleColor.PRIMARY,
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            FlatButton(
                child: const Text('DELETE'),
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
