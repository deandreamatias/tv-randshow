import 'package:stacked/stacked.dart';
import 'package:tv_randshow/core/app/ioc/locator.dart';
import 'package:tv_randshow/ui/viewmodels/services/favs_service.dart';

class DeleteModel extends BaseViewModel {
  final FavsService _favsService = locator<FavsService>();

  Future<void> deleteFav(int id) async {
    await _favsService.deleteFav(id);
  }
}
