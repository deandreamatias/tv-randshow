// Can be ignore this warning because the files that use this helper, use conditional import.
// ignore: avoid_web_libraries_in_flutter
import 'package:web/web.dart' as html;

String getLocale() {
  return html.window.navigator.language;
}
