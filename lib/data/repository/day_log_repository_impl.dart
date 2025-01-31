import 'package:flutter/src/foundation/change_notifier.dart';
import 'package:langlog/data/data_source/day_log_data_source.dart';
import 'package:langlog/data/entity_dto_mapper.dart';
import 'package:langlog/domain/entity/day_log.dart';
import 'package:langlog/domain/repository/day_log_repository.dart';

class DayLogRepositoryImpl implements DayLogRepository {
  final DayLogDataSource dataSource;
  DayLogRepositoryImpl(this.dataSource);

  @override
  Future<void> addDayLogItem(DayLog dayLog) async {
    final dayLogDto = EntityDtoMapper.dayLogToDto(dayLog);
    await dataSource.addDayLogItem(dayLog.keyDate, dayLogDto);
  }

  @override
  Future<void> deleteDayLogItem(String key) async {
    await dataSource.deleteDayLogItem(key);
  }

  @override
  Future<DayLog?> getDayLogItem(String key) async {
    final item = await dataSource.getDayLogItem(key);
    if (item != null) {
      return EntityDtoMapper.dayLogFromDto(item);
    } else {
      return null;
    }
  }

  @override
  Future<List<DayLog>> getAllDayLogList() async {
    final items = await dataSource.getDayLogList();
    return items.map((item) => EntityDtoMapper.dayLogFromDto(item)).toList();
  }
  
  @override
  Future<ValueListenable> getDayLogListenable() async {
    return await dataSource.getDayLogListenable();
  }
    
  @override
  Future<List<DayLog>> getDayLogMonthList(String month) async {
    final items = await dataSource.getDayLogMonthList(month);
    return items.map((item) => EntityDtoMapper.dayLogFromDto(item)).toList();
  }
}
