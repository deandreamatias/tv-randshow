import 'package:flutter/material.dart';

import 'package:tv_randshow/core/tvshow/domain/models/result.dart';
import 'package:tv_randshow/ui/widgets/image_builder.dart';
import 'package:tv_randshow/ui/widgets/modal_sheet.dart';
import 'package:tv_randshow/ui/widgets/save_button.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key, required this.result});
  final Result result;

  @override
  SearchWidgetState createState() => SearchWidgetState();
}

class SearchWidgetState extends State<SearchWidget> {
  // TODO(deandreamatias): Verify coincidence between database and search result
  late bool _enable;
  @override
  void initState() {
    _enable = widget.result.firstAirDate != null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _enable ? 1.0 : 0.38,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
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
                  if (_enable) {
                    showModalBottomSheet<void>(
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext builder) => ModalSheet(
                        idTv: widget.result.id,
                      ),
                    );
                  }
                },
                child: ImageBuilder(
                  name: widget.result.name,
                  url: widget.result.posterPath,
                  isModal: false,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: _enable ? SaveButton(id: widget.result.id) : Container(),
            ),
          ],
        ),
      ),
    );
  }
}
