import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tv_randshow/ui/features/random/widgets/home_button.dart';
import 'package:tv_randshow/ui/shared/styles.dart';
import 'package:tv_randshow/ui/widgets/text_title_large.dart';

class ResultBaseView extends StatelessWidget {
  final String titleKey;
  final Widget child;
  final Widget actionButton;
  final Widget? trailing;

  const ResultBaseView({
    super.key,
    required this.titleKey,
    required this.child,
    required this.actionButton,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Styles.standard),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                    child: TextTitleLarge(
                      context.tr(titleKey),
                      key: Key(titleKey),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  trailing ?? const SizedBox.shrink(),
                ],
              ),
              const SizedBox(height: Styles.standard),
              Flexible(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 500,
                      maxHeight: 500,
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      fit: StackFit.passthrough,
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
                                color: Theme.of(context).colorScheme.onSurface,
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
