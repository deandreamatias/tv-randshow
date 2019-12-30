import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import '../../models/search_model.dart';
import '../../utils/styles.dart';
import '../../utils/unicons_icons.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({Key key, this.editingController, this.searchModel})
      : super(key: key);
  final TextEditingController editingController;
  final SearchModel searchModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        controller: editingController,
        textInputAction: TextInputAction.search,
        onChanged: (String text) =>
            searchModel.searched ? searchModel.onSearch() : null,
        onSubmitted: (String value) =>
            editingController.text.isNotEmpty ? searchModel.getSearch() : null,
        autofocus: true,
        autocorrect: true,
        enableSuggestions: true,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            hintText: FlutterI18n.translate(context, 'app.search.search_bar'),
            contentPadding: const EdgeInsets.all(0.0),
            //suffixIcon: Icon(Icons.close),
            prefixIcon: Icon(Unicons.search, color: StyleColor.PRIMARY),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: StyleColor.PRIMARY),
                borderRadius: BORDER_RADIUS),
            border: const OutlineInputBorder(borderRadius: BORDER_RADIUS)),
      ),
    );
  }
}
