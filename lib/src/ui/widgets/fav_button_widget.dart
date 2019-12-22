import 'package:flutter/material.dart';

import 'package:tv_randshow/src/models/search_model.dart';
import 'package:tv_randshow/src/ui/views/base_view.dart';
import 'package:tv_randshow/src/utils/styles.dart';
import 'package:tv_randshow/src/utils/unicons_icons.dart';

class FavButtonWidget extends StatefulWidget {
  const FavButtonWidget({Key key, this.id}) : super(key: key);
  final int id;
  @override
  _FavButtonWidgetState createState() => _FavButtonWidgetState();
}

class _FavButtonWidgetState extends State<FavButtonWidget> {
  bool fav;

  @override
  void initState() {
    fav = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<SearchModel>(
        onModelReady: (SearchModel model) {},
        builder: (BuildContext context, Widget child, SearchModel model) =>
            AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: fav
                    ? RaisedButton.icon(
                        key: const ValueKey<String>('add'),
                        icon:
                            Icon(Unicons.favourite, color: StyleColor.PRIMARY),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: const BorderSide(color: StyleColor.PRIMARY)),
                        color: StyleColor.WHITE,
                        label: const Text('Add to fav',
                            style: TextStyle(color: StyleColor.PRIMARY)),
                        onPressed: () {
                          setState(() {
                            fav = false;
                          });
                          model.addToFav(widget.id);
                        },
                      )
                    : RaisedButton.icon(
                        key: const ValueKey<String>('remove'),
                        icon: Icon(Unicons.close, color: StyleColor.WHITE),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        color: StyleColor.PRIMARY,
                        label: const Text('Remove',
                            style: TextStyle(color: StyleColor.WHITE)),
                        onPressed: () {
                          setState(() {
                            fav = true;
                          });
                          model.deleteFav(widget.id);
                        },
                      )));
  }
}
