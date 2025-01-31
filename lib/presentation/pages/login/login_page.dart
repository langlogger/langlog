import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:langlog/constant/custom_style.dart';
import 'package:langlog/presentation/pages/login/widgets/apple_login_button.dart';
import 'package:langlog/presentation/pages/login/widgets/login_button.dart';
import 'package:langlog/presentation/pages/login/widgets/web_view_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(),
                SvgPicture.asset('assets/images/login_logo.svg'),
                Spacer(),
                GoogleLoginButton(context, isChecked: isChecked),
                SizedBox(height: 15),
                appleLoginButton(context, isChecked: isChecked),
                SizedBox(height: 20),
                agreeWidget(context),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      );
    });
  }

  Row agreeWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 30,
          child: CheckboxListTile(
            value: isChecked,
            controlAffinity: ListTileControlAffinity.leading,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onChanged: (value) {
              setState(() {
                isChecked = value!;
              });
            },
          ),
        ),
        GestureDetector(
          onTapDown: (_) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WebViewPage(
                          url:
                              'https://plump-flood-d00.notion.site/183c3df9ab1680dda38ec3893a509b45',
                        )));
          },
          child: Row(
            children: [
              Text.rich(
                TextSpan(
                  text: '이용약관 및 개인정보취급방침',
                  style: CustomText.body_02_SB,
                ),
              ),
              Text(
                '에 동의합니다',
                style: CustomText.body_02_M,
              )
            ],
          ),
        ),
      ],
    );
  }
}
