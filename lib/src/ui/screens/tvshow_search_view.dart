import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tv_randshow/src/models/tv_search/tvshow_search_model.dart';
import 'package:tv_randshow/src/ui/widgets/search_widget.dart';
import 'package:tv_randshow/src/ui/widgets/tvshow_widget.dart';

class TvshowSearchView extends StatefulWidget {
  TvshowSearchView({Key key}) : super(key: key);

  _TvshowSearchViewState createState() => _TvshowSearchViewState();
}

class _TvshowSearchViewState extends State<TvshowSearchView> {
  final TvshowSearchModel _tvshowSearchModel = TvshowSearchModel();
  TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController(text: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: <Widget>[
              SearchWidget(editingController: textEditingController),
              Expanded(
                child: FutureProvider<List<TvshowWidget>>(
                  builder: (_) => _tvshowSearchModel.getSearch('how i met'),
                  child: Consumer<List<TvshowWidget>>(builder: (context, value, child) {
                    if (value == null) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return GridView.builder(
                        padding: EdgeInsets.all(16.0),
                        itemCount: value.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          return value[index];
                        },
                      );
                    }
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  query() {}
}
