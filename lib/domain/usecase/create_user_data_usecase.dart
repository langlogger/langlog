import 'package:firebase_auth/firebase_auth.dart';
import 'package:langlog/domain/entity/user_data.dart';
import 'package:langlog/domain/repository/login_repository.dart';

class CreateUserDataUsecase {
  final LoginRepository _loginRepository;
  CreateUserDataUsecase(this._loginRepository);

  Future<void> uploadUserData(UserCredential userCredential) async {
    return await _loginRepository.uploadUserData(userCredential);
  }

  Future<bool> deleteUser() async {
    return await _loginRepository.deleteUser();
  }

  Future<void> sendUserOpinion(String text) async {
    return await _loginRepository.sendUserOpinion(text);
  }

  Stream<UserData?> fetchUser() {
    return _loginRepository.fetchUser();
  }

  Future<void> updateVisitCount() async {
    return await _loginRepository.updateVisitCount();
  }
}
