import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:launch_review/launch_review.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:persist_theme/persist_theme.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/utils/constants.dart';
import '../shared/unicons_icons.dart';

class InfoView extends StatelessWidget {
  const InfoView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            translate('app.info.title'),
            style: Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: <Widget>[
              ListTile(
                title: Text(
                  translate(
                      kIsWeb ? 'app.info.app_title' : 'app.info.web_title'),
                ),
                subtitle: Text(
                  translate(kIsWeb
                      ? 'app.info.app_description'
                      : 'app.info.web_description'),
                ),
                leading: const Icon(
                    kIsWeb ? Unicons.google_play : Unicons.external_link_alt),
                onTap: () async {
                  const String url = kIsWeb
                      ? 'https://play.google.com/store/apps/details?id=deandrea.matias.tv_randshow'
                      : 'https://tvrandshow.com';
                  if (await canLaunch(url)) {
                    await launch(url);
                    log('Launched: $url');
                  } else {
                    throw 'Could not launch $url';
                  }
                },
              ),
              Visibility(
                visible: !kIsWeb,
                child: ListTile(
                  title: Text(
                    translate('app.info.rate_title'),
                  ),
                  subtitle: Text(
                    translate('app.info.rate_description'),
                  ),
                  leading: const Icon(Unicons.feedback),
                  onTap: () => LaunchReview.launch(
                    androidAppId: 'deandrea.matias.tv_randshow',
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  translate('app.info.feedback_title'),
                ),
                subtitle: Text(
                  translate('app.info.feedback_description'),
                ),
                leading: const Icon(Unicons.envelope),
                onTap: () async {
                  const String url =
                      'mailto:deandreamatias@gmail.com?subject=TV%20Randshow%20feedback';
                  try {
                    await launch(url);
                    log('Launched: $url');
                  } catch (e) {
                    throw 'Could not launch $url because $e';
                  }
                },
              ),
              ListTile(
                title: Text(
                  translate('app.info.version.title'),
                ),
                subtitle: Text(
                  translate('app.info.version.description'),
                ),
                leading: const Icon(Unicons.brackets_curly),
                onTap: () {
                  _changelog(context);
                },
              ),
              DarkModeSwitch(
                leading: const Icon(Unicons.moon),
                title: Text(translate('app.info.dark_title')),
                subtitle: Text(translate('app.info.dark_description')),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _changelog(BuildContext context) {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(
          translate('app.info.version.dialog_title'),
        ),
        content: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: FutureBuilder<Object>(
              future: loadAsset(
                  LocalizedApp.of(context).delegate.currentLocale.languageCode),
              builder: (BuildContext context, AsyncSnapshot<Object> snapshot) {
                if (snapshot.hasData) {
                  return MarkdownBody(data: snapshot.data);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
        actions: <Widget>[
          OutlineButton(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
            child: Text(
              translate('app.info.version.dialog_button'),
            ),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
    );
  }

  Future<String> loadAsset(String languageCode) async {
    switch (languageCode) {
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
