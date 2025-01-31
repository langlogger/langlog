import 'package:flutter/material.dart';
import 'package:langlog/constant/custom_style.dart';
import 'package:langlog/core/l_date_format.dart';
import 'package:langlog/domain/entity/log_contents.dart';

class DayLogBox extends StatelessWidget {
  LogContents logContents;
  String date;
  DayLogBox(this.logContents, this.date);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 28),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          border: Border(
            top: BorderSide(color: CustomColors.grey_300),
            right: BorderSide(color: CustomColors.grey_300),
            left: BorderSide(color: CustomColors.grey_300),
          ),
          color: CustomColors.white),
      child: dayLogContent(),
    );
  }

  ListView dayLogContent() {
    return ListView(
      children: [
        Text(
          logContents.title,
          style: CustomText.body_01_M.copyWith(color: CustomColors.grey_700),
        ),
        SizedBox(height: 10),
        Text(
          LDateFormat.dayLogFormat(DateTime.parse(date)),
          style: CustomText.caption_01_M.copyWith(color: CustomColors.grey_400),
        ),
        SizedBox(height: 10),
        Text(
          logContents.contents,
          style: CustomText.body_01_M.copyWith(color: CustomColors.grey_700),
        ),
      ],
    );
  }
}
