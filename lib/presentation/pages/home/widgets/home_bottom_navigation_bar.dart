import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:langlog/constant/custom_style.dart';
import 'package:langlog/presentation/pages/home/home_view_model.dart';

class HomeBottomNavigationBar extends ConsumerWidget {
  final String homePath = 'assets/icons/navigation/32/ic_home.svg';
  final String mylogPath = 'assets/icons/navigation/32/ic_mylog.svg';
  final String bookmarkPath = 'assets/icons/navigation/32/ic_bookmark.svg';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeViewModel);
    final vm = ref.read(homeViewModel.notifier);

    return BottomNavigationBar(
      currentIndex: state.tapIndex,
      onTap: vm.onIndexChanged,
      selectedItemColor: CustomColors.black,
      unselectedItemColor: CustomColors.grey_400,
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(homePath, colorFilter: _inactiveColor()),
          activeIcon: SvgPicture.asset(homePath, colorFilter: _activeColor()),
          label: "홈",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(mylogPath, colorFilter: _inactiveColor()),
          activeIcon: SvgPicture.asset(mylogPath, colorFilter: _activeColor()),
          label: "마이로그",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(bookmarkPath, colorFilter: _inactiveColor()),
          activeIcon:
              SvgPicture.asset(bookmarkPath, colorFilter: _activeColor()),
          label: "북마크",
        ),
      ],
    );
  }

  /// 눌렀을 때 아이콘 색상
  ColorFilter _activeColor() {
    return ColorFilter.mode(
      CustomColors.black,
      BlendMode.srcIn,
    );
  }

  /// 안눌렀을 때 아이콘 색상
  ColorFilter _inactiveColor() {
    return ColorFilter.mode(
      CustomColors.grey_400,
      BlendMode.srcIn,
    );
  }
}
