import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tv_randshow/ui/shared/styles.dart';

class InfoBox extends StatelessWidget {
  final InfoTypeBox typeInfo;
  final int value;

  const InfoBox({super.key, required this.typeInfo, required this.value});

  String _selectTitle(BuildContext context, InfoTypeBox typeInfo) {
    return switch (typeInfo) {
      InfoTypeBox.seasons => context.tr('app.modal.seasons'),
      InfoTypeBox.episodes => context.tr('app.modal.episodes'),
      InfoTypeBox.duration => context.tr('app.modal.duration'),
      InfoTypeBox.season => context.tr('app.modal.season'),
      InfoTypeBox.episode => context.tr('app.modal.episode'),
      _ => context.tr('app.modal.undefined'),
    };
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
                  _selectTitle(context, typeInfo),
                  style: textTheme.titleMedium?.copyWith(
                    color: colorScheme.onPrimary,
                  ),
                ),
              ),
              Text(
                value > 0 ? value.toString() : '--',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: colorScheme.onPrimary,
                ),
              ),
              if ([
                InfoTypeBox.episodes,
                InfoTypeBox.seasons,
                InfoTypeBox.duration,
              ].contains(typeInfo))
                Text(
                  InfoTypeBox.duration == typeInfo
                      ? context.tr('app.modal.duration_metric')
                      : context.tr('app.modal.episode_season_metric'),
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

enum InfoTypeBox { seasons, episodes, duration, season, episode, undefined }
