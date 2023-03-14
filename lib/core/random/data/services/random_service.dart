import 'dart:math';

import 'package:injectable/injectable.dart';
import 'package:tv_randshow/core/random/domain/interfaces/i_random_service.dart';

@LazySingleton(as: IRandomService)
class RandomService implements IRandomService {
  /// Get random int between [max] and [min].
  @override
  int getNumber({int max = 1, int min = 0}) {
    assert(max > min, 'max should be greater than min');

    final Random random = Random();

    return random.nextInt(max - min) + min;
  }
}
