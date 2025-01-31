import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langlog/data/data_source/login_data_source.dart';
import 'package:langlog/data/data_source/login_data_source_impl.dart';
import 'package:langlog/data/repository/login_repository_impl.dart';
import 'package:langlog/domain/repository/login_repository.dart';
import 'package:langlog/domain/usecase/create_user_data_usecase.dart';

final _loginDataSourceProvider = Provider<LoginDataSource>((ref) {
  return LoginDataSourceImpl();
});

final _loginRepositoryProvider = Provider<LoginRepository>((ref) {
  final dataSource = ref.read(_loginDataSourceProvider);
  return LoginRepositoryImpl(dataSource);
});

final createUserDataUsecaseProvider = Provider<CreateUserDataUsecase>((ref) {
  final userRepo = ref.read(_loginRepositoryProvider);
  return CreateUserDataUsecase(userRepo);
});
