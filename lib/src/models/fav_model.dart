import 'package:tv_randshow/src/data/tvshow_details.dart';
import 'package:tv_randshow/src/models/base_model.dart';
import 'package:tv_randshow/src/services/database.dart';
import 'package:tv_randshow/src/ui/widgets/fav_widget.dart';

class FavModel extends BaseModel {
  final Database database = Database();
  List<FavWidget> _listTvShow;
  TvshowDetails _tvshowDetails;

  List<FavWidget> get listTvShow => _listTvShow;
  TvshowDetails get tvshowDetails => _tvshowDetails;

  getFavs() async {
    setLoading();
    database.queryList().then((list) {
      _listTvShow = list.map((tvshow) {
        return FavWidget(tvshowDetails: tvshow);
      }).toList();
      setInit();
    }).catchError((onError) => print('Error get favs $onError'));
  }

  deleteFav(int id) {
    setLoading();
    database.delete(id).then((_id) {
      _id != id ? setError() : setInit();
    }).catchError((onError) => print('Error $onError to deleted row $id'));
  }
}
