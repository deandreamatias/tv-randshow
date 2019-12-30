import 'package:flutter/material.dart';

import '../../models/fav_model.dart';
import '../../utils/states.dart';
import '../../utils/styles.dart';
import '../widgets/text_widget.dart';
import 'base_view.dart';

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
                padding: DEFAULT_INSESTS,
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
