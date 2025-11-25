import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tv_randshow/ui/shared/assets.dart';
import 'package:tv_randshow/ui/shared/constants.dart';
import 'package:tv_randshow/ui/shared/helpers/helpers.dart';
import 'package:tv_randshow/ui/shared/styles.dart';
import 'package:tv_randshow/ui/widgets/text_title_large.dart';
import 'package:tv_randshow/ui/widgets/text_title_medium.dart';
import 'package:unicons/unicons.dart';

final _createdPrivacy = DateTime(2020, 12, 25);
final _modifiedPrivacy = DateTime(2023, 03, 16);

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr('app.privacy.title')),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(UniconsLine.arrow_left),
        ),
      ),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(Styles.standard),
          key: const Key('app.privacy.scroll'),
          physics: const BouncingScrollPhysics(),
          children: [
            // Creator section.
            TextTitleLarge(context.tr('app.privacy.subtitle_who')),
            const SizedBox(height: Styles.small),
            Text(context.tr('app.privacy.text_who')),
            const SizedBox(height: Styles.standard),
            // Permissions section.
            TextTitleLarge(context.tr('app.privacy.subtitle_permissions')),
            const SizedBox(height: Styles.small),
            Text(context.tr('app.privacy.text_permissions_1')),
            Text(context.tr('app.privacy.text_permissions_2')),
            const SizedBox(height: Styles.standard),
            // Contact section.
            TextTitleLarge(context.tr('app.privacy.subtitle_contact')),
            const SizedBox(height: Styles.small),
            Text(context.tr('app.privacy.text_contact_1')),
            const SizedBox(height: Styles.small),
            RichText(
              text: TextSpan(
                text: '${context.tr('app.privacy.text_contact_2')} ',
                style: textTheme.bodyMedium,
                children: [
                  TextSpan(
                    text: '${Constants.feedbackEmail} ',
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer:
                        TapGestureRecognizer()
                          ..onTap = () {
                            Helpers.openMail(Constants.feedbackEmail);
                          },
                  ),
                  TextSpan(
                    text: context.tr('app.privacy.text_contact_3'),
                    style: textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: Styles.standard),
            // About section.
            TextTitleLarge(context.tr('app.privacy.subtitle_about')),
            const SizedBox(height: Styles.small),
            TextTitleMedium(context.tr('app.privacy.header_about_first')),
            const SizedBox(height: Styles.small),
            Align(
              alignment: Alignment.centerLeft,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600, maxHeight: 80),
                child: Image.asset(Assets.tmdbImage),
              ),
            ),
            const SizedBox(height: Styles.small),
            Text(context.tr('app.privacy.text_about_first_2')),
            const SizedBox(height: Styles.standard),
            TextTitleMedium(context.tr('app.privacy.header_about_second')),
            RichText(
              text: TextSpan(
                text: '${context.tr('app.privacy.text_about_second_1')} ',
                style: textTheme.bodyMedium,
                children: [
                  TextSpan(
                    text: context.tr('app.privacy.text_about_second_2'),
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer:
                        TapGestureRecognizer()
                          ..onTap = () {
                            Helpers.openLink(Uri.parse(Constants.repository));
                          },
                  ),
                ],
              ),
            ),
            Text(
              context.tr('app.privacy.text_about_second_3'),
              style: textTheme.bodyMedium,
            ),
            const SizedBox(height: Styles.standard),
            // Changes section.
            TextTitleLarge(context.tr('app.privacy.changes')),
            const SizedBox(height: Styles.small),
            Text(
              context.tr(
                'app.privacy.created',
                namedArgs: {'date': _createdPrivacy.toString()},
              ),
            ),
            Text(
              context.tr(
                'app.privacy.modified',
                namedArgs: {'date': _modifiedPrivacy.toString()},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
