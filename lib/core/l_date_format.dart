import 'package:intl/intl.dart';

/// intl 패키지 사용하여 커스텀한 클래스
class LDateFormat {
  /// 달력 헤더 포맷(Mmm yyyy)
  ///
  /// ex) Jan 2025
  static String calendarHeaderFormat(DateTime date) {
    final format = DateFormat.yMMM();
    return format.format(date);
  }

  /// 데이로그 헤더 포맷(Mmm dd. yyyy)
  /// ex) Jan 10. 2025
  static String dayLogFormat(DateTime date) {
    return DateFormat('MMM dd. yyyy').format(date);
  }

  //마이페이지 로그인 날짜 비교 포맷(yyyy-MM-dd)
  // ex) 2025-01-31
  static String mypageFormat(DateTime date){
    return DateFormat('yyyy-MM-dd').format(date);
  }
}
