import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:langlog/constant/custom_style.dart';
import 'package:langlog/domain/entity/day_log.dart';

class ForeignDetailView extends StatelessWidget {
  const ForeignDetailView({
    super.key,
    required this.dayLog,
  });

  final DayLog dayLog;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          Row(
            children: [
              SvgPicture.asset(
                  'assets/icons/emotion/36/ic_${dayLog.emotion.code}.svg'),
            ],
          ),
          SizedBox(height: 20),
          Text(
            dayLog.foreign!.title,
            style: CustomText.body_01_M,
          ),
          SizedBox(height: 12),
          Text(
            // dayLog.foreign!.contents,
            dayLog.correctionResult ?? dayLog.foreign!.contents,
            style: CustomText.body_01_M,
          ),
        ],
      ),
    );
  }
}
