import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langlog/constant/dialog_messages.dart';
import 'package:langlog/domain/entity/log_contents.dart';
import 'package:langlog/presentation/pages/day_log_write/pages/day_log_correction_page.dart';
import 'package:langlog/presentation/pages/day_log_write/day_log_view_model.dart';
import 'package:langlog/presentation/widgets/day_log_box.dart';
import 'package:langlog/presentation/pages/day_log_write/widgets/write_log_box.dart';
import 'package:langlog/presentation/widgets/custom_app_bar.dart';
import 'package:langlog/presentation/widgets/custom_dialog.dart';

class DayLogWriteForeignPage extends ConsumerWidget {
  LogContents? nativeLog;
  DayLogWriteForeignPage(this.nativeLog, {super.key});

  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.read(dayLogViewModelProvider.notifier);
    final state = ref.watch(dayLogViewModelProvider);

    return Scaffold(
      appBar: CustomAppBar(
        title: "Day Log",
        actions: [
          nextButton(context, vm),
        ],
      ),
      body: Column(
        children: [
          // 일기 작성 공간
          WriteLogBox(
            titleController: titleController,
            contentController: contentController,
            isNative: false,
            todayDate: state.date,
          ),

          // 모국어 일기 보기
          if (nativeLog != null &&
              (nativeLog!.title.trim().isNotEmpty ||
                  nativeLog!.contents.trim().isNotEmpty))
            nativeLogBox(state.date),
        ],
      ),
    );
  }

  Container nativeLogBox(String date) {
    return Container(
      height: 250,
      child: DayLogBox(nativeLog!, date),
    );
  }

  IconButton nextButton(
    BuildContext context,
    DayLogViewModel vm,
  ) {
    return IconButton(
      onPressed: () {
        if (contentController.text.trim().length > 0) {
          showNextStepDialog(vm, context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("일기가 작성되지 않았습니다."),
              duration: Duration(seconds: 5),
            ),
          );
        }
      },
      icon: Text("다음"),
    );
  }

  void showNextStepDialog(DayLogViewModel vm, BuildContext context) {
    final foreignLog = LogContents(
      title: titleController.text,
      contents: contentController.text,
    );
    vm.setLogContents(nativeLog, foreignLog);
    showDialog(
      context: context,
      builder: (context) {
        return CustomDialog(
          title: DAY_LOG_CONFIRM_DIALOG.title,
          content: DAY_LOG_CONFIRM_DIALOG.content,
          cancleLabel: DAY_LOG_CONFIRM_DIALOG.cancleLabel,
          onCancle: () {
            // 일기 저장
            vm.saveDayLog();

            // 초기화면으로
            Navigator.popUntil(context, (route) => route.isFirst);
          },
          confirmLabel: DAY_LOG_CONFIRM_DIALOG.confirmLabel,
          onConfirm: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DayLogCorrectionPage(),
              ),
            );
          },
        );
      },
    );
  }
}
