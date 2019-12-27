import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import '../../models/search_model.dart';
import '../../utils/styles.dart';
import '../../utils/unicons_icons.dart';
import '../views/base_view.dart';

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
                        label: Text(
                            FlutterI18n.translate(
                                context, 'app.search.button_fav'),
                            style: StyleText.PRIMARY),
                        onPressed: () {
                          setState(() {
                            fav = false;
                          });
                          model.addToFav(widget.id);
                        },
                      )
                    : RaisedButton.icon(
                        key: const ValueKey<String>('delete'),
                        icon: Icon(Unicons.close, color: StyleColor.PRIMARY),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: const BorderSide(color: StyleColor.PRIMARY)),
                        color: StyleColor.WHITE,
                        label: Text(
                            FlutterI18n.translate(
                                context, 'app.search.button_delete'),
                            style: StyleText.PRIMARY),
                        onPressed: () {
                          setState(() {
                            fav = true;
                          });
                          model.deleteFav(widget.id);
                        },
                      )));
  }
}
