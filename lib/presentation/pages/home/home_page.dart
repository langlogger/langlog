import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langlog/presentation/pages/home/_tap/bookmark/bookmark_tap_page.dart';
import 'package:langlog/presentation/pages/home/_tap/home/home_tap_page.dart';
import 'package:langlog/presentation/pages/home/_tap/my_log/my_log_tap_page.dart';
import 'package:langlog/presentation/pages/home/home_view_model.dart';
import 'package:langlog/presentation/pages/home/widgets/home_bottom_navigation_bar.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeViewModel);

    return Scaffold(
      body: IndexedStack(
        index: state.tapIndex,
        children: [
          HomeTapPage(),
          MyLogTapPage(),
          BookmarkTapPage(),
        ],
      ),
      // TODO: 1.0.0 배포 준비
      // bottomNavigationBar: HomeBottomNavigationBar(),
    );
  }
}
