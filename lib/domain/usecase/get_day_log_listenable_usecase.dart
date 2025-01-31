import 'package:flutter/foundation.dart';
import 'package:langlog/domain/repository/day_log_repository.dart';

class GetDayLogListenableUsecase {
  final DayLogRepository repository;
  GetDayLogListenableUsecase(this.repository);

  Future<ValueListenable> execute() async {
    return await repository.getDayLogListenable();
  }
}
