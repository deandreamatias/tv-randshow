import 'package:flutter/material.dart';

import 'package:tv_randshow/src/models/search_model.dart';
import 'package:tv_randshow/src/ui/views/base_view.dart';
import 'package:tv_randshow/src/ui/widgets/search_bar_widget.dart';
import 'package:tv_randshow/src/utils/states.dart';

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
      builder: (BuildContext context, Widget child, SearchModel model) => Scaffold(
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
    if (model.listTvShow == null) {
      if (model.state == ViewState.init) {
        return const Center(child: Text('Search data'));
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    } else {
      return GridView.builder(
        semanticChildCount: model.listTvShow.length,
        padding: const EdgeInsets.all(16.0),
        itemCount: model.listTvShow.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return model.listTvShow[index];
        },
      );
    }
  }
}
