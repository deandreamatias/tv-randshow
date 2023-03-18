import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:tv_randshow/ui/features/random/widgets/home_button.dart';
import 'package:tv_randshow/ui/shared/styles.dart';

class LoadingBaseView extends StatelessWidget {
  final String titleKey;
  final Widget child;

  const LoadingBaseView({
    super.key,
    required this.child,
    required this.titleKey,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Styles.standard),
          child: Center(
            child: Column(
              children: <Widget>[
                Text(
                  translate(titleKey),
                  key: Key(titleKey),
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: Styles.standard),
                Expanded(child: child),
                const HomeButton(keyText: 'app.loading.button_fav'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
