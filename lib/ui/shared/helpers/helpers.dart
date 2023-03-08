import 'package:tv_randshow/ui/shared/helpers/helpers_io.dart'
    if (dart.library.html) 'package:tv_randshow/ui/shared/helpers/helpers_web.dart'
    as helpers;

class Helpers {
  static String getLocale() {
    return helpers.getLocale();
  }
}
