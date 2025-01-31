import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langlog/domain/entity/day_log.dart';
import 'package:langlog/provider.dart';

class HomeTapState {
  /// 캘린더 페이지 보여줄 날짜
  DateTime? calendarViewDate;

  /// 오늘 데이로그 작성 여부
  bool isWrittenDayLogToday;

  /// 유저 가입일
  DateTime dateOfJoin;

  /// 모든 데이 로그
  List<DayLog> allDayLogs;

  HomeTapState({
    required this.calendarViewDate,
    required this.isWrittenDayLogToday,
    required this.dateOfJoin,
    required this.allDayLogs,
  });

  HomeTapState copyWith({
    DateTime? selectedCalendarViewDate,
    bool? isWrittenDayLogToday,
    List<DayLog>? newAllDayLogs,
  }) {
    return HomeTapState(
      calendarViewDate: selectedCalendarViewDate ?? calendarViewDate,
      isWrittenDayLogToday: isWrittenDayLogToday ?? this.isWrittenDayLogToday,
      dateOfJoin: dateOfJoin,
      allDayLogs: newAllDayLogs ?? allDayLogs,
    );
  }
}

class HomeTapViewModel extends Notifier<HomeTapState> {
  final DateTime today = DateTime.now();

  /// 오늘 날짜(예시: 2025-01-01)
  late String todayStr = today.toIso8601String().substring(0, 10);

  @override
  HomeTapState build() {
    fetch();
    // 리스너 등록
    setListener();
    // TODO: 유저 정보에서 가입날짜 가져와서 추가해야함
    return HomeTapState(
      calendarViewDate: null,
      isWrittenDayLogToday: false,
      dateOfJoin: DateTime(2024),
      allDayLogs: [],
    );
  }

  void setCalendarViewDate(DateTime dateTime) {
    state = state.copyWith(selectedCalendarViewDate: dateTime);
  }

  void setCalendarViewDateToday() {
    state = state.copyWith(selectedCalendarViewDate: today);
  }

  void fetch() async {
    final items = await getAllDayLog();

    // 오늘 작성 했는지 체크
    DayLog? todayLog =
        items.lastWhereOrNull((dayLog) => dayLog.keyDate == todayStr);

    state = state.copyWith(
      newAllDayLogs: items,
      isWrittenDayLogToday: todayLog != null ? true : false,
    );
  }

  Future<List<DayLog>> getAllDayLog() async {
    final items = await ref.read(getAllDayLogUsecaseProvider).execute();
    return items;
  }

  void setListener() async {
    final listener =
        await ref.read(getAllDayLogListenableUsecaseProvider).execute();
    // 함수를 listener 로 넘긴다
    // value 가 바뀌면 리스너 호출됨
    // 실행 순서: value 변경 -> 리스너 호출 -> 등록한 함수 호출
    listener.addListener(fetch);
  }
}

final homeTapViewModelProvider =
    NotifierProvider<HomeTapViewModel, HomeTapState>(
  () {
    return HomeTapViewModel();
  },
);
