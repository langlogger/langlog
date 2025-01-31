import 'package:flutter/material.dart';
import 'package:langlog/constant/custom_style.dart';
import 'package:langlog/core/l_date_format.dart';
import 'package:langlog/domain/entity/day_log.dart';
import 'package:langlog/presentation/pages/day_log_detail/widgets/day_log_delete_icon.dart';
import 'package:langlog/presentation/widgets/custom_app_bar.dart';

class DayLogDetailAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  DayLog dayLog;
  TabController tabController;
  bool isWrittenNativeDayLog;

  DayLogDetailAppBar({
    super.key,
    required this.dayLog,
    required this.tabController,
    required this.isWrittenNativeDayLog,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: LDateFormat.dayLogFormat(DateTime.parse(dayLog.date)),
      bottom: TabBar(
        // tab bar indicator 크기
        indicatorSize: TabBarIndicatorSize.tab,
        // tab bar 분리되어 있는 색상
        dividerColor: CustomColors.grey_200,
        // divider 높이
        dividerHeight: 2,
        // tab bar 누를 때 나오는 splash 색상
        overlayColor: WidgetStatePropertyAll(
          isWrittenNativeDayLog ? CustomColors.bg_100 : Colors.transparent,
        ),
        controller: tabController,
        tabs: <Widget>[
          _tab('English'),
          _tab('한국어', isWritten: isWrittenNativeDayLog),
        ],
      ),
      actions: [
        DayLogDeleteIcon(
          dayLogKey: dayLog.keyDate,
        ),
      ],
    );
  }

  Tab _tab(String text, {bool isWritten = true}) {
    return Tab(
      icon: Text(
        text,
        style: isWritten
            ? CustomText.header_02_SB
            : CustomText.header_02_SB.copyWith(color: CustomColors.grey_400),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(100);
}
