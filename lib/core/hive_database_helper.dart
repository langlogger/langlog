import 'package:flutter/src/foundation/change_notifier.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:langlog/core/database_helper.dart';
import 'package:langlog/data/dto/correction_sentence_dto.dart';
import 'package:langlog/data/dto/day_log_dto.dart';
import 'package:langlog/data/dto/log_contents_dto.dart';

class HiveDatabaseHelper implements DatabaseHelper {
  // Hive 초기화, 어댑터 등록
  @override
  Future<void> initializeDatabase() async {
    await Hive.initFlutter();
    Hive.registerAdapter(DayLogDtoAdapter());
    Hive.registerAdapter(LogContentsDtoAdapter());
    Hive.registerAdapter(CorrectionSentenceDtoAdapter());
  }

  @override
  Future<Box<T>> openBox<T>(String boxName) async {
    return await Hive.openBox<T>(boxName);
  }

  @override
  Future<void> add<T>(String boxName, String key, T value) async {
    var box = await openBox<T>(boxName);
    await box.put(key, value);
  }

  @override
  Future<T?> get<T>(String boxName, String key) async {
    var box = await openBox<T>(boxName);
    return box.get(key);
  }

  @override
  Future<void> delete<T>(String boxName, String key) async {
    var box = await openBox<T>(boxName);
    await box.delete(key);
  }

  @override
  Future<void> closeBox<T>(String boxName) async {
    var box = await openBox<T>(boxName);
    await box.close();
  }

  @override
  Future<Iterable<T>> getAll<T>(String boxName) async {
    final box = await openBox<T>(boxName);
    return box.values;
  }

  // 키 값으로 조건범위검색.
  @override
  Future<List<T>> getAllByPartialKey<T>(
    String boxName,
    String partialKey,
  ) async {
    final box = await openBox<T>(boxName);

    List<T> filteredResults = [];

    for (var key in box.keys) {
      if (key.toString().contains(partialKey)) {
        final value = box.get(key);
        if (value != null) {
          filteredResults.add(value);
        }
      }
    }

    return filteredResults;
  }

  Future<void> deleteBox(String boxName) async {
    // 해당 Box를 삭제하고 초기화
    var box = await Hive.openBox(boxName);
    await box.deleteFromDisk();
    print('Box "$boxName" has been deleted from disk.');
  }

  @override
  Future<ValueListenable> getListenable<T>(String boxName) async {
    final box = await openBox<T>(boxName);
    return box.listenable();
  }
}
