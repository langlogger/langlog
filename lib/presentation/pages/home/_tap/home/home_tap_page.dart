import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langlog/core/l_date_format.dart';
import 'package:langlog/presentation/pages/home/_tap/home/home_tap_view_model.dart';
import 'package:langlog/presentation/pages/home/_tap/home/widgets/calendar.dart';
import 'package:langlog/presentation/pages/home/_tap/home/widgets/home_tap_app_bar.dart';
import 'package:langlog/presentation/pages/home/_tap/home/widgets/home_tap_floating_button.dart';
import 'package:langlog/presentation/pages/home/_tap/home/widgets/home_tap_top_view.dart';
import 'package:langlog/presentation/pages/my/my_page_view_model.dart';

class HomeTapPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<HomeTapPage> createState() => _HomeTapPageState();
}

class _HomeTapPageState extends ConsumerState<HomeTapPage> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeTapViewModelProvider);
    DateTime date = state.calendarViewDate ?? DateTime.now();
    final headerTitle = LDateFormat.calendarHeaderFormat(date);
    
    //user 정보 가져오기
    final user = ref.watch(myPageViewModel);
    //마지막으로 로그인한 시점과 오늘 날짜 비교
    String lastLogin = LDateFormat.dayLogFormat(user.lastLogin);
    String today = LDateFormat.dayLogFormat(DateTime.now());
    //lastlogin이 오늘 날짜와 다르면 update.
    if (lastLogin != today) {
      ref.read(myPageViewModel.notifier).updateVisitCount();
    }

    return Scaffold(
      appBar: HomeTapAppBar(headerTitle: headerTitle),
      // 처음 날짜를 사용자의 가입 날짜로 할지?
      body: Column(
        children: [
          // TODO: 1.0.0 배포 준비
          // const SizedBox(height: 20),
          // HomeTapTopView(),
          SizedBox(height: 20),
          Calendar(headerSelectedDate: date),
        ],
      ),
      floatingActionButton: HomeTapFloatingButton(),
    );
  }
}
