import 'package:firebase_auth/firebase_auth.dart';
import 'package:langlog/data/dto/user_data.dto.dart';
import 'package:langlog/domain/entity/user_data.dart';

abstract interface class LoginRepository {
  Future<void> uploadUserData(UserCredential userCredential);

  Future<bool> deleteUser();

  Future<void> sendUserOpinion(String text);

  Stream<UserData?> fetchUser();

  Future<void> updateVisitCount();
}
