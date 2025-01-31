import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langlog/presentation/pages/home/_tap/home/home_tap_view_model.dart';
import 'package:langlog/presentation/widgets/custom_dialog.dart';

class CalendarDatePickDialog extends ConsumerStatefulWidget {
  const CalendarDatePickDialog({super.key});

  @override
  ConsumerState<CalendarDatePickDialog> createState() =>
      _CalendarDatePickDialogState();
}

class _CalendarDatePickDialogState
    extends ConsumerState<CalendarDatePickDialog> {
  DateTime _selected = DateTime.now();

  void setDate(DateTime dateTime) {
    // 버튼 누를 때만 _selected 갱신하도록
    setState(() {});
    final vm = ref.watch(homeTapViewModelProvider.notifier);
    vm.setCalendarViewDate(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final dateTimeNow = DateTime.now();
    final state = ref.watch(homeTapViewModelProvider);

    return CustomDialog(
      title: '다른 날짜 보기',
      content: null,
      contentsWidget: CupertinoDatePicker(
        dateOrder: DatePickerDateOrder.ymd,
        // 최대 날짜
        maximumDate: dateTimeNow,
        // 최대 연도
        maximumYear: dateTimeNow.year,
        // 초기 날짜
        initialDateTime: state.calendarViewDate ?? dateTimeNow,
        // 최소 날짜
        minimumDate: state.dateOfJoin,
        mode: CupertinoDatePickerMode.monthYear,
        onDateTimeChanged: (value) {
          _selected = value;
        },
      ),
      cancleLabel: '취소',
      confirmLabel: '완료',
      onConfirm: () => setDate(_selected),
    );
  }
}
