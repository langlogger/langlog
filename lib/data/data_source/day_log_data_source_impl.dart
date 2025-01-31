import 'package:flutter/src/foundation/change_notifier.dart';
import 'package:langlog/core/hive_database_helper.dart';
import 'package:langlog/data/data_source/day_log_data_source.dart';
import 'package:langlog/data/dto/day_log_dto.dart';

class DayLogDataSourceImpl implements DayLogDataSource {
  final HiveDatabaseHelper databaseHelper;
  DayLogDataSourceImpl(this.databaseHelper);

  final BOX_NAME = 'day_log';

  @override
  Future<void> addDayLogItem(String key, DayLogDto dayLog) async {
    await databaseHelper.add(BOX_NAME, key, dayLog);
  }

  @override
  Future<void> deleteDayLogItem(String key) async {
    await databaseHelper.delete<DayLogDto>(BOX_NAME, key);
  }

  @override
  Future<DayLogDto?> getDayLogItem(String key) async {
    return await databaseHelper.get(BOX_NAME, key);
  }

  @override
  Future<Iterable<DayLogDto>> getDayLogList() async {
    final Iterable<DayLogDto> iterable = await databaseHelper.getAll(BOX_NAME);
    return iterable;
  }

  @override
  Future<ValueListenable> getDayLogListenable() async {
    return await databaseHelper.getListenable<DayLogDto>(BOX_NAME);
  }

  @override
  Future<List<DayLogDto>> getDayLogMonthList(String month) async {
    return await databaseHelper.getAllByPartialKey(BOX_NAME, month);
  }
}
