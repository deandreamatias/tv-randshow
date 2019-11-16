import 'package:flutter/material.dart';
import 'package:tv_randshow/src/models/base_model.dart';

import 'package:tv_randshow/src/models/tvshow_fav_model.dart';
import 'package:tv_randshow/src/ui/views/base_view.dart';
import 'package:tv_randshow/src/ui/widgets/backdrop_widget.dart';
import 'package:tv_randshow/src/ui/widgets/menu_details_widget.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  void initState() {
    super.initState();
    _tvshowFavModel.getFavs(); // TODO: Update favs when update db
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<>(
          child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.search),
          onPressed: () => Navigator.of(context).pushNamed('/search'),
        ),
        body: SafeArea(
          child: Backdrop(
            frontLayer: MenuPanelWidget(),
            backLayer: _buildListFav(),
            panelVisible: value.tvShowDetails,
          ),
        ),
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
