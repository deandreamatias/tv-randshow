import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:provider/provider.dart';

import '../../core/utils/constants.dart';
import '../../core/viewmodels/views/splash_view_model.dart';
import '../base_widget.dart';
import 'tab_view.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<SplashViewModel>(
      // TODO: Add conditional first time navigate to search
      onModelReady: (SplashViewModel model) {
        selectLocale(context);
        model.init().then(
              (void empty) => Navigator.pushNamedAndRemoveUntil<TabView>(
                context,
                RoutePaths.TAB,
                ModalRoute.withName(RoutePaths.TAB),
              ),
            );
      },
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

  void selectLocale(BuildContext context) {
    switch (FlutterI18n.currentLocale(context).languageCode) {
      case 'en':
      case 'es':
      case 'pt':
        break;
      default:
        FlutterI18n.refresh(context, const Locale('en'));
    }
  }
}
