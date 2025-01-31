import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeState {
  int tapIndex;

  HomeState({required this.tapIndex});

  HomeState copyWith({
    int? tapIndex,
  }) {
    return HomeState(
      tapIndex: tapIndex ?? this.tapIndex,
    );
  }
}

class HomeViewModel extends Notifier<HomeState> {
  @override
  HomeState build() {
    return HomeState(tapIndex: 0);
  }

  void onIndexChanged(int newIndex) {
    if (newIndex == 0) {
      state = state.copyWith(tapIndex: newIndex);
    } else {
      state = HomeState(tapIndex: newIndex);
    }
  }
}

final homeViewModel = NotifierProvider<HomeViewModel, HomeState>(
  () => HomeViewModel(),
);
