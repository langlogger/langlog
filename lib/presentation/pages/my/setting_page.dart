import 'package:flutter/material.dart';
import 'package:langlog/constant/custom_style.dart';
import 'package:langlog/presentation/pages/login/widgets/web_view_page.dart';
import 'package:langlog/presentation/pages/my/account_setting_page.dart';
import 'package:langlog/presentation/widgets/custom_app_bar.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: '설정',
        ),
        body: ListView(
          children: [
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              title: Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Text(
                  '개인정보 관리',
                  style: CustomText.body_01_M,
                ),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AccountSettingPage()),
                );
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              title: Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Text(
                  '서비스 이용 정보',
                  style: CustomText.body_01_M,
                ),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WebViewPage(
                      url:
                          'https://www.notion.so/langlog-184c3df9ab1680f89a6bc1e6a9a21812?pvs=4',
                    ),
                  ),
                );
              },
            ),
            //모닝로그 알림 설정 주석처리

            // ListTile(
            //   title: Text('모닝로그 알림 설정'),
            //   trailing: Icon(Icons.chevron_right),
            //   onTap: () {
            //     print('Email tapped');
            //   },
            // ),

            //데이터 백업 주석처리

            // ListTile(
            //   title: Text('데이터백업'),
            //   trailing: Icon(Icons.chevron_right),
            //   onTap: () {
            //     print('Email tapped');
            //   },
            // ),
          ],
        ));
  }
}
