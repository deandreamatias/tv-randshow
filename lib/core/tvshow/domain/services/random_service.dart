import 'dart:developer' as developer;
import 'dart:math';

import 'package:injectable/injectable.dart';

@LazySingleton()
class RandomService {
  /// Get random int between [max] and [min]
  int getNumber({int max = 1, int min = 0}) {
    assert(max > min, 'max should be greater than min');

    final Random random = Random();
    final int randomNumber = random.nextInt(max - min) + min;
    developer.log('Random nº: $randomNumber');
    return randomNumber;
  }
}
