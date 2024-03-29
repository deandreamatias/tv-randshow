import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv_randshow/core/random/data/services/random_service.dart';

void main() {
  final randomService = RandomService();
  final faker = Faker();
  test('should be 0 when get default values', () {
    final result = randomService.getNumber();

    expect(result, 0);
  });
  test('should be between 0 and max when pass max value', () {
    final max = faker.randomGenerator.integer(99999, min: 2);
    final result = randomService.getNumber(max: max);

    expect(result, lessThan(max));
    expect(result, greaterThanOrEqualTo(0));
  });
  test('should be between min and max when pass min and max values', () {
    final max = faker.randomGenerator.integer(99999, min: 2);
    final min = faker.randomGenerator.integer(max);
    final result = randomService.getNumber(max: max, min: min);

    expect(result, lessThan(max));
    expect(result, greaterThanOrEqualTo(min));
  });
  test('should get assert when max is not greater than min', () {
    final max = faker.randomGenerator.integer(99999, min: 2);

    expect(
      // Use case test.
      // ignore:  no-equal-arguments,
      () => randomService.getNumber(max: max, min: max),
      throwsAssertionError,
    );
  });
}
