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

  Future<void> getFavs() async {
    setLoading();
    database.queryList().then((List<TvshowDetails> list) {
      _listTvShow = list.map((TvshowDetails tvshow) {
        return FavWidget(tvshowDetails: tvshow);
      }).toList();
      setInit();
    }).catchError((dynamic onError) => logger.printError('Get favs', onError));
  }

  void deleteFav(int id) {
    setLoading();
    database.delete(id).then((int _id) {
      _id != id ? setError() : setInit();
    }).catchError(
        (dynamic onError) => logger.printError('Delete fav', onError));
  }
}
