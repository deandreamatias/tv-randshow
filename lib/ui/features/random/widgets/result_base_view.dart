import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:tv_randshow/ui/features/random/widgets/home_button.dart';
import 'package:tv_randshow/ui/shared/styles.dart';
import 'package:tv_randshow/ui/widgets/text_title_large.dart';

class ResultBaseView extends StatelessWidget {
  final String titleKey;
  final Widget child;
  final Widget actionButton;

  const ResultBaseView({
    super.key,
    required this.titleKey,
    required this.child,
    required this.actionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Styles.standard),
          child: Column(
            children: <Widget>[
              TextTitleLarge(
                translate(titleKey),
                key: Key(titleKey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: Styles.standard),
              Expanded(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: <Widget>[
                        Positioned(
                          right: 0.0,
                          left: 0.0,
                          top: 0.0,
                          bottom: Styles.large,
                          child: Container(
                            padding: const EdgeInsets.all(Styles.standard),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(Styles.small),
                              ),
                              border: Border.all(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                            ),
                            child: child,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: actionButton,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const HomeButton(keyText: 'app.result.button_fav'),
            ],
          ),
        ),
      ),
    );
  }
}
