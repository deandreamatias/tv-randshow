import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:stacked/stacked.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:unicons/unicons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/utils/constants.dart';
import '../../core/viewmodels/views/info_view_model.dart';

class InfoView extends StatelessWidget {
  const InfoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<InfoViewModel>.nonReactive(
      onModelReady: (InfoViewModel model) => model.getVersion(),
      viewModelBuilder: () => InfoViewModel(),
      builder: (BuildContext context, InfoViewModel model, Widget? child) {
        return Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                translate('app.info.title'),
                key: const Key('app.info.title'),
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: <Widget>[
                  SwitchListTile(
                    value: ThemeProvider.themeOf(context)
                            .id
                            .compareTo('dark_theme') ==
                        0,
                    onChanged: (changed) =>
                        ThemeProvider.controllerOf(context).nextTheme(),
                    title: Text(
                      translate('app.info.dark_title'),
                      key: const Key('app.info.dark_title'),
                    ),
                    subtitle: Text(
                      translate('app.info.dark_description'),
                      key: const Key('app.info.dark_description'),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      translate(
                          kIsWeb ? 'app.info.app_title' : 'app.info.web_title'),
                      key: Key(
                          kIsWeb ? 'app.info.app_title' : 'app.info.web_title'),
                    ),
                    subtitle: Text(
                      translate(kIsWeb
                          ? 'app.info.app_description'
                          : 'app.info.web_description'),
                      key: Key(kIsWeb
                          ? 'app.info.app_description'
                          : 'app.info.web_description'),
                    ),
                    leading: const Icon(kIsWeb
                        ? UniconsLine.google_play
                        : UniconsLine.external_link_alt),
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
                  ListTile(
                    title: Text(
                      translate('app.info.export_title'),
                      key: const Key('app.info.export_title'),
                    ),
                    subtitle: Text(
                      translate('app.info.export_description'),
                      key: const Key('app.info.export_description'),
                    ),
                    leading: const Icon(UniconsLine.file_export),
                    trailing: model.isBusy ? CircularProgressIndicator() : null,
                    onTap: () async => await model.exportTvshows(),
                  ),
                  Visibility(
                    visible: !kIsWeb,
                    child: ListTile(
                      title: Text(
                        translate('app.info.rate_title'),
                        key: const Key('app.info.rate_title'),
                      ),
                      subtitle: Text(
                        translate('app.info.rate_description'),
                        key: const Key('app.info.rate_description'),
                      ),
                      leading: const Icon(UniconsLine.feedback),
                      onTap: () async => await putReview(),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      translate('app.info.feedback_title'),
                      key: const Key('app.info.feedback_title'),
                    ),
                    subtitle: Text(
                      translate('app.info.feedback_description'),
                      key: const Key('app.info.feedback_description'),
                    ),
                    leading: const Icon(UniconsLine.envelope),
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
                      key: const Key('app.info.version.title'),
                    ),
                    subtitle: Text(
                      translate('app.info.version.description'),
                      key: const Key('app.info.version.description'),
                    ),
                    leading: const Icon(UniconsLine.brackets_curly),
                    onTap: () {
                      _changelog(context, model.version);
                    },
                  ),
                  ListTile(
                    title: Text(
                      translate('app.info.privacy_title'),
                      key: const Key('app.info.privacy_title'),
                    ),
                    subtitle: Text(
                      translate('app.info.privacy_description'),
                      key: const Key('app.info.privacy_description'),
                    ),
                    leading: const Icon(UniconsLine.file_shield_alt),
                    onTap: () =>
                        Navigator.of(context).pushNamed(RoutePaths.PRIVACY),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> putReview() async {
    final InAppReview inAppReview = InAppReview.instance;
    await inAppReview.isAvailable()
        ? inAppReview.requestReview()
        : inAppReview.openStoreListing();
  }

  void _changelog(BuildContext context, String version) {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(
          '${translate('app.info.version.dialog_title')} ($version)',
          key: const Key('app.info.version.dialog_title'),
        ),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width * 0.5,
          child: FutureBuilder<String>(
            future: loadAsset(
                LocalizedApp.of(context).delegate.currentLocale.languageCode),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              return snapshot.hasData
                  ? Markdown(data: snapshot.data ?? '')
                  : const Center(
                      child: CircularProgressIndicator(),
                    );
            },
          ),
        ),
        actions: <Widget>[
          OutlinedButton(
            key: const Key('app.info.version.dialog_button'),
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
      case 'pt':
        return await rootBundle.loadString(Assets.WHATS_NEW_PT);
      case 'en':
      default:
        return await rootBundle.loadString(Assets.WHATS_NEW_EN);
    }
  }
}
