import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:langlog/data/data_source/login_data_source.dart';
import 'package:langlog/data/dto/user_data.dto.dart';

class LoginDataSourceImpl implements LoginDataSource {
  //사용자 정보 파이어베이스에 업로드
  @override
  Future<void> uploadUserData(UserCredential userCredential) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final user = userCredential.user;

      if (user != null) {
        final userDocRef = firestore.collection('user').doc(user.uid);
        final userDoc = await userDocRef.get();

        if (userDoc.exists) {
          //사용자가 존재할 때
        } else {
          //존재하지 않으면 사용자 정보 업로드
          await userDocRef.set({
            'uid': user.uid,
            'email': user.email,
            'joinDate': user.metadata.creationTime,
            'lastLogin': user.metadata.lastSignInTime,
            'visitCount': 1,
          });
        }
      }
    } catch (e) {
      print(e);
    }
  }

  //계정 탈퇴시 유저 정보 삭제
  @override
  Future<bool> deleteUser() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser == null) return false;

      final googleUser = await GoogleSignIn().signIn();
      final googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // 재인증
      await currentUser.reauthenticateWithCredential(credential);
      final firestore = FirebaseFirestore.instance;
      final userRef = firestore.collection('user').doc(currentUser.uid);

      await userRef.delete();
      await currentUser.delete();

      return true;
    } catch (e) {
      print("UserDataSourceImpl::removeUser $e");
      return false;
    }
  }

  //유저 피드백 업로드
  @override
  Future<void> sendFeedback(String text) async {
    try {
      final firestore = FirebaseFirestore.instance;
      await firestore.collection('feedback').add({'feedback': text});
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateVisitCount() async {
    try {
      final firestore = FirebaseFirestore.instance;
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        final userDocRef = firestore.collection('user').doc(user.uid);
        final userDoc = await userDocRef.get();

        //유저 정보가 존재할 때 visitCount를 가져와서 +1 해줌
        if (userDoc.exists) {
          final int visitCount = userDoc.get('visitCount');
          await userDocRef.update({
            'lastLogin':DateTime.now(),
            'visitCount': visitCount + 1,
          });
        }
      }
    } catch (e) {
      print(e);
    }
  }

  //user정보 가져오기
  @override
  Stream<UserDataDto?> fetchUser() {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        throw Exception('User is not signed in.');
      }
      final firestore = FirebaseFirestore.instance;
      final collectionRef = firestore.collection('user');
      final query = collectionRef.doc(user.uid);

      return query.snapshots().map((snapshot) {
        if (snapshot.exists) {
          return UserDataDto.fromMap(snapshot.data()!);
        }
        return null;
      });
    } catch (e) {
      throw Exception('No user found with uid: $e');
    }
  }
}
