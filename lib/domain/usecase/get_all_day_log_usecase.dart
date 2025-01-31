import 'package:langlog/domain/entity/day_log.dart';
import 'package:langlog/domain/repository/day_log_repository.dart';

class GetAllDayLogUsecase {
  final DayLogRepository repository;
  GetAllDayLogUsecase(this.repository);

  Future<List<DayLog>> execute() async {
    return await repository.getAllDayLogList();
  }
}
