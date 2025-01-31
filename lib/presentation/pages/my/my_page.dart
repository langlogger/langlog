import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:langlog/constant/custom_style.dart';
import 'package:langlog/core/l_date_format.dart';
import 'package:langlog/presentation/pages/home/_tap/home/home_tap_view_model.dart';
import 'package:langlog/presentation/pages/my/my_page_view_model.dart';
import 'package:langlog/presentation/pages/my/setting_page.dart';
import 'package:langlog/presentation/widgets/custom_app_bar.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {

      //일기 수 가져오기
      final daylog = ref.read(homeTapViewModelProvider.notifier).getAllDayLog();
      //user 정보 가져오기
      final user = ref.watch(myPageViewModel);

      return Scaffold(
        appBar: CustomAppBar(
          title: '마이페이지',
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingPage()),
                );
              },
              icon: Icon(Icons.settings),
            ),
          ],
        ),
        body: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Text('나의 성장차트', style: CustomText.header_03_SB),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: FutureBuilder<List>(
                      future: daylog,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('에러 발생: ${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          //일기 개수 0으로 표시
                          return logDataBox(daylog: 0, visit: user.visitCount);
                        } else {
                          final daylog = snapshot.data!.length;
                          return logDataBox(
                              daylog: daylog, visit: user.visitCount);
                        }
                      },
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      );
    });
  }
}

class logDataBox extends StatelessWidget {
  const logDataBox({
    super.key,
    required this.daylog,
    required this.visit,
  });

  final int daylog;
  final int visit;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                '$daylog',
                style: CustomText.header_01_SB,
              ),
              SizedBox(height: 5),
              Text(
                '작성한 일기',
                style: CustomText.body_01_M,
              ),
            ],
          ),
        ),
        Container(
          height: 50,
          child: VerticalDivider(
            color: Colors.grey,
            thickness: 1,
            width: 20,
          ),
        ),
        Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                '$visit',
                style: CustomText.header_01_SB,
              ),
              SizedBox(height: 5),
              Text(
                '방문횟수',
                style: CustomText.body_01_M,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
