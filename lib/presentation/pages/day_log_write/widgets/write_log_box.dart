import 'package:flutter/material.dart';
import 'package:langlog/constant/custom_style.dart';
import 'package:langlog/core/l_date_format.dart';

class WriteLogBox extends StatelessWidget {
  TextEditingController titleController;
  TextEditingController contentController;
  bool isNative;
  String todayDate;

  WriteLogBox({
    required this.titleController,
    required this.contentController,
    required this.isNative,
    required this.todayDate,
  });

  @override
  Widget build(BuildContext context) {
    final titleHintText = isNative ? "제목을 입력하세요" : "Title";
    final contentHintText =
        isNative ? "오늘 하루를 모국어로 기록해보세요." : "Record your day in English!";

    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 제목 입력 텍스트필드
            titleTextField(titleController, titleHintText),

            // 날자 표시
            todayText(),

            // 내용 입력 텍스트필드
            contentTextField(contentController, contentHintText),
          ],
        ),
      ),
    );
  }

  TextField contentTextField(
    TextEditingController textController,
    String hintText,
  ) {
    return TextField(
      controller: textController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(0),
        isCollapsed: true,
        hintText: hintText,
        hintStyle: TextStyle(color: CustomColors.grey_400),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
      ),
      style: CustomText.body_01_M,
      maxLines: null,
    );
  }

  Widget todayText() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        LDateFormat.dayLogFormat(DateTime.parse(todayDate)),
        style: CustomText.caption_01_M.copyWith(color: CustomColors.grey_700),
      ),
    );
  }

  TextField titleTextField(
    TextEditingController textController,
    String hintText,
  ) {
    return TextField(
      controller: textController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(0),
        isCollapsed: true,
        hintText: hintText,
        hintStyle: TextStyle(color: CustomColors.grey_400),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
      ),
      style: CustomText.body_01_M,
    );
  }
}
