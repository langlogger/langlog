import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langlog/presentation/pages/home/home_page.dart';
import 'package:langlog/presentation/pages/login/login_view_model.dart';
import 'package:langlog/presentation/pages/login/widgets/google_sign_in.dart';

class GoogleLoginButton extends StatelessWidget {
  const GoogleLoginButton(
    BuildContext context, {
    super.key,
    required this.isChecked,
  });

  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return SizedBox(
        height: 44,
        child: ElevatedButton(
          onPressed: () async {
            //이용약관에 동의하지 않았을 경우
            if (isChecked == false) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('이용약관 및 개인정보취급방침에 동의해주세요.')),
              );
            } else {
              final userCredential = await signInWithGoogle(context);
        
              if (userCredential == null) {
                print("userCredential == null");
                return;
              } else {
                await ref
                    .read(loginViewModel.notifier)
                    .uploadUserData(userCredential);
        
                // 로그인 처리 후 페이지 이동
                if (context.mounted) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                }
              }
            }
          },
          style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.white),
              foregroundColor: WidgetStatePropertyAll(Colors.black)),
              
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/google_logo.png',
                width: 20,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Google로 시작하기',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      );
    });
  }
}
