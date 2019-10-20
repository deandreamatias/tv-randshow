import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tv_randshow/src/models/base_model.dart';
import 'package:tv_randshow/src/models/tv_search/tvshow_search_model.dart';
import 'package:tv_randshow/src/ui/widgets/backdrop_widget.dart';
import 'package:tv_randshow/src/ui/widgets/info_box_widget.dart';
import 'package:tv_randshow/src/ui/widgets/search_widget.dart';
import 'package:tv_randshow/src/utils/constants.dart';
import 'package:tv_randshow/src/utils/styles.dart';

class TvshowSearchView extends StatefulWidget {
  TvshowSearchView({Key key}) : super(key: key);

  _TvshowSearchViewState createState() => _TvshowSearchViewState();
}

class _TvshowSearchViewState extends State<TvshowSearchView> {
  final TvshowSearchModel _tvshowSearchModel = TvshowSearchModel();
  TextEditingController textEditingController;
  bool panelOpen;

  @override
  void initState() {
    textEditingController = TextEditingController(text: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ChangeNotifierProvider(
            builder: (context) => _tvshowSearchModel,
            child: Consumer<TvshowSearchModel>(builder: (context, value, child) {
              return Backdrop(
                frontLayer: FrontPanel(),
                backLayer: _buildListSearch(),
                frontHeader: FrontPanelTitle(),
                panelVisible: value.tvShowDetails,
                frontPanelOpenHeight: 150.0, // TODO: Fix size show in container
                frontHeaderVisibleClosed: false,
              );
            })),
      ),
    );
  }

  Widget _buildListSearch() {
    return Container(
      child: Column(
        children: <Widget>[
          SearchWidget(
              editingController: textEditingController, tvshowSearchModel: _tvshowSearchModel),
          Expanded(
            child: Consumer<TvshowSearchModel>(builder: (context, value, child) {
              if (value.listTvShow == null) {
                if (value.state == BaseState.init) {
                  return Center(child: Text('Search data'));
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              } else {
                return GridView.builder(
                  semanticChildCount: value.listTvShow.length,
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
        ],
      ),
    );
  }
}

class FrontPanelTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 16.0),
      child: Text(
        'Tap Me',
        style: Theme.of(context).textTheme.subhead,
      ),
    );
  }
}

class FrontPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Row(
              children: <Widget>[
                Container(
                  child: Image.asset(ImagePath.emptyTvShow),
                  decoration: BoxDecoration(
                    borderRadius: BORDER_RADIUS,
                  ),
                ),
                Padding(
                  padding: SMALL_INSESTS,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Friends',
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: <Widget>[
                InfoBoxWidget(typeInfo: 0),
                InfoBoxWidget(typeInfo: 1),
                InfoBoxWidget(typeInfo: 2)
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Sinopse', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
                SizedBox(height: 4.0),
                Text('Descripción .....')
              ],
            ),
          ),
        ],
      ),
    ));
  }

  ImageProvider checkImage() {
    //if (urlImage == null) {
    return AssetImage(ImagePath.emptyTvShow);
    //} else {
    //return NetworkImage(Url.BASE_IMAGE + urlImage);
    //}
  }
}
