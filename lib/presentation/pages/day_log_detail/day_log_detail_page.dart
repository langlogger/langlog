import 'package:flutter/material.dart';
import 'package:langlog/domain/entity/day_log.dart';
import 'package:langlog/presentation/pages/day_log_detail/widgets/day_log_detail_app_bar.dart';
import 'package:langlog/presentation/pages/day_log_detail/widgets/foreign_detail_view.dart';
import 'package:langlog/presentation/pages/day_log_detail/widgets/native_detail_view.dart';

class DayLogDetailPage extends StatefulWidget {
  DayLog dayLog;
  DayLogDetailPage(this.dayLog, {super.key});

  @override
  State<DayLogDetailPage> createState() => _DayLogDetailPageState();
}

class _DayLogDetailPageState extends State<DayLogDetailPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  /// 모국어로 작성되어 있는지 체크
  late bool isWrittenNativeDayLog;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    isWrittenNativeDayLog = widget.dayLog.native != null ? true : false;
    // 모국어 일기가 작성되어 있지 않으면 tab bar 비활성화
    if (!isWrittenNativeDayLog) {
      _tabController.addListener(() {
        if (_tabController.index == 1) {
          setState(() {
            _tabController.index = 0;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DayLogDetailAppBar(
        dayLog: widget.dayLog,
        tabController: _tabController,
        isWrittenNativeDayLog: isWrittenNativeDayLog,
      ),
      body: TabBarView(
        // 스크롤로 tab 변경 금지
        physics: NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [
          ForeignDetailView(dayLog: widget.dayLog),
          NativeDetailView(dayLog: widget.dayLog),
        ],
      ),
    );
  }
}
