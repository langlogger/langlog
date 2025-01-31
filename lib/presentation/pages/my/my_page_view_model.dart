import 'dart:async';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langlog/domain/entity/user_data.dart';
import 'package:langlog/domain/usecase/create_user_data_usecase.dart';
import 'package:langlog/providers/login_provider.dart';

class MyPageViewModel extends Notifier<UserData> {
  @override
  UserData build() {

    state = UserData(
      email: '',
      uid: '',
      joinDate:DateTime.now(),
      lastLogin: DateTime.now(),
      visitCount: 0,
    );

    ref.read(createUserDataUsecaseProvider).fetchUser().listen((user) {
      state = user!;
    });

    return state; 
  }

    Future<void> updateVisitCount() async {
    await ref.read(createUserDataUsecaseProvider).updateVisitCount();
  }

  
}

final myPageViewModel =
    NotifierProvider<MyPageViewModel, UserData>(() => MyPageViewModel());