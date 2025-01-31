import 'package:firebase_auth/firebase_auth.dart';
import 'package:langlog/data/data_source/login_data_source.dart';
import 'package:langlog/domain/entity/user_data.dart';
import 'package:langlog/domain/repository/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  LoginRepositoryImpl(this._loginDataSource);
  final LoginDataSource _loginDataSource;

  @override
  Future<void> uploadUserData(UserCredential userCredential) async {
    try {
      await _loginDataSource.uploadUserData(userCredential);
    } catch (e) {
      throw Exception('failed to upload user data: $e');
    }
  }

  @override
  Future<bool> deleteUser() async {
    try {
      final result = await _loginDataSource.deleteUser();
      return result;
    } catch (e) {
      throw Exception('failed to delete user data: $e');
    }
  }

  @override
  Future<void> sendUserOpinion(String text) async {
    try {
      await _loginDataSource.sendFeedback(text);
    } catch (e) {
      throw Exception('failed to upload feedback data: $e');
    }
  }

  @override
  Stream<UserData?> fetchUser() {
    return _loginDataSource.fetchUser().map((userDataDto) {
      return userDataDto == null ? null : UserData.fromDto(userDataDto);
    });
  }

  Future<void> updateVisitCount() async {
    try {
      await _loginDataSource.updateVisitCount();
    } catch (e) {
      throw Exception('failed to update VisitCount: $e');
    }
  }
}
