import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_translate/localized_app.dart';
import 'package:provider/provider.dart';

import '../../core/utils/constants.dart';
import '../../core/viewmodels/views/splash_view_model.dart';
import '../base_widget.dart';
import 'tab_view.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<SplashViewModel>(
      // TODO: Add conditional first time navigate to search (use hive)
      model: SplashViewModel(
        secureStorageService: !kIsWeb ? Provider.of(context) : null,
      ),
      onModelReady: (SplashViewModel model) {
        model.init().then(
              (void empty) => Navigator.pushNamedAndRemoveUntil<TabView>(
                context,
                RoutePaths.TAB,
                ModalRoute.withName(RoutePaths.TAB),
              ),
            );
      },
      builder: (BuildContext context, SplashViewModel model, Widget child) =>
          const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  void selectLocale(BuildContext context) {
    switch (LocalizedApp.of(context).delegate.currentLocale?.languageCode) {
      case 'en':
      case 'es':
      case 'pt':
        break;
      default:
        changeLocale(context, 'en');
    }
  }
}
