import 'package:flutter/material.dart';
import 'package:tv_randshow/core/streaming/domain/models/streaming.dart';
import 'package:tv_randshow/ui/shared/helpers/helpers.dart';

class StreamingButton extends StatelessWidget {
  final StreamingDetail streamingDetail;
  const StreamingButton({super.key, required this.streamingDetail});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        Helpers.openLink(Uri.parse(streamingDetail.link));
      },
      child: Text(
        streamingDetail.streamingName.toUpperCase(),
        key: const Key('app.result.button_streaming'),
      ),
    );
  }
}
