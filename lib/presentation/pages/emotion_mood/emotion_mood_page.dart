import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:langlog/constant/custom_style.dart';
import 'package:langlog/domain/entity/emotion.dart';
import 'package:langlog/domain/entity/log_contents.dart';
import 'package:langlog/presentation/pages/day_log_write/day_log_view_model.dart';
import 'package:langlog/presentation/pages/day_log_write/pages/day_log_write_foreign_page.dart';
import 'package:langlog/presentation/pages/day_log_write/pages/day_log_write_native_page.dart';
import 'package:langlog/presentation/pages/emotion_mood/emotion_mood_view_model.dart';
import 'package:langlog/presentation/pages/emotion_mood/widgets/emotion_box.dart';
import 'package:langlog/presentation/widgets/custom_app_bar.dart';

class EmotionMoodPage extends ConsumerStatefulWidget {
  const EmotionMoodPage({super.key});

  @override
  ConsumerState<EmotionMoodPage> createState() => _EmotionMoodPageState();
}

class _EmotionMoodPageState extends ConsumerState<EmotionMoodPage> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(emotionMoodViewModelProvider);

    return Scaffold(
      appBar: CustomAppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: SvgPicture.asset('assets/icons/basic/24/ic_x.svg'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const Spacer(),
            // 오늘의 감정은 어떠세요
            _title(),
            const Spacer(),
            _selectedEmotionBox(state),
            const Spacer(),
            _emotionBoxRow(),
            const Spacer(),
            SafeArea(
              child: Column(
                spacing: 8,
                children: [
                  _nextForeignButton(state),
                  _nextNativeButton(state),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Center _title() {
    return Center(
      child: Text(
        '오늘의 감정은 어떠세요?',
        style: CustomText.header_03_SB,
      ),
    );
  }

  /// 선택된 이모티콘 박스
  Column _selectedEmotionBox(Emotion state) {
    final String iconPrePath = 'assets/icons/emotion/112/ic_';
    return Column(
      children: [
        SvgPicture.asset('$iconPrePath${state.code}.svg'),
        const SizedBox(height: 4),
        Text(
          state.displayName,
          style: CustomText.header_01_SB,
        ),
      ],
    );
  }

  /// 선택할 감정 이모티콘
  Widget _emotionBoxRow() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            EmotionBox(emotion: Emotion.happiness),
            EmotionBox(emotion: Emotion.serenity),
            EmotionBox(emotion: Emotion.sorrow),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            EmotionBox(emotion: Emotion.anger),
            EmotionBox(emotion: Emotion.anxiety),
            EmotionBox(emotion: Emotion.frustration),
          ],
        ),
      ],
    );
  }

  /// 내국어로 일기 작성하는 버튼
  Widget _nextNativeButton(Emotion state) {
    bool isSelected = state != Emotion.undefined;
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: !isSelected
            ? null
            : () =>
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DayLogWriteNativePage();
                })),
        style: FilledButton.styleFrom(
          backgroundColor: isSelected ? null : CustomColors.grey_300,
        ),
        child: const Text('한국어 먼저 작성하기'),
      ),
    );
  }

  /// 외국어로 바로 일기 작성하는 버튼
  SizedBox _nextForeignButton(Emotion state) {
    bool isSelected = state != Emotion.undefined;
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: !isSelected
            ? null
            : () =>
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DayLogWriteForeignPage(null);
                })),
        child: Text(
          '영어로만 작성하기',
          style: TextStyle(
            color: isSelected ? null : CustomColors.grey_300,
          ),
        ),
      ),
    );
  }
}
