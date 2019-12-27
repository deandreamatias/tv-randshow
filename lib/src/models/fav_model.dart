import '../data/tvshow_details.dart';
import '../ui/widgets/fav_widget.dart';
import 'base_model.dart';

class FavModel extends BaseModel {
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
