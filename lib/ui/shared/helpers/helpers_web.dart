// Can be ignore this warning because the files that use this helper, use conditional import
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html show window;

String getLocale() {
  return html.window.navigator.language;
}
