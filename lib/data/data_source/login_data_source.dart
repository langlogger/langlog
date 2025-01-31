import 'package:firebase_auth/firebase_auth.dart';
import 'package:langlog/data/dto/user_data.dto.dart';

abstract interface class LoginDataSource {
  Future<void> uploadUserData(UserCredential userCredential);

  Future<bool> deleteUser();

  Future<void> sendFeedback(String text);

  Stream<UserDataDto?> fetchUser();

  Future<void> updateVisitCount();
}
