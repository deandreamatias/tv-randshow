import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:tv_randshow/src/models/search_model.dart';
import 'package:tv_randshow/src/data/result.dart';
import 'package:tv_randshow/src/ui/widgets/fav_button_widget.dart';
import 'package:tv_randshow/src/ui/widgets/image_widget.dart';
import 'package:tv_randshow/src/ui/widgets/menu_details_widget.dart';
import 'package:tv_randshow/src/utils/styles.dart';

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
      child: Padding(
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
      ),
    );
  }

  Widget _image(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          if (enable) {
            await ScopedModel.of<SearchModel>(context)
                .getDetails(widget.result.id);
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
              tvshowDetails: ScopedModel.of<SearchModel>(context).tvShowDetails,
              inDatabase: false,
            ),
          );
        });
  }
}
