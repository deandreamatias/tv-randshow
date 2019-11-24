import 'package:flutter/material.dart';
import 'package:tv_randshow/src/utils/styles.dart';

class InfoBoxWidget extends StatelessWidget {
  final int typeInfo;
  final int value;
  const InfoBoxWidget({Key key, this.typeInfo, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        alignment: Alignment.topCenter,
        margin: SMALL_INSESTS,
        padding: SMALL_INSESTS,
        constraints: BoxConstraints.expand(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              selectTitle(typeInfo),
              style: TextStyle(color: StyleColor.WHITE, fontSize: 16),
            ),
            Text(
              value.toString(),
              style: TextStyle(
                  color: StyleColor.WHITE,
                  fontSize: 26,
                  fontWeight: FontWeight.w700),
            ),
            if (typeInfo > 2)
              Container()
            else
              typeInfo == 2
                  ? Text(
                      'min/episode',
                      style: TextStyle(
                          color: StyleColor.WHITE,
                          fontSize: 12,
                          fontWeight: FontWeight.w300),
                    )
                  : Text(
                      'in all',
                      style: TextStyle(
                          color: StyleColor.WHITE,
                          fontSize: 12,
                          fontWeight: FontWeight.w300),
                    ),
          ],
        ),
        decoration: BoxDecoration(
          color: StyleColor.PRIMARY,
          borderRadius: BORDER_RADIUS,
        ),
      ),
    );
  }

  String selectTitle(int typeInfo) {
    switch (typeInfo) {
      case 0:
        return 'Seasons';
        break;
      case 1:
        return 'Episodes';
        break;
      case 2:
        return 'Duration';
        break;
      case 3:
        return 'Season';
        break;
      case 4:
        return 'Episode';
        break;
      default:
        return 'Undefined';
    }
  }
}
