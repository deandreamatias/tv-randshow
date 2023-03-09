import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:tv_randshow/ui/features/info/info_state.dart';
import 'package:tv_randshow/ui/router.dart';
import 'package:tv_randshow/ui/shared/assets.dart';
import 'package:tv_randshow/ui/shared/constants.dart';
import 'package:tv_randshow/ui/shared/helpers/helpers.dart';
import 'package:tv_randshow/ui/states/export_tvshow_state.dart';
import 'package:tv_randshow/ui/widgets/error_icon.dart';
import 'package:tv_randshow/ui/widgets/loader.dart';
import 'package:unicons/unicons.dart';

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
            children: const <Widget>[
              _SwitchTheme(),
              kIsWeb ? _OpenAndroidApp() : _OpenWebApp(),
              _ExportTvShows(),
              _ReviewApp(),
              _SendFeedback(),
              _Changelog(),
              _Privacy(),
            ],
          ),
        ),
      ],
    );
  }
}

class _Privacy extends StatelessWidget {
  const _Privacy();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        translate('app.info.privacy_title'),
        key: const Key('app.info.privacy_title'),
      ),
      subtitle: Text(
        translate('app.info.privacy_description'),
        key: const Key('app.info.privacy_description'),
      ),
      leading: const Icon(UniconsLine.file_shield_alt),
      onTap: () => Navigator.of(context).pushNamed(RoutePaths.privacy),
    );
  }
}

class _SendFeedback extends StatelessWidget {
  const _SendFeedback();

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
        Helpers.openMail(
          Constants.feedbackEmail,
          mailtoSubject: 'Tv Randshow - Feedback',
        );
      },
    );
  }
}

class _OpenAndroidApp extends StatelessWidget {
  const _OpenAndroidApp();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        translate('app.info.web_title'),
        key: const Key('app.info.web_title'),
      ),
      subtitle: Text(
        translate('app.info.web_description'),
        key: const Key('app.info.web_description'),
      ),
      leading: const Icon(UniconsLine.external_link_alt),
      onTap: () async {
        Helpers.openLink(Uri.parse(Constants.webAppUrl));
      },
    );
  }
}

class _OpenWebApp extends StatelessWidget {
  const _OpenWebApp();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        translate('app.info.app_title'),
        key: const Key('app.info.app_title'),
      ),
      subtitle: Text(
        translate('app.info.app_description'),
        key: const Key('app.info.app_description'),
      ),
      leading: const Icon(UniconsLine.google_play),
      onTap: () async {
        Helpers.openLink(Uri.parse(Constants.androidAppurl));
      },
    );
  }
}

class _SwitchTheme extends StatelessWidget {
  const _SwitchTheme();

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: ThemeProvider.themeOf(context).id.compareTo('dark_theme') == 0,
      onChanged: (changed) => ThemeProvider.controllerOf(context).nextTheme(),
      title: Text(
        translate('app.info.dark_title'),
        key: const Key('app.info.dark_title'),
      ),
      subtitle: Text(
        translate('app.info.dark_description'),
        key: const Key('app.info.dark_description'),
      ),
    );
  }
}

class _ExportTvShows extends StatelessWidget {
  const _ExportTvShows();

  @override
  Widget build(BuildContext context) {
    return Consumer(
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
                        keyText: 'app.info.export_error',
                      ),
                error: (error, stackTrace) => const ErrorIcon(
                  keyText: 'app.info.export_error',
                ),
                loading: () => const Loader(),
              ),
          onTap: () => ref.read(exportTvshowsProvider.notifier).export(),
        );
      },
    );
  }
}

class _ReviewApp extends StatelessWidget {
  const _ReviewApp();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        translate('app.info.rate_title'),
        key: const Key('app.info.rate_title'),
      ),
      subtitle: Text(
        translate('app.info.rate_description'),
        key: const Key('app.info.rate_description'),
      ),
      leading: const Icon(UniconsLine.feedback),
      onTap: () async {
        final InAppReview inAppReview = InAppReview.instance;
        await inAppReview.isAvailable()
            ? inAppReview.requestReview()
            : inAppReview.openStoreListing();
      },
    );
  }
}

class _Changelog extends StatelessWidget {
  const _Changelog();

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
    );
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
            future: _loadAsset(
              LocalizedApp.of(context).delegate.currentLocale.languageCode,
            ),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              return snapshot.hasData
                  ? Markdown(data: snapshot.data ?? '')
                  : const Loader();
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

  Future<String> _loadAsset(String languageCode) async {
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
