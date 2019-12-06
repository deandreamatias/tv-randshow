import 'package:flutter/material.dart';

import 'package:tv_randshow/src/models/search_model.dart';
import 'package:tv_randshow/src/utils/styles.dart';
import 'package:tv_randshow/src/utils/unicons_icons.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController editingController;
  final SearchModel searchModel;
  const SearchBarWidget({Key key, this.editingController, this.searchModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: TextField(
        controller: editingController,
        textInputAction: TextInputAction.search,
        onSubmitted: (value) => editingController.text.isNotEmpty
            ? searchModel.getSearch(editingController.text)
            : print(editingController.text),
        autofocus: true,
        autocorrect: true,
        decoration: InputDecoration(
            hintText: "Search",
            contentPadding: EdgeInsets.all(0.0),
            //suffixIcon: Icon(Icons.close),
            prefixIcon: Icon(Unicons.search, color: StyleColor.SECONDARY),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: StyleColor.SECONDARY),
                borderRadius: BORDER_RADIUS),
            border: OutlineInputBorder(borderRadius: BORDER_RADIUS)),
      ),
    );
  }
}
