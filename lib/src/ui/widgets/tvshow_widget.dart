import 'package:flutter/material.dart';

class TvshowWidget extends StatelessWidget {
  final String tvshowName;
  TvshowWidget({Key key, this.tvshowName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      width: 150.0,
      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
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
    );
  }

  Widget _image() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 140.0,
        width: 150.0,
        child: Stack(fit: StackFit.expand, children: <Widget>[
          Image(
            image: AssetImage('assets/img/friends.jpg'),
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                tvshowName,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _closeButton() {
    return Container(
      height: 36.0,
      width: 36.0,
      color: Colors.grey,
      child: IconButton(
        alignment: Alignment.center,
        icon: Icon(Icons.close),
        color: Colors.red,
        iconSize: 16.0,
        onPressed: () {},
      ),
    );
  }

  Widget _actionButton() {
    return RaisedButton.icon(
      icon: Icon(Icons.local_play),
      color: Colors.red,
      label: Text('Random'),
      onPressed: () {},
    );
  }
}
