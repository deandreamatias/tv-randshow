import 'package:flutter/material.dart';

import 'package:tv_randshow/src/models/fav_model.dart';
import 'package:tv_randshow/src/ui/views/base_view.dart';
import 'package:tv_randshow/src/ui/widgets/text_widget.dart';
import 'package:tv_randshow/src/utils/states.dart';

class FavView extends StatefulWidget {
  const FavView({Key key}) : super(key: key);

  @override
  _FavViewState createState() => _FavViewState();
}

class _FavViewState extends State<FavView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<FavModel>(onModelReady: (FavModel model) {
      model.getFavs();
    }, builder: (BuildContext context, Widget child, FavModel model) {
      return SafeArea(
        child: Container(
          child: _renderData(model),
        ),
      );
    });
  }

  Widget _renderData(FavModel model) {
    if (model.state != ViewState.loading) {
      if (model.listTvShow == null || model.listTvShow.isEmpty) {
        return const Center(
          child: TextWidget('app.fav.empty_message'),
        );
      } else {
        return Column(
          children: <Widget>[
            const SizedBox(height: 16.0),
            const TextWidget('app.fav.title'),
            Expanded(
              child: GridView.builder(
                semanticChildCount: model.listTvShow.length,
                padding: const EdgeInsets.all(16.0),
                itemCount: model.listTvShow.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                    crossAxisCount: 2),
                itemBuilder: (BuildContext context, int index) {
                  return model.listTvShow[index];
                },
              ),
            ),
          ],
        );
      }
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }
}
