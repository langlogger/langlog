import 'package:flutter/material.dart';
import 'package:langlog/constant/custom_style.dart';

class CustomDialog extends StatelessWidget {
  /// 제목
  String title;

  /// 내용(글자)
  String? content;

  /// 내용(글자 내용 외 위젯)
  Widget? contentsWidget;

  /// 취소 라벨
  String cancleLabel;

  /// 취소 시 실행할 메서드
  VoidCallback? onCancle;

  /// 확인 라벨
  String confirmLabel;

  /// 확인 시 실행할 메서드
  VoidCallback onConfirm;

  CustomDialog({
    required this.title,
    required this.content,
    this.contentsWidget,
    required this.cancleLabel,
    this.onCancle,
    required this.confirmLabel,
    required this.onConfirm,
  });

  // @override
  // Widget build(BuildContext context) {
  //   return AlertDialog(
  //     title: alertTitle(),
  //     content: alertContent(),
  //     actions: [
  //       Row(
  //         children: [
  //           cancleButton(context),
  //           SizedBox(width: 8),
  //           cofirmButton(context),
  //         ],
  //       ),
  //     ],
  //     actionsAlignment: MainAxisAlignment.center,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(16),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: CustomColors.bg_100,
      insetPadding: EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 16),
            alertTitle(),
            SizedBox(height: 16),
            content == null ? SizedBox() : alertContent(),
            contentsWidget == null ? SizedBox() : alertContentsWidget(),
            SizedBox(height: 32),
            Row(
              children: [
                cancleButton(context),
                SizedBox(width: 8),
                cofirmButton(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  SizedBox alertContentsWidget() {
    return SizedBox(
      height: 150,
      child: contentsWidget,
    );
  }

  Expanded cofirmButton(BuildContext context) {
    return Expanded(
      child: FilledButton(
        child: Text(confirmLabel),
        onPressed: () {
          Navigator.of(context).pop();
          onConfirm();
        },
      ),
    );
  }

  Expanded cancleButton(BuildContext context) {
    return Expanded(
      child: OutlinedButton(
        child: Text(cancleLabel),
        onPressed: () {
          Navigator.of(context).pop();
          if (onCancle != null) onCancle!();
        },
      ),
    );
  }

  Text alertContent() {
    return Text(
      content!,
      style: CustomText.body_02_M.copyWith(color: CustomColors.grey_600),
      textAlign: TextAlign.center,
    );
  }

  Text alertTitle() {
    return Text(
      title,
      style: CustomText.header_01_SB.copyWith(color: CustomColors.black),
      textAlign: TextAlign.center,
    );
  }
}
