import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:launch_review/launch_review.dart';

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
          )
        ],
      ),
    );
  }
}
