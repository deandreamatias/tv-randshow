import 'package:hive/hive.dart';

part 'streaming_detail_hive.g.dart';

@HiveType(typeId: 2)
class StreamingDetailHive extends HiveObject {
  StreamingDetailHive({
    required this.streamingName,
    this.link = '',
    required this.added,
    required this.leaving,
    required this.country,
  });

  @HiveField(0)
  final String streamingName;
  @HiveField(1)
  final String country;
  @HiveField(2)
  final String link;
  @HiveField(3)
  final int added;
  @HiveField(4)
  final int leaving;
}
