import 'package:flutter/material.dart';

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
              SearchWidget(),
              Expanded(
                child: FutureBuilder<List<TvshowWidget>>(
                  future: _tvshowSearchModel.getSearch('friends'),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        print('no data');
                        return Container(color: Colors.red);
                        break;
                      case ConnectionState.waiting:
                        print('cargando');
                        return Container(color: Colors.amber);
                        break;
                      case ConnectionState.done:
                        print('pronto');
                        return GridView.builder(
                          padding: EdgeInsets.all(16.0),
                          itemCount: snapshot.data.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            return snapshot.data[index];
                          },
                        );
                        break;
                      default:
                        return Container(color: Colors.teal);
                    }
                  },
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
