import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langlog/constant/custom_style.dart';
import 'package:langlog/presentation/pages/day_log_write/random_topic_view_model.dart';

class TopicRecommendationBox extends ConsumerStatefulWidget {
  @override
  ConsumerState<TopicRecommendationBox> createState() =>
      _TopicRecommendationBoxState();
}

class _TopicRecommendationBoxState
    extends ConsumerState<TopicRecommendationBox> {
  bool isRecommended = false;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(randomTopicViewModelProvider);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.only(top: 5, bottom: 5, left: 16, right: 8),
      width: double.infinity,
      decoration: BoxDecoration(
        color: CustomColors.vl_100,
        borderRadius: BorderRadius.circular(20),
      ),
      child:
          isRecommended ? afterRecommendation(state) : beforeRecommendation(),
    );
  }

  Widget afterRecommendation(String state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text(state)),
        IconButton(
          onPressed: () async {
            final vm = ref.read(randomTopicViewModelProvider.notifier);
            await vm.getRandomTopic();
          },
          icon: Icon(Icons.refresh),
        ),
      ],
    );
  }

  Widget beforeRecommendation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "일기를 시작하기 힘든가요?",
          style: CustomText.body_02_M,
        ),
        TextButton(
          onPressed: () async {
            final vm = ref.read(randomTopicViewModelProvider.notifier);
            await vm.getRandomTopic();

            setState(() {
              isRecommended = true;
            });
          },
          child: Text(
            "주제 추천받기",
            style: CustomText.body_02_SB.copyWith(color: CustomColors.vl_600),
          ),
        ),
      ],
    );
  }
}
