import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langlog/constant/custom_style.dart';
import 'package:langlog/constant/dialog_messages.dart';
import 'package:langlog/core/l_date_format.dart';
import 'package:langlog/presentation/pages/day_log_write/day_log_view_model.dart';
import 'package:langlog/presentation/pages/day_log_write/widgets/correction_result_list_view.dart';
import 'package:langlog/presentation/widgets/custom_app_bar.dart';
import 'package:langlog/presentation/widgets/custom_dialog.dart';

class DayLogCorrectionResultPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.read(dayLogViewModelProvider.notifier);
    final state = ref.watch(dayLogViewModelProvider);

    return Scaffold(
      appBar: CustomAppBar(
        title: "AI 문장 교정",
      ),
      body: Column(
        children: [
          resultBar(state.date, state.correctionSentence?.length ?? 0),

          // 교정 문장 목록
          CorrectionResultListView(),

          // 버튼 모음
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // listenAndSpeakingButton(),
                // SizedBox(height: 10),
                finishButton(context, vm),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget resultBar(String date, int count) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 25, bottom: 5, right: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            LDateFormat.dayLogFormat(DateTime.parse(date)),
            style: CustomText.header_02_SB,
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '총 ', // 기본 텍스트
                  style: CustomText.body_02_M,
                ),
                TextSpan(
                  text: '$count', // 강조할 텍스트
                  style: CustomText.body_02_M
                      .copyWith(color: Colors.red), // 빨간색 스타일 적용
                ),
                TextSpan(
                  text: '문장', // 기본 텍스트
                  style: CustomText.body_02_M,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SizedBox finishButton(BuildContext context, DayLogViewModel vm) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return CustomDialog(
                title: DAY_LOG_FINISH_DIALOG.title,
                content: DAY_LOG_FINISH_DIALOG.content,
                cancleLabel: DAY_LOG_FINISH_DIALOG.cancleLabel,
                confirmLabel: DAY_LOG_FINISH_DIALOG.confirmLabel,
                onConfirm: () {
                  // 일기 저장
                  vm.saveDayLog();

                  // 초기화면으로
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
              );
            },
          );
        },
        child: Text("완료"),
      ),
    );
  }

  SizedBox listenAndSpeakingButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {},
        child: Text("듣고 읽어보기"),
      ),
    );
  }
}
