import 'package:flutter/material.dart';

import 'package:tv_randshow/src/models/tv_search/tvshow_search_model.dart';
import 'package:tv_randshow/src/utils/styles.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController editingController;
  final TvshowSearchModel tvshowSearchModel;
  const SearchWidget({Key key, this.editingController, this.tvshowSearchModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: TextField(
        controller: editingController,
        //autofocus: true,
        textInputAction: TextInputAction.search,
        onSubmitted: (value) => editingController.text.isNotEmpty
            ? tvshowSearchModel.getSearch(editingController.text)
            : print(editingController.text),
        autocorrect: true,
        decoration: InputDecoration(
            hintText: "Search",
            contentPadding: EdgeInsets.all(0.0),
            //suffixIcon: Icon(Icons.close),
            prefixIcon: Icon(Icons.search, color: StyleColor.SECONDARY),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: StyleColor.SECONDARY), borderRadius: BORDER_RADIUS),
            border: OutlineInputBorder(borderRadius: BORDER_RADIUS)),
      ),
    );
  }
}
