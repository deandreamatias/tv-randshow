import 'package:hive_ce/hive.dart';
import 'package:tv_randshow/core/tvshow/data/repositories/local_repository.dart';

part 'streaming_detail_hive.g.dart';

@HiveType(typeId: streamingDetailHiveTypeId)
class StreamingDetailHive extends HiveObject {
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
  @HiveField(5)
  final int tvshowId;
  @HiveField(6)
  final String id;

  StreamingDetailHive({
    required this.id,
    required this.streamingName,
    this.link = '',
    required this.added,
    required this.leaving,
    required this.country,
    required this.tvshowId,
  });
}
