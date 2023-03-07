import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:stacked/stacked.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:tv_randshow/ui/router.dart';
import 'package:tv_randshow/ui/shared/assets.dart';
import 'package:tv_randshow/ui/viewmodels/views/info_view_model.dart';
import 'package:tv_randshow/ui/widgets/icons/error_icon.dart';
import 'package:unicons/unicons.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoView extends StatelessWidget {
  const InfoView({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            translate('app.info.title'),
            key: const Key('app.info.title'),
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: <Widget>[
              SwitchListTile(
                value:
                    ThemeProvider.themeOf(context).id.compareTo('dark_theme') ==
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
                    kIsWeb ? 'app.info.app_title' : 'app.info.web_title',
                  ),
                  key: const Key(
                    kIsWeb ? 'app.info.app_title' : 'app.info.web_title',
                  ),
                ),
                subtitle: Text(
                  translate(
                    kIsWeb
                        ? 'app.info.app_description'
                        : 'app.info.web_description',
                  ),
                  key: const Key(
                    kIsWeb
                        ? 'app.info.app_description'
                        : 'app.info.web_description',
                  ),
                ),
                leading: const Icon(
                  kIsWeb
                      ? UniconsLine.google_play
                      : UniconsLine.external_link_alt,
                ),
                onTap: () async {
                  const String url = kIsWeb
                      ? 'https://play.google.com/store/apps/details?id=deandrea.matias.tv_randshow'
                      : 'https://tvrandshow.com';
                  if (await canLaunchUrl(Uri.parse(url))) {
                    await launchUrl(Uri.parse(url));
                    log('Launched: $url');
                  } else {
                    throw 'Could not launch $url';
                  }
                },
              ),
              Consumer(
                builder: (context, ref, child) {
                  return ListTile(
                    title: Text(
                      translate('app.info.export_title'),
                      key: const Key('app.info.export_title'),
                    ),
                    subtitle: Text(
                      translate('app.info.export_description'),
                      key: const Key('app.info.export_description'),
                    ),
                    leading: const Icon(UniconsLine.file_export),
                    trailing: ref.watch(exportTvshowsProvider).when(
                          data: (success) => success
                              ? null
                              : const ErrorIcon(
                                  textTranslateKey: 'app.info.export_error',
                                ),
                          error: (error, stackTrace) => const ErrorIcon(
                            textTranslateKey: 'app.info.export_error',
                          ),
                          loading: () => const CircularProgressIndicator(),
                        ),
                    onTap: () =>
                        ref.read(exportTvshowsProvider.notifier).export(),
                  );
                },
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
                  onTap: () async => putReview(),
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
                    await launchUrl(Uri.parse(url));
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
                  _changelog(context);
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
                    Navigator.of(context).pushNamed(RoutePaths.privacy),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> putReview() async {
    final InAppReview inAppReview = InAppReview.instance;
    await inAppReview.isAvailable()
        ? inAppReview.requestReview()
        : inAppReview.openStoreListing();
  }

  void _changelog(BuildContext context) {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        title: Consumer(
          builder: (context, ref, child) {
            return ref.watch(versionAppProvider).when(
                  data: (version) => Text(
                    '${translate('app.info.version.dialog_title')} ($version)',
                    key: const Key('app.info.version.dialog_title'),
                  ),
                  error: (error, stackTrace) => Text(
                    translate('app.info.version.dialog_title'),
                    key: const Key('app.info.version.dialog_title'),
                  ),
                  loading: () => const Align(
                    alignment: Alignment.centerLeft,
                    child: CircularProgressIndicator(),
                  ),
                );
          },
        ),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width * 0.5,
          child: FutureBuilder<String>(
            future: loadAsset(
              LocalizedApp.of(context).delegate.currentLocale.languageCode,
            ),
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
        return rootBundle.loadString(Assets.whatsNewEs);
      case 'pt':
        return rootBundle.loadString(Assets.whatsNewPt);
      case 'en':
      default:
        return rootBundle.loadString(Assets.whatsNewEn);
    }
  }
}
