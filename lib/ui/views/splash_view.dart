import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/viewmodels/views/splash_view_model.dart';
import '../base_widget.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<SplashViewModel>(
      // TODO: Add navigator to home
      onModelReady: (SplashViewModel model) =>
          model.init().then((void empty) {}),
      model: SplashViewModel(
        secureStorageService: Provider.of(context),
      ),
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
