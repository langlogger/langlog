import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:langlog/constant/custom_style.dart';
import 'package:langlog/presentation/pages/day_log_write/day_log_view_model.dart';
import 'package:langlog/presentation/pages/day_log_write/pages/day_log_correction_result_page.dart';
import 'package:langlog/presentation/widgets/custom_app_bar.dart';

class DayLogCorrectionPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.read(dayLogViewModelProvider.notifier);
    print("교정중");

    return Scaffold(
      appBar: CustomAppBar(
        title: "Day Log",
      ),
      body: FutureBuilder(
        future: _performCorrection(vm, context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return loadingContent(context);
          }
          return loadingContent(context);
        },
      ),
    );
  }

  Widget loadingContent(BuildContext context) {
    final String iconPath = 'assets/icons/emotion/112/ic_happiness.svg';

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return DayLogCorrectionResultPage();
                },
              ));
            },
            child: Container(
              width: 80,
              height: 80,
              child: SvgPicture.asset('$iconPath'),
            ),
          ),
          SizedBox(height: 20),
          Text("랭글로그가 일기를 분석하고 있어요.", style: CustomText.header_02_SB),
          SizedBox(height: 60),
        ],
      ),
    );
  }

  Future<void> _performCorrection(
    DayLogViewModel vm,
    BuildContext context,
  ) async {
    await vm.logCorrection();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => DayLogCorrectionResultPage()),
    );
  }

  Widget _buildErrorContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error, color: Colors.red),
          SizedBox(height: 20),
          Text("일기 분석 중 오류가 발생했습니다."),
        ],
      ),
    );
  }
}
