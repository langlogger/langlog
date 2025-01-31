import 'package:langlog/domain/entity/day_log.dart';
import 'package:langlog/domain/repository/day_log_repository.dart';

class GetDayLogMonthUsecase {
  final DayLogRepository repository;
  GetDayLogMonthUsecase(this.repository);

  Future<List<DayLog>> execute(String month) async {
    return await repository.getDayLogMonthList(month);
  }
}
