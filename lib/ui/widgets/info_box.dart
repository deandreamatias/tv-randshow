import 'package:flutter/widgets.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../shared/styles.dart';

class InfoBox extends StatelessWidget {
  const InfoBox({Key key, this.typeInfo, this.value}) : super(key: key);
  final int typeInfo;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        alignment: Alignment.topCenter,
        margin: SMALL_INSESTS,
        padding: SMALL_INSESTS,
        constraints: const BoxConstraints.expand(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(selectTitle(typeInfo, context),
                  style: StyleText.INFO_BOX_TITLE),
            ),
            Text(
              value > 0 ? value.toString() : '--',
              style: StyleText.INFO_BOX_NUMBER,
            ),
            if (typeInfo <= 2)
              typeInfo == 2
                  ? Text(
                      translate('app.modal.duration_metric'),
                      style: StyleText.DESCRIPTION,
                    )
                  : Text(
                      translate('app.modal.episode_season_metric'),
                      style: StyleText.DESCRIPTION,
                    ),
          ],
        ),
        decoration: const BoxDecoration(
          color: StyleColor.PRIMARY,
          borderRadius: BORDER_RADIUS,
        ),
      ),
    );
  }

  String selectTitle(int typeInfo, BuildContext context) {
    switch (typeInfo) {
      case 0:
        return translate('app.modal.seasons');
        break;
      case 1:
        return translate('app.modal.episodes');
        break;
      case 2:
        return translate('app.modal.duration');
        break;
      case 3:
        return translate('app.modal.season');
        break;
      case 4:
        return translate('app.modal.episode');
        break;
      default:
        return translate('app.modal.undefined');
    }
  }
}
