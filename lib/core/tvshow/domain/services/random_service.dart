import 'dart:developer' as developer;
import 'dart:math';

import 'package:injectable/injectable.dart';

@LazySingleton()
class RandomService {
  /// If [total] start with 1, add + 1 to result.
  /// Else is length of list, get normal random
  int getNumber(int total, {bool isSeason = false}) {
    final Random random = Random();
    final int randomNumber = random.nextInt(total);
    developer.log(
      'Random ${isSeason ? 'season' : 'episode'} nº: ${randomNumber + 1}',
    );
    return isSeason ? randomNumber + 1 : randomNumber;
  }
}
