import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:langlog/constant/dialog_messages.dart';
import 'package:langlog/presentation/widgets/custom_dialog.dart';
import 'package:langlog/provider.dart';

class DayLogDeleteIcon extends ConsumerWidget {
  DayLogDeleteIcon({
    super.key,
    required this.dayLogKey,
  });

  String dayLogKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () async {
        showDialog(
          context: context,
          builder: (context) {
            return CustomDialog(
              title: DAY_LOG_DELETE_DIALOG.title,
              content: DAY_LOG_DELETE_DIALOG.content,
              cancleLabel: DAY_LOG_DELETE_DIALOG.cancleLabel,
              confirmLabel: DAY_LOG_DELETE_DIALOG.confirmLabel,
              onConfirm: () async {
                await ref.read(deleteDayLogUsecaseProvider).execute(dayLogKey);
                Navigator.pop(context);
              },
            );
          },
        );
      },
      child: Container(
        margin: EdgeInsets.only(right: 10),
        height: 50,
        width: 50,
        color: Colors.transparent,
        child: SvgPicture.asset(
          'assets/icons/basic/24/ic_delete.svg',
          fit: BoxFit.none,
        ),
      ),
    );
  }
}
