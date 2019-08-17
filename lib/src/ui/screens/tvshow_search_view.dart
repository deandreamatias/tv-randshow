import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

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
    _tvshowSearchModel.setInit();
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
              SearchWidget(),
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.all(16.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return TvshowWidget(tvshowName: 'Friends');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
