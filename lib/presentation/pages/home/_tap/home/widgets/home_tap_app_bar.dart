import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:langlog/constant/custom_style.dart';
import 'package:langlog/presentation/pages/home/_tap/home/home_tap_view_model.dart';
import 'package:langlog/presentation/pages/home/_tap/home/widgets/calendar_date_pick_dialog.dart';
import 'package:langlog/presentation/pages/home/widgets/home_my_page_icon.dart';

class HomeTapAppBar extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  const HomeTapAppBar({
    super.key,
    required this.headerTitle,
  });

  final String headerTitle;

  @override
  ConsumerState<HomeTapAppBar> createState() => _HomeTapAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _HomeTapAppBarState extends ConsumerState<HomeTapAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: _todayButton(),
      leadingWidth: 75,
      title: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return CalendarDatePickDialog();
            },
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 10),
            Text(
              widget.headerTitle,
              style: CustomText.header_03_SB,
            ),
            SvgPicture.asset('assets/icons/basic/24/ic_caret_down_small.svg'),
          ],
        ),
      ),
      actions: [
        HomeMyPageIcon(),
      ],
    );
  }

  Container _todayButton() {
    return Container(
      height: 20,
      padding: const EdgeInsets.only(left: 20),
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: FilledButton(
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          textStyle: CustomText.body_02_SB,
          padding: EdgeInsets.only(
            bottom: 3,
            left: 1,
            right: 0,
            top: 0,
          ),
        ),
        onPressed: () {
          ref
              .read(homeTapViewModelProvider.notifier)
              .setCalendarViewDateToday();
        },
        child: Text('Today'),
      ),
    );
  }
}
