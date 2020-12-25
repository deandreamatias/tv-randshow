import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:tv_randshow/core/utils/constants.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      key: const Key('app.privacy.scroll'),
      physics: const BouncingScrollPhysics(),
      child: FutureBuilder<String>(
        future: rootBundle.loadString(Assets.PRIVACY_POLICY),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          return snapshot.hasData
              ? MarkdownBody(
                  data: snapshot.data,
                  onTapLink: (text, href, title) async {
                    try {
                      await launch(href);
                      log('Launched: $href');
                    } catch (e) {
                      throw 'Could not launch $href because $e';
                    }
                  },
                  selectable: true,
                )
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
