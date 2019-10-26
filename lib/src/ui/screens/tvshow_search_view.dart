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
                panelVisible: value.tvShowDetails,
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

class FrontPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.topCenter, overflow: Overflow.visible, children: <Widget>[
      Positioned(
        top: -22.5,
        child: RaisedButton.icon(
          icon: Icon(Icons.star_border, color: StyleColor.PRIMARY),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: BorderSide(color: StyleColor.PRIMARY)),
          color: StyleColor.WHITE,
          label: Text('Add to fav', style: TextStyle(color: StyleColor.PRIMARY)),
          onPressed: () {},
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Image.asset(ImagePath.emptyTvShow),
                    decoration: BoxDecoration(
                      borderRadius: BORDER_RADIUS,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Friends',
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                      ),
                    ),
                  ),
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
              flex: 2,
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
      ),
    ]);
  }

  ImageProvider checkImage() {
    //if (urlImage == null) {
    return AssetImage(ImagePath.emptyTvShow);
    //} else {
    //return NetworkImage(Url.BASE_IMAGE + urlImage);
    //}
  }
}
