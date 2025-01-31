import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langlog/domain/entity/log_contents.dart';
import 'package:langlog/presentation/pages/day_log_write/day_log_view_model.dart';
import 'package:langlog/presentation/pages/day_log_write/pages/day_log_write_foreign_page.dart';
import 'package:langlog/presentation/pages/day_log_write/widgets/topic_recommendation_box.dart';
import 'package:langlog/presentation/pages/day_log_write/widgets/write_log_box.dart';
import 'package:langlog/presentation/widgets/custom_app_bar.dart';

class DayLogWriteNativePage extends ConsumerWidget {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dayLogViewModelProvider);
    return Scaffold(
      appBar: CustomAppBar(
        title: "데이로그",
        actions: [
          nextButton(context),
        ],
      ),
      body: Column(
        children: [
          // 주제 추천 박스
          TopicRecommendationBox(),

          // 일기 작성 공간
          WriteLogBox(
            titleController: titleController,
            contentController: contentController,
            isNative: true,
            todayDate: state.date,
          ),
        ],
      ),
    );
  }

  IconButton nextButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        final dayLog = LogContents(
          title: titleController.text,
          contents: contentController.text,
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DayLogWriteForeignPage(dayLog),
          ),
        );
      },
      icon: Text("다음"),
    );
  }
}
