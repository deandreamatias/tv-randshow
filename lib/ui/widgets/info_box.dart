import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:tv_randshow/ui/shared/styles.dart';

class InfoBox extends StatelessWidget {
  final InfoTypeBox typeInfo;
  final int value;

  const InfoBox({
    super.key,
    required this.typeInfo,
    required this.value,
  });

  String _selectTitle(InfoTypeBox typeInfo) {
    switch (typeInfo) {
      case InfoTypeBox.seasons:
        return translate('app.modal.seasons');
      case InfoTypeBox.episodes:
        return translate('app.modal.episodes');
      case InfoTypeBox.duration:
        return translate('app.modal.duration');
      case InfoTypeBox.season:
        return translate('app.modal.season');
      case InfoTypeBox.episode:
        return translate('app.modal.episode');
      default:
        return translate('app.modal.undefined');
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Flexible(
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: BoxDecoration(
            color: colorScheme.primary,
            borderRadius: const BorderRadius.all(Radius.circular(Styles.small)),
          ),
          alignment: Alignment.topCenter,
          margin: const EdgeInsets.all(Styles.small),
          padding: const EdgeInsets.all(Styles.small),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  _selectTitle(typeInfo),
                  style: textTheme.titleMedium?.copyWith(
                    color: colorScheme.onPrimary,
                  ),
                ),
              ),
              Text(
                value > 0 ? value.toString() : '--',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: colorScheme.onPrimary),
              ),
              if ([
                InfoTypeBox.episodes,
                InfoTypeBox.seasons,
                InfoTypeBox.duration,
              ].contains(typeInfo))
                Text(
                  InfoTypeBox.duration == typeInfo
                      ? translate('app.modal.duration_metric')
                      : translate('app.modal.episode_season_metric'),
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onPrimary,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

enum InfoTypeBox {
  seasons,
  episodes,
  duration,
  season,
  episode,
  undefined,
}
