import 'package:scoped_model/scoped_model.dart';

enum BaseState { init, loading, error }

class BaseModel extends Model {
  BaseState _state;
  BaseState get state => _state;

  setInit() {
    _setState(BaseState.init);
  }

  setLoading() {
    _setState(BaseState.loading);
  }

  setError() {
    _setState(BaseState.error);
  }

  _setState(BaseState baseState) {
    _state = baseState;
    print('# State of $runtimeType: $baseState');
    notifyListeners();
  }
}
