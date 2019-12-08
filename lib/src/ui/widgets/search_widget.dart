import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:tv_randshow/src/models/search_model.dart';
import 'package:tv_randshow/src/data/result.dart';
import 'package:tv_randshow/src/ui/widgets/menu_details_widget.dart';
import 'package:tv_randshow/src/utils/constants.dart';
import 'package:tv_randshow/src/utils/styles.dart';
import 'package:tv_randshow/src/utils/unicons_icons.dart';

class SearchWidget extends StatefulWidget {
  final Result result;
  SearchWidget({Key key, this.result}) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  bool enable;
  bool changeButton;
  @override
  void initState() {
    widget.result.firstAirDate == null ? enable = false : enable = true;
    changeButton =
        false; // TODO: Reset state to false when search twice in search view
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enable ? 1.0 : 0.3,
      child: Padding(
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
                  child: enable
                      ? !changeButton
                          ? _actionButton(context)
                          : _removeButton(context)
                      : Container(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showModalSheet(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        elevation: 16.0,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadiusDirectional.vertical(top: Radius.circular(16.0)),
        ),
        context: context,
        builder: (builder) {
          return Container(
            height: 400,
            child: MenuPanelWidget(
                ScopedModel.of<SearchModel>(context).tvShowDetails, false),
          );
        });
  }

  Widget _image(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await ScopedModel.of<SearchModel>(context).getDetails(widget.result.id);
        return _showModalSheet(context);
      },
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
