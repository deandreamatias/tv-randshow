import 'package:flutter_test/flutter_test.dart';
import 'package:tv_randshow/core/viewmodels/views/loading_view_model.dart';

void main() {
  group('LoadingViewModelTest -', () {
    group('sortRandomEpisode -', () {
      test('When constructed canNavigate should be false', () {
        final LoadingViewModel model = LoadingViewModel();
        
        expect(model.canNavigate, false);
      });
    });
  });
}
