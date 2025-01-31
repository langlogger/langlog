import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langlog/constant/custom_style.dart';
import 'package:langlog/constant/dialog_messages.dart';
import 'package:langlog/presentation/pages/login/login_page.dart';
import 'package:langlog/presentation/pages/login/login_view_model.dart';
import 'package:langlog/presentation/pages/login/widgets/web_view_page.dart';
import 'package:langlog/presentation/pages/my/delete_account_page.dart';
import 'package:langlog/presentation/widgets/custom_app_bar.dart';
import 'package:langlog/presentation/widgets/custom_dialog.dart';

class AccountSettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return Scaffold(
        appBar: CustomAppBar(
          title: '개인정보 관리',
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('내 정보 관리', style: CustomText.header_01_SB),
              Divider(color: Colors.black),
              logoutButton(),
              deleteAccountButton(),
              SizedBox(height: 30),
              Text('정보', style: CustomText.header_01_SB),
              Divider(color: Colors.black),
              showPrivacyPolicy()
            ],
          ),
        ),
      );
    });
  }
}

//개인정보처리방침 웹뷰
class showPrivacyPolicy extends StatelessWidget {
  const showPrivacyPolicy({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WebViewPage(
              url:
                  'https://plump-flood-d00.notion.site/183c3df9ab1680dda38ec3893a509b45',
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        height: 40,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '개인정보처리방침',
            style: CustomText.body_01_M,
          ),
        ),
      ),
    );
  }
}

//계정탈퇴 버튼
class deleteAccountButton extends StatelessWidget {
  const deleteAccountButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DeleteAccountPage()),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        height: 40,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '탈퇴하기',
            style: CustomText.body_01_M,
          ),
        ),
      ),
    );
  }
}

//로그아웃버튼
class logoutButton extends StatelessWidget {
  const logoutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //로그아웃
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialog(
              title: LOGOUT_DIALOG.title,
              content: LOGOUT_DIALOG.content,
              cancleLabel: LOGOUT_DIALOG.cancleLabel,
              onCancle: () {
                // Navigator.of(context).pop();
              },
              confirmLabel: LOGOUT_DIALOG.confirmLabel,
              onConfirm: () async {
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pop();
                await Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (route) => false,
                );
              },
            );
          },
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        height: 40,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '로그아웃',
            style: CustomText.body_01_M,
          ),
        ),
      ),
    );
  }
}
