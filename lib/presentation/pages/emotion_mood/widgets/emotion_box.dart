import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:langlog/constant/custom_style.dart';
import 'package:langlog/domain/entity/emotion.dart';
import 'package:langlog/presentation/pages/emotion_mood/emotion_mood_view_model.dart';

class EmotionBox extends StatefulWidget {
  EmotionBox({super.key, required this.emotion});
  Emotion emotion;

  @override
  State<EmotionBox> createState() => _EmotionBoxState();
}

class _EmotionBoxState extends State<EmotionBox> {
  final String iconPrePath = 'assets/icons/emotion/80/ic_';

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final vm = ref.watch(emotionMoodViewModelProvider.notifier);
        final state = ref.watch(emotionMoodViewModelProvider);
        // 선택한 이모티콘 체크
        bool isSelected = widget.emotion == state;

        final String emotionPath = '${widget.emotion.code}.svg';

        return GestureDetector(
          onTap: () => vm.changeMood(widget.emotion),
          child: Container(
            height: 120,
            width: 100,
            padding: EdgeInsets.all(4),
            color: Colors.transparent,
            child: Column(
              children: [
                emtionIcon(isSelected, emotionPath),
                const SizedBox(height: 8),
                emotionText(isSelected),
              ],
            ),
          ),
        );
      },
    );
  }

  /// 감정 텍스트
  Text emotionText(bool isSelected) {
    return Text(
      widget.emotion.displayName,
      style: isSelected
          ? CustomText.caption_01_SB.copyWith(color: CustomColors.black)
          : CustomText.caption_01_M.copyWith(color: CustomColors.grey_600),
    );
  }

  /// 감정 아이콘
  Container emtionIcon(bool isSelected, String emotionPath) {
    return Container(
      decoration: isSelected
          ? BoxDecoration(
              border: Border.all(color: CustomColors.grey_600, width: 1.5),
              borderRadius: BorderRadius.circular(100),
            )
          : null,
      child: SvgPicture.asset('$iconPrePath$emotionPath'),
    );
  }
}
