import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../data/result.dart';
import '../../models/search_model.dart';
import '../../utils/styles.dart';
import 'fav_button_widget.dart';
import 'image_widget.dart';
import 'modal_sheet_widget.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({Key key, this.result}) : super(key: key);
  final Result result;

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  // TODO(deandreamatias): Verify coincidence between database and search result
  bool enable;
  @override
  void initState() {
    widget.result.firstAirDate == null ? enable = false : enable = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enable ? 1.0 : 0.38,
      child: Container(
        decoration: const BoxDecoration(borderRadius: BORDER_RADIUS),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              right: 0.0,
              left: 0.0,
              top: 0.0,
              bottom: 24.0,
              child: _image(context),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: enable
                  ? FavButtonWidget(
                      id: widget.result.id,
                    )
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _image(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          if (enable) {
            await ScopedModel.of<SearchModel>(context).getDetails(
              widget.result.id,
              FlutterI18n.currentLocale(context).toString(),
            );
            return _showModalSheet(context);
          }
        },
        child: ImageWidget(
            name: widget.result.name,
            url: widget.result.posterPath,
            isModal: false));
  }

  void _showModalSheet(BuildContext context) {
    showModalBottomSheet<Container>(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        elevation: 0.0,
        shape: const RoundedRectangleBorder(
          borderRadius:
              BorderRadiusDirectional.vertical(top: Radius.circular(16.0)),
        ),
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: 424,
            child: MenuPanelWidget(
              tvshowDetails: ScopedModel.of<SearchModel>(context).tvShowDetails,
              inDatabase: false,
            ),
          );
        });
  }
}
