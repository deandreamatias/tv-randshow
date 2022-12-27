import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tv_randshow/core/streaming/domain/models/streaming.dart';
import 'package:url_launcher/url_launcher.dart';

class StreamingButton extends StatelessWidget {
  final StreamingDetail streamingDetail;
  const StreamingButton({Key? key, required this.streamingDetail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () async {
        if (await canLaunch(streamingDetail.link)) {
          await launch(streamingDetail.link);
          log('Launched: ${streamingDetail.link}');
        } else {
          throw 'Could not launch ${streamingDetail.link}';
        }
      },
      child: Text(
        streamingDetail.streamingName.toUpperCase(),
        key: const Key('app.result.button_streaming'),
      ),
    );
  }
}
