import 'package:flutter/foundation.dart';
import 'package:langlog/data/dto/day_log_dto.dart';

abstract interface class DayLogDataSource {
  Future<List<DayLogDto>> getDayLogMonthList(String month);
  Future<Iterable<DayLogDto>> getDayLogList();
  Future<DayLogDto?> getDayLogItem(String key);
  Future<void> addDayLogItem(String key, DayLogDto dayLog);
  Future<void> deleteDayLogItem(String key);
  Future<ValueListenable> getDayLogListenable();
}
