import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

Future<UserCredential?> signInWithApple(BuildContext context) async {
  try {
    //애플 로그인창 띄우고 로그인
    final AuthorizationCredentialAppleID appleCredential =
        await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    //OAuth 생성
    final OAuthCredential userOAuthCredential =
        OAuthProvider('apple.com').credential(
      idToken: appleCredential.identityToken,
      accessToken: appleCredential.authorizationCode,
    );

    //firebase유저 생성
    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(userOAuthCredential);

    print('${userCredential.user!.email}');

    return userCredential;
  } catch (e) {
    print(e);
  }
}

//인증 과정 보안 강화하기 위한 보안 요소
String getNonce() {
  const charset =
      '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';

  final random = List<int>.generate(
    32,
    (_) => charset.codeUnitAt(
      (Random().nextDouble() * charset.length).floor(),
    ),
  );

  final bytes = utf8.encode(
    String.fromCharCodes(random),
  );

  final sha256Nonce = sha256.convert(bytes).toString();

  return sha256Nonce;
}
