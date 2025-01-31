import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:langlog/domain/entity/day_log.dart';
import 'package:langlog/presentation/pages/day_log_detail/day_log_detail_page.dart';
import 'package:langlog/presentation/pages/emotion_mood/emotion_mood_page.dart';
import 'package:langlog/presentation/pages/home/_tap/home/home_tap_view_model.dart';
import 'package:langlog/presentation/pages/home/_tap/my_log/my_log_tap_page.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:collection/collection.dart';

class Calendar extends ConsumerStatefulWidget {
  DateTime headerSelectedDate;
  Calendar({
    super.key,
    required this.headerSelectedDate,
  });

  @override
  ConsumerState<Calendar> createState() => _CalendarState();
}

class _CalendarState extends ConsumerState<Calendar> {
  final DateTime _today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeTapViewModelProvider);
    // for (var log in state.allDayLogs) {
    //   print('log => ${log.toString()}');
    // }

    return TableCalendar(
      // 포커싱 되는 날짜
      focusedDay: widget.headerSelectedDate,
      // 처음 설정한 날짜(이전으로 활성화 안됨)
      firstDay: state.dateOfJoin,
      // 마지막 날짜(이후로 활성화 안됨)
      lastDay: DateTime.now(),
      // 헤더 활성화/비활성화
      headerVisible: false,
      // 날짜 cell 사이즈
      rowHeight: 70,
      // 캘린더 스타일
      calendarStyle: CalendarStyle(
        // 캘린더 padding
        tablePadding: EdgeInsets.symmetric(horizontal: 16),
        // 날짜
        cellAlignment: Alignment.topCenter,
        cellMargin: EdgeInsets.only(top: 5),
        // 마크
        markersAlignment: Alignment.bottomCenter,
      ),
      // 캘린더 포맷(month, twoWeeks, week)
      calendarFormat: CalendarFormat.month,
      // 캘린더 builder
      calendarBuilders: CalendarBuilders(
        // 마킹
        markerBuilder: (context, day, events) {
          return _mark(state.allDayLogs, day);
        },
        // 오늘 날짜
        todayBuilder: (context, day, focusedDay) {
          return _todayMark(day);
        },
      ),
      // 한 주의 높이
      daysOfWeekHeight: 30,
      // 시작 요일
      startingDayOfWeek: StartingDayOfWeek.monday,
      // 요일 style
      daysOfWeekStyle: _dayOfWeekStyle(),
      // 캘린더 포맷 변경 시 호출됨
      onFormatChanged: (format) {
        print('onFormatChanged click!');
      },
      // 날짜 클릭하면 호출되는 메서드
      onDaySelected: (selectedDay, focusedDay) async {
        _onSelected(selectedDay, state, context);
      },
      // 캘린더 페이지 변할 때 호출
      onPageChanged: (focusedDay) {
        final vm = ref.read(homeTapViewModelProvider.notifier);
        vm.setCalendarViewDate(focusedDay);
      },
    );
  }

  /// 오늘 날짜 선택했을 때 데이로그가 없으면 작성 페이지로 있으면 detail 페이지로 /
  /// 오늘 외의 날짜 선택했을 때 데이로그가 있으면 detail 페이지로 이동
  void _onSelected(
    DateTime selectedDay,
    HomeTapState state,
    BuildContext context,
  ) {
    final selectedDate = selectedDay.toIso8601String().substring(0, 10);
    // 작성했으면 dayLog, 안하면 null
    final DayLog? dayLog =
        state.allDayLogs.firstWhereOrNull((e) => e.keyDate == selectedDate);

    if (isSameDay(selectedDay, _today)) {
      if (dayLog == null) {
        // 오늘 데이로그를 쓰지 않았으면 작성 페이지로
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return EmotionMoodPage();
        }));
      } else {
        // 오늘 데이로그 작성했으면 detail 페이지로
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return DayLogDetailPage(dayLog);
        }));
      }
    } else {
      // 데이로그 작성했으면 detail 페이지로
      if (dayLog != null) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return DayLogDetailPage(dayLog);
        }));
      }
    }
  }

  /// 요일 텍스트 스타일
  DaysOfWeekStyle _dayOfWeekStyle() {
    return DaysOfWeekStyle(
      // 평일
      weekdayStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      // 주말
      weekendStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  /// 오늘 날짜 마킹
  Container _todayMark(DateTime day) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(bottom: 45),
      width: 33,
      height: 21,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        '${day.day}',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  /// 일기 쓴 날과 아닌 날을 비교해서 이모티콘 출력
  Container _mark(List<Object?> events, DateTime day) {
    bool isToday = false;
    bool isWritten = false;
    DayLog? dayLog;

    if (isSameDay(day, _today)) {
      isToday = true;
    }

    for (var e in events) {
      final written = e as DayLog;
      if (isSameDay(day, DateTime.parse(written.date))) {
        isWritten = true;
        dayLog = written;
        break;
      }
    }

    Widget child;

    if (isToday) {
      if (isWritten) {
        // 오늘 날짜(작성함)
        child = SvgPicture.asset(
            'assets/icons/emotion/36/ic_${dayLog!.emotion.code}.svg');
      } else {
        // 오늘 날짜(작성안함)
        child = SvgPicture.asset('assets/icons/emotion/36/ic_today.svg');
      }
    } else {
      if (isWritten) {
        // 오늘 외의 날짜(작성함)
        child = SvgPicture.asset(
            'assets/icons/emotion/36/ic_${dayLog!.emotion.code}.svg');
      } else {
        // 오늘 외의 날짜(작성안함)
        child = SvgPicture.asset('assets/icons/emotion/36/ic_default.svg');
      }
    }

    return Container(
      margin: EdgeInsets.only(bottom: 5),
      child: child,
    );
  }
}
