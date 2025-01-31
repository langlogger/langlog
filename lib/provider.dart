import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langlog/core/hive_database_helper.dart';
import 'package:langlog/data/data_source/day_log_data_source.dart';
import 'package:langlog/data/data_source/day_log_data_source_impl.dart';
import 'package:langlog/domain/repository/day_log_repository.dart';
import 'package:langlog/data/repository/day_log_repository_impl.dart';
import 'package:langlog/domain/usecase/add_day_log_usecase.dart';
import 'package:langlog/domain/usecase/delete_day_log_usecase.dart';
import 'package:langlog/domain/usecase/get_all_day_log_usecase.dart';
import 'package:langlog/domain/usecase/get_day_log_listenable_usecase.dart';
import 'package:langlog/domain/usecase/get_day_log_month_usecase.dart';
import 'package:langlog/domain/usecase/get_day_log_usecase.dart';

final _databaseHelper = Provider<HiveDatabaseHelper>(
  (ref) => HiveDatabaseHelper(),
);
final _dayLogDataSource = Provider<DayLogDataSource>((ref) {
  final databaseHelper = ref.read(_databaseHelper);
  return DayLogDataSourceImpl(databaseHelper);
});
final _dayLogRepository = Provider<DayLogRepository>((ref) {
  final dataSource = ref.read(_dayLogDataSource);
  return DayLogRepositoryImpl(dataSource);
});

final addDayLogUsecaseProvider = Provider<AddDayLogUsecase>((ref) {
  final dayLogRepo = ref.read(_dayLogRepository);
  return AddDayLogUsecase(dayLogRepo);
});
final getDayLogUsecaseProvider = Provider<GetDayLogUsecase>((ref) {
  final dayLogRepo = ref.read(_dayLogRepository);
  return GetDayLogUsecase(dayLogRepo);
});
final deleteDayLogUsecaseProvider = Provider<DeleteDayLogUsecase>((ref) {
  final dayLogRepo = ref.read(_dayLogRepository);
  return DeleteDayLogUsecase(dayLogRepo);
});

final getAllDayLogUsecaseProvider = Provider<GetAllDayLogUsecase>((ref) {
  final dayLogRepo = ref.read(_dayLogRepository);
  return GetAllDayLogUsecase(dayLogRepo);
});

final getAllDayLogListenableUsecaseProvider =
    Provider<GetDayLogListenableUsecase>((ref) {
  final dayLogRepo = ref.read(_dayLogRepository);
  return GetDayLogListenableUsecase(dayLogRepo);
      
    });
final getDayLogMonthUsecaseProvider = Provider<GetDayLogMonthUsecase>((ref) {
  final dayLogRepo = ref.read(_dayLogRepository);
  return GetDayLogMonthUsecase(dayLogRepo);
});
