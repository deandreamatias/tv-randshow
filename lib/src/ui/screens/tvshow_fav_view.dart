import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:tv_randshow/src/ui/widgets/tvshow_widget.dart';

class TvshowFavView extends StatefulWidget {
  TvshowFavView({Key key}) : super(key: key);

  _TvshowFavViewState createState() => _TvshowFavViewState();
}

class _TvshowFavViewState extends State<TvshowFavView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          label: Text(FlutterI18n.translate(
            context,
            'tvshow_search.fab',
          )),
          icon: Icon(Icons.add),
          backgroundColor: Colors.indigoAccent,
          onPressed: () => {},
        ),
        body: GridView.builder(
          padding: EdgeInsets.all(16.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index) {
            return TvshowWidget(tvshowName: 'Friends');
          },
        ),
      ),
    );
  }
}
