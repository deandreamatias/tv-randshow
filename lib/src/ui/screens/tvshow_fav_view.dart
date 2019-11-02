import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_randshow/src/models/base_model.dart';

import 'package:tv_randshow/src/models/tvshow_fav_model.dart';
import 'package:tv_randshow/src/ui/widgets/backdrop_widget.dart';
import 'package:tv_randshow/src/ui/widgets/menu_details_widget.dart';

class TvshowFavView extends StatefulWidget {
  TvshowFavView({Key key}) : super(key: key);

  _TvshowFavViewState createState() => _TvshowFavViewState();
}

class _TvshowFavViewState extends State<TvshowFavView> {
  final TvshowFavModel _tvshowFavModel = TvshowFavModel();

  @override
  void initState() {
    super.initState();
    _tvshowFavModel.getFavs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () => Navigator.of(context).pushNamed('/search'),
      ),
      body: SafeArea(
        child: ChangeNotifierProvider(
            builder: (context) => _tvshowFavModel,
            child: Consumer<TvshowFavModel>(builder: (context, value, child) {
              return Backdrop(
                frontLayer: MenuPanelWidget(),
                backLayer: _buildListFav(),
                panelVisible: value.tvShowDetails,
              );
            })),
      ),
    );
  }

  Widget _buildListFav() {
    return Container(
      child: Consumer<TvshowFavModel>(builder: (context, value, child) {
        if (value.state != BaseState.loading) {
          if (value.listTvShow == null) {
            return Center(child: Text('Empty list'));
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
        } else {
          return Center(child: CircularProgressIndicator());
        }
      }),
    );
  }
}
