import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:langlog/presentation/pages/emotion_mood/emotion_mood_page.dart';
import 'package:langlog/presentation/pages/home/_tap/home/home_tap_view_model.dart';

class HomeTapFloatingButton extends ConsumerWidget {
  const HomeTapFloatingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: 나중에 모닝로그랑 일기작성 페이지로 이동할 수 있게 두개로 분리하기
    return FloatingActionButton.extended(
      onPressed: () => _onPressed(ref, context),
      label: Container(
        height: 56,
        width: 56,
        decoration: BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
        ),
        child: _pencileIcon(),
      ),
    );
  }

  /// 오늘 일기 작성안하면 작성 페이지로, 작성했으면 추가 작성 금지
  void _onPressed(WidgetRef ref, BuildContext context) {
    final isWrittenToday =
        ref.read(homeTapViewModelProvider).isWrittenDayLogToday;

    if (isWrittenToday) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("일기는 하루에 하나만 작성할 수 있어요!"),
          duration: Duration(seconds: 5),
        ),
      );
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return EmotionMoodPage();
      }));
    }
  }

  SvgPicture _pencileIcon() {
    return SvgPicture.asset(
      'assets/icons/basic/24/ic_pencile.svg',
      colorFilter: ColorFilter.mode(
        Colors.white,
        // 소스 이미지와 대상 이미지가 교차하는 부분만 소스 이미지 그림
        BlendMode.srcIn,
      ),
      fit: BoxFit.none,
    );
  }
}
