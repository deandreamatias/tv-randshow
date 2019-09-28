import 'package:flutter/material.dart';

import 'package:tv_randshow/src/utils/constants.dart';
import 'package:tv_randshow/src/utils/styles.dart';

class TvshowWidget extends StatelessWidget {
  final String tvshowName;
  final String urlImage;
  TvshowWidget({Key key, this.tvshowName, this.urlImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 8.0, left: 8.0),
      child: Container(
        height: 154.0,
        width: 144.0,
        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8.0))),
        child: Stack(
          children: <Widget>[
            Positioned(
              right: 6.0,
              left: 0.0,
              top: 6.0,
              bottom: 18.0,
              child: _image(),
            ),
            Align(
              alignment: Alignment.topRight,
              child: _closeButton(),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: _actionButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _image() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 128.0,
        width: 144.0,
        child: Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              tvshowName,
              style: TextStyle(color: StyleColor.WHITE, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(Url.BASE_IMAGE + urlImage),
          ),
        ),
      ),
    );
  }

  Widget _closeButton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 20.0,
        width: 20.0,
        decoration: BoxDecoration(
          color: StyleColor.WHITE,
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          border: Border.all(),
        ),
        child: Icon(
          Icons.close,
          size: 12.0,
          color: StyleColor.PRIMARY,
        ),
      ),
    );
  }

  Widget _actionButton() {
    return RaisedButton.icon(
      icon: Icon(Icons.local_play, color: StyleColor.WHITE),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      color: StyleColor.PRIMARY,
      label: Text('Random', style: TextStyle(color: StyleColor.WHITE)),
      onPressed: () {},
    );
  }
}
