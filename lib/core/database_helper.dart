import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class DatabaseHelper {
  Future<void> initializeDatabase();
  Future<Box<T>> openBox<T>(String boxName);
  Future<void> add<T>(String boxName, String key, T value);
  Future<T?> get<T>(String boxName, String key);
  Future<void> delete<T>(String boxName, String key);
  Future<void> closeBox<T>(String boxName);
  Future<Iterable<T>> getAll<T>(String boxName);
  Future<ValueListenable> getListenable<T>(String boxName);
}
