import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:langlog/presentation/pages/home/home_page.dart';
import 'package:langlog/presentation/pages/login/login_view_model.dart';

Future<UserCredential?> signInWithGoogle(BuildContext context) async {
  try {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    if (googleUser == null) {
      print('구글 계정 연결 실패');
      return null;
    }

    //auth 정보 가져오기
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    //token 값이 유효한지 확인
    if (googleAuth.idToken == null || googleAuth.accessToken == null) {
      throw FirebaseAuthException(
        code: 'missing-credentials',
        message: 'Google authentication failed. Missing tokens.',
      );
    }

    //credential 생성
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Firebase에 로그인
    final userCredential = await auth.signInWithCredential(credential);

    print('Firebase에 로그인 성공 $userCredential');

    return userCredential;
  } catch (e) {
    if (e is FirebaseAuthException) {
      print('FirebaseAuthException: $e');
    } else {
      print('google sign in error: $e');
    }
    return null;
  }
}
