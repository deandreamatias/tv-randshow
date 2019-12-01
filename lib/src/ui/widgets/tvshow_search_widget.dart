import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:tv_randshow/src/models/search_model.dart';
import 'package:tv_randshow/src/data/result.dart';
import 'package:tv_randshow/src/utils/constants.dart';
import 'package:tv_randshow/src/utils/styles.dart';
import 'package:tv_randshow/src/utils/unicons_icons.dart';

class TvshowSearchWidget extends StatefulWidget {
  final Result result;
  TvshowSearchWidget({Key key, this.result}) : super(key: key);

  @override
  _TvshowSearchWidgetState createState() => _TvshowSearchWidgetState();
}

class _TvshowSearchWidgetState extends State<TvshowSearchWidget> {
  bool changeButton;
  @override
  void initState() {
    changeButton =
        false; // TODO: Reset state to false when search twice in search view
    super.initState();
  }

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
              alignment: Alignment.bottomCenter,
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                child: !changeButton
                    ? _actionButton(context)
                    : _removeButton(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _image(BuildContext context) {
    return GestureDetector(
      onTap: () => ScopedModel.of<SearchModel>(context).toggleDetails(),
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
              widget.result.name,
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

  ImageProvider checkImage() {
    if (widget.result.posterPath == null) {
      return AssetImage(ImagePath.emptyTvShow);
    } else {
      return NetworkImage(Url.BASE_IMAGE + widget.result.posterPath);
    }
  }

  Widget _removeButton(BuildContext context) {
    return RaisedButton.icon(
      key: ValueKey('remove'),
      icon: Icon(Unicons.close, color: StyleColor.WHITE),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      color: StyleColor.PRIMARY,
      label: Text('Remove', style: TextStyle(color: StyleColor.WHITE)),
      onPressed: () {
        setState(() {
          changeButton = false;
        });
        ScopedModel.of<SearchModel>(context).deleteFav(widget.result.id);
      },
    );
  }

  Widget _actionButton(BuildContext context) {
    return RaisedButton.icon(
      key: ValueKey('action'),
      icon: Icon(Unicons.favourite, color: StyleColor.PRIMARY),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(color: StyleColor.PRIMARY)),
      color: StyleColor.WHITE,
      label: Text('Add to fav', style: TextStyle(color: StyleColor.PRIMARY)),
      onPressed: () {
        setState(() {
          changeButton = true;
        });
        ScopedModel.of<SearchModel>(context).addToFav(widget.result.id);
      },
    );
  }
}
