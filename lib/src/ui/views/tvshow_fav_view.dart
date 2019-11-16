import 'package:flutter/material.dart';

import 'package:tv_randshow/src/models/home_model.dart';
import 'package:tv_randshow/src/ui/views/base_view.dart';
import 'package:tv_randshow/src/ui/widgets/backdrop_widget.dart';
import 'package:tv_randshow/src/ui/widgets/menu_details_widget.dart';
import 'package:tv_randshow/src/utils/states.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeModel>(onModelReady: (model) {
      model.getFavs();
    }, builder: (context, child, model) {
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.search),
          onPressed: () => Navigator.of(context).pushNamed('/search'),
        ),
        body: SafeArea(
          child: Backdrop(
            frontLayer: MenuPanelWidget(),
            backLayer: Container(
              child: _renderData(model),
            ),
            panelVisible: model.tvShowDetails,
          ),
        ),
      );
    });
  }

  Widget _renderData(HomeModel model) {
    if (model.state != ViewState.loading) {
      if (model.listTvShow == null) {
        return Center(child: Text('Empty list'));
      } else {
        return GridView.builder(
          semanticChildCount: model.listTvShow.length,
          padding: EdgeInsets.all(16.0),
          itemCount: model.listTvShow.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index) {
            return model.listTvShow[index];
          },
        );
      }
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }
}
