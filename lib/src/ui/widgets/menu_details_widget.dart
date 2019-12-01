import 'package:flutter/material.dart';
import 'package:tv_randshow/src/ui/widgets/info_box_widget.dart';
import 'package:tv_randshow/src/utils/constants.dart';
import 'package:tv_randshow/src/utils/styles.dart';
import 'package:tv_randshow/src/utils/unicons_icons.dart';

class MenuPanelWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
        alignment: Alignment.topCenter,
        overflow: Overflow.visible,
        children: <Widget>[
          Positioned(
            top: -22.5,
            child: RaisedButton.icon(
              icon: Icon(Unicons.favourite, color: StyleColor.PRIMARY),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(color: StyleColor.PRIMARY)),
              color: StyleColor.WHITE,
              label: Text('Add to fav',
                  style: TextStyle(color: StyleColor.PRIMARY)),
              onPressed: () {},
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Image.asset(ImagePath.emptyTvShow),
                        decoration: BoxDecoration(
                          borderRadius: BORDER_RADIUS,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Friends',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: <Widget>[
                      InfoBoxWidget(typeInfo: 0),
                      InfoBoxWidget(typeInfo: 1),
                      InfoBoxWidget(typeInfo: 2)
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Sinopse',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20)),
                      SizedBox(height: 4.0),
                      Text('Descripción .....')
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]);
  }
}
