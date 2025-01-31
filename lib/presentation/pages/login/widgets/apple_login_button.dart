import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langlog/presentation/pages/home/home_page.dart';
import 'package:langlog/presentation/pages/login/login_view_model.dart';
import 'package:langlog/presentation/pages/login/widgets/apple_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class appleLoginButton extends StatelessWidget {
  const appleLoginButton(
    BuildContext context, {
    super.key,
    required this.isChecked,
  });

  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return SignInWithAppleButton(
        onPressed: () async {
          if (isChecked == false) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('이용약관 및 개인정보취급방침에 동의해주세요.')),
            );
          }else{
          final userCredential = await signInWithApple(context);

          if (userCredential == null) {
            print("userCredential == null");
            return;
          } else {
            await ref
                .read(loginViewModel.notifier)
                .uploadUserData(userCredential);

            // 로그인 처리 후 페이지 이동
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          }

          }
        },
        style: SignInWithAppleButtonStyle.black,
        text: 'Sign in with Apple',
        borderRadius: BorderRadius.circular(25),
        height: 44,
      );
    });
  }
}
