import 'package:langlog/domain/entity/day_log.dart';
import 'package:langlog/domain/repository/day_log_repository.dart';

class AddDayLogUsecase {
  final DayLogRepository repository;
  AddDayLogUsecase(this.repository);

  Future<void> execute(DayLog dayLog) async {
    await repository.addDayLogItem(dayLog);
  }
}
