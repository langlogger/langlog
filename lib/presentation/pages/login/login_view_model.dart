import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langlog/providers/login_provider.dart';

class LoginViewModel extends Notifier<void> {
  @override
  void build() {
    // TODO: implement build
  }

  Future<void> uploadUserData(UserCredential userCredential) async {
    await ref
        .read(createUserDataUsecaseProvider)
        .uploadUserData(userCredential);
  }

  Future<bool> deleteUser() async {
    return await ref.read(createUserDataUsecaseProvider).deleteUser();
  }

  Future<void> sendUserOpinion(String text) async {
    await ref.read(createUserDataUsecaseProvider).sendUserOpinion(text);
  }  
}

final loginViewModel = NotifierProvider<LoginViewModel, void>(
  () => LoginViewModel(),
);
