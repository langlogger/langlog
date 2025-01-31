import 'package:flutter/foundation.dart';
import 'package:langlog/domain/entity/day_log.dart';

abstract class DayLogRepository {
  Future<void> addDayLogItem(DayLog dayLog);
  Future<DayLog?> getDayLogItem(String key);
  Future<void> deleteDayLogItem(String key);
  Future<List<DayLog>> getAllDayLogList();
  Future<ValueListenable> getDayLogListenable();
  Future<List<DayLog>> getDayLogMonthList(String month);
}
