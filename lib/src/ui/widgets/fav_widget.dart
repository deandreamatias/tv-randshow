import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:tv_randshow/src/models/fav_model.dart';
import 'package:tv_randshow/src/data/tvshow_details.dart';
import 'package:tv_randshow/src/ui/views/loading_view.dart';
import 'package:tv_randshow/src/ui/widgets/menu_details_widget.dart';
import 'package:tv_randshow/src/utils/constants.dart';
import 'package:tv_randshow/src/utils/styles.dart';
import 'package:tv_randshow/src/utils/unicons_icons.dart';

class FavWidget extends StatelessWidget {
  final TvshowDetails tvshowDetails;
  FavWidget({Key key, @required this.tvshowDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 8.0, left: 8.0),
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
              child: _actionButton(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _image(BuildContext context) {
    return GestureDetector(
      onTap: () => _showModalSheet(context),
      child: Container(
        height: 128.0,
        width: 144.0,
        child: Align(
          alignment: Alignment.topLeft,
          child: Container(
            padding: SMALL_INSESTS,
            decoration: BoxDecoration(
                borderRadius: BORDER_RADIUS, color: Colors.black38),
            child: Text(
              tvshowDetails.name,
              style: TextStyle(
                  color: StyleColor.WHITE, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BORDER_RADIUS,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: checkImage(),
          ),
        ),
      ),
    );
  }

  void _showModalSheet(BuildContext context) {
    showModalBottomSheet<Container>(
        isScrollControlled: true,
        elevation: 16.0,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadiusDirectional.vertical(top: Radius.circular(16.0)),
        ),
        context: context,
        builder: (builder) {
          return Container(
              height: 400, child: MenuPanelWidget(tvshowDetails, true));
        });
  }

  ImageProvider checkImage() {
    if (tvshowDetails.posterPath == null) {
      return AssetImage(ImagePath.emptyTvShow);
    } else {
      return NetworkImage(Url.BASE_IMAGE + tvshowDetails.posterPath);
    }
  }

  Widget _deleteButton(BuildContext context) {
    return GestureDetector(
      onTap: () => _deleteConfirm(context).then((result) {
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
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
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
          title: Text('Delete Tv show'),
          content: Text('Do you want delete this tv show?'),
          actions: <Widget>[
            RaisedButton(
              textColor: StyleColor.WHITE,
              color: StyleColor.PRIMARY,
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            FlatButton(
                child: Text('DELETE'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                })
          ],
        );
      },
    );
  }

  Widget _actionButton(BuildContext context) {
    return RaisedButton.icon(
      icon: Icon(Unicons.dice_multiple, color: StyleColor.WHITE),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      color: StyleColor.PRIMARY,
      label: Text('Random', style: TextStyle(color: StyleColor.WHITE)),
      onPressed: () => navigateRandom(context),
    );
  }

  void navigateRandom(BuildContext context) {
    Navigator.push<LoadingView>(
        context,
        MaterialPageRoute(
          builder: (context) => LoadingView(tvshowDetails: tvshowDetails),
        ));
  }
}
