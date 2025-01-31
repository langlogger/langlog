import 'package:hive/hive.dart';

part 'log_contents_dto.g.dart';

@HiveType(typeId: 1)
class LogContentsDto extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String contents;

  LogContentsDto({
    required this.title,
    required this.contents,
  });
}
