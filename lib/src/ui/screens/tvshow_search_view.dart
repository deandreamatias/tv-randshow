import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_randshow/src/models/base_model.dart';

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
              SearchWidget(
                  editingController: textEditingController, tvshowSearchModel: _tvshowSearchModel),
              Expanded(
                child: ChangeNotifierProvider(
                  builder: (context) => _tvshowSearchModel,
                  child: Consumer<TvshowSearchModel>(builder: (context, value, child) {
                    if (value.listTvShow == null) {
                      if (value.state == BaseState.init) {
                        return Center(child: Text('Search data'));
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    } else {
                      return GridView.builder(
                        padding: EdgeInsets.all(16.0),
                        itemCount: value.listTvShow.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          return value.listTvShow[index];
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
}
