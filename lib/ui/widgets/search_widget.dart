import 'package:flutter/material.dart';

import '../../core/models/result.dart';
import '../shared/styles.dart';
import 'cached_image.dart';
import 'modal_sheet.dart';
import 'save_button.dart';

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
              child: GestureDetector(
                onTap: () async {
                  if (enable) {
                    showModalBottomSheet<Container>(
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      elevation: 0.0,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.vertical(
                          top: Radius.circular(16.0),
                        ),
                      ),
                      context: context,
                      builder: (BuildContext builder) {
                        return Container(
                          height: 424,
                          child: ModalSheet(
                            idTv: widget.result.id,
                            inDatabase: false,
                          ),
                        );
                      },
                    );
                  }
                },
                child: CachedImage(
                    name: widget.result.name,
                    url: widget.result.posterPath,
                    isModal: false),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: enable
                  ? SaveButton(
                      id: widget.result.id,
                    )
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }
}
