import 'package:langlog/domain/repository/day_log_repository.dart';

class DeleteDayLogUsecase {
  final DayLogRepository repository;
  DeleteDayLogUsecase(this.repository);

  Future<void> execute(String key) async {
    await repository.deleteDayLogItem(key);
  }
}
