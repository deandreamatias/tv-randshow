import 'package:stacked/stacked.dart';
import 'package:tv_randshow/core/app/domain/services/favs_service.dart';
import 'package:tv_randshow/core/app/ioc/locator.dart';

class DeleteModel extends BaseViewModel {
  final FavsService _favsService = locator<FavsService>();

  Future<void> deleteFav(int id) async {
    await _favsService.deleteFav(id);
  }
}
