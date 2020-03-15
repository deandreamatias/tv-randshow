import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:launch_review/launch_review.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../../core/utils/constants.dart';
import '../shared/styles.dart';
import '../shared/unicons_icons.dart';

class InfoView extends StatelessWidget {
  const InfoView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              FlutterI18n.translate(context, 'app.info.title'),
              style: StyleText.MESSAGES,
              textAlign: TextAlign.center,
            ),
          ),
          ListTile(
            title: Text(
              FlutterI18n.translate(context, 'app.info.rate_title'),
            ),
            subtitle: Text(
              FlutterI18n.translate(context, 'app.info.rate_description'),
            ),
            trailing: const Icon(Unicons.feedback),
            onTap: () => LaunchReview.launch(
                androidAppId: 'deandrea.matias.tv_randshow'),
          ),
          ListTile(
            title: Text(
              FlutterI18n.translate(context, 'app.info.feedback_title'),
            ),
            subtitle: Text(
              FlutterI18n.translate(context, 'app.info.feedback_description'),
            ),
            trailing: const Icon(Unicons.envelope),
            onTap: () async {
              final Email email = Email(
                subject: 'Tv Randshow feedback',
                recipients: const <String>['deandreamatias@gmail.com'],
                isHTML: false,
              );
              await FlutterEmailSender.send(email);
            },
          ),
          ListTile(
            title: Text(
              FlutterI18n.translate(context, 'app.info.version.title'),
            ),
            subtitle: Text(
              FlutterI18n.translate(context, 'app.info.version.description'),
            ),
            trailing: const Icon(Unicons.brackets_curly),
            onTap: () async {
              _changelog(context, await loadAsset(context));
            },
          )
        ],
      ),
    );
  }

  Future<bool> _changelog(BuildContext context, String description) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: SMALL_INSESTS,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          title: Text(
            FlutterI18n.translate(
              context,
              'app.info.version.dialog_title',
            ),
          ),
          content: Markdown(data: description),
          actions: <Widget>[
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: const BorderSide(color: StyleColor.PRIMARY),
              ),
              textColor: StyleColor.PRIMARY,
              color: StyleColor.WHITE,
              child: Text(
                FlutterI18n.translate(
                  context,
                  'app.info.version.dialog_button',
                ),
              ),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      },
    );
  }

  Future<String> loadAsset(BuildContext context) async {
    switch (FlutterI18n.currentLocale(context).languageCode) {
      case 'es':
        return await rootBundle.loadString(Assets.WHATS_NEW_ES);
        break;
      case 'pt':
        return await rootBundle.loadString(Assets.WHATS_NEW_PT);
        break;
      case 'en':
      default:
        return await rootBundle.loadString(Assets.WHATS_NEW_EN);
    }
  }
}
