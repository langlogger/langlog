import 'package:langlog/domain/entity/day_log.dart';
import 'package:langlog/domain/repository/day_log_repository.dart';

class GetDayLogUsecase {
  final DayLogRepository repository;
  GetDayLogUsecase(this.repository);

  Future<DayLog?> execute(String key) async {
    return await repository.getDayLogItem(key);
  }
}
