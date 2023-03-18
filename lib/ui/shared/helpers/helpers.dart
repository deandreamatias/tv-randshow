import 'package:tv_randshow/ui/shared/helpers/helpers_io.dart'
    if (dart.library.html) 'package:tv_randshow/ui/shared/helpers/helpers_web.dart'
    as helpers;
import 'package:url_launcher/url_launcher.dart';

class Helpers {
  static String getLocale() {
    return helpers.getLocale();
  }

  /// Open link with external browser.
  static Future<void> openLink(Uri url) async {
    if (await canLaunchUrl(url)) {
      // Do not use this return value.
      // ignore: avoid-ignoring-return-values
      await launchUrl(url);

      return;
    }
    throw 'Could not launch $url';
  }

  /// Open mail client to send email.
  static Future<void> openMail(
    String email, {
    String mailtoSubject = '',
    String mailtoBody = '',
  }) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      query: _encodeQueryParameters(<String, String>{
        if (mailtoSubject.isNotEmpty) 'subject': mailtoSubject,
        if (mailtoBody.isNotEmpty) 'body': mailtoBody,
      }),
    );
    await openLink(emailLaunchUri);
  }
}

String? _encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map(
        (MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
      )
      .join('&');
}
