import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';

import 'package:tv_randshow/src/models/search_model.dart';
import 'package:tv_randshow/src/ui/views/base_view.dart';
import 'package:tv_randshow/src/ui/widgets/search_bar_widget.dart';
import 'package:tv_randshow/src/ui/widgets/search_widget.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key key}) : super(key: key);

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController(text: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<SearchModel>(
      onModelReady: (SearchModel model) {},
      builder: (BuildContext context, Widget child, SearchModel model) =>
          Scaffold(
        body: SafeArea(
          child: Container(
            child: Column(
              children: <Widget>[
                SearchBarWidget(
                    editingController: textEditingController,
                    searchModel: model),
                Expanded(child: _renderData(model))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _renderData(SearchModel model) {
    if (model.searched) {
      return PagewiseGridView<SearchWidget>.count(
        pageSize: 20,
        crossAxisCount: 2,
        showRetry: false,
        padding: const EdgeInsets.all(16.0),
        errorBuilder: (BuildContext context, Object dyna) {
          return const Center(child: Text('Error to load'));
        },
        noItemsFoundBuilder: (BuildContext context) {
          return const Center(child: Text('No items'));
        },
        itemBuilder: (BuildContext context, dynamic item, int index) {
          return item;
        },
        pageFuture: (int pageIndex) =>
            model.loadList(textEditingController.text, pageIndex + 1),
      );
    } else {
      return const Center(child: Text('Search data'));
    }
  }
}
