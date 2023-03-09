import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:tv_randshow/ui/shared/assets.dart';
import 'package:tv_randshow/ui/shared/helpers/helpers.dart';
import 'package:tv_randshow/ui/widgets/image_builder.dart';
import 'package:tv_randshow/ui/widgets/loader.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          key: const Key('app.privacy.scroll'),
          physics: const BouncingScrollPhysics(),
          child: FutureBuilder<String>(
            future: rootBundle.loadString(Assets.privacyPolicy),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              return snapshot.hasData
                  ? Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text(translate('app.privacy.button_back')),
                          ),
                        ),
                        MarkdownBody(
                          data: snapshot.data ?? '',
                          imageBuilder: (uri, title, alt) => OnlineImage(
                            url: uri.toString(),
                            name: title ?? 'No name',
                          ),
                          onTapLink: (text, href, title) async {
                            Helpers.openLink(Uri.parse(href ?? ''));
                          },
                          selectable: true,
                        ),
                      ],
                    )
                  : const Loader();
            },
          ),
        ),
      ),
    );
  }
}
