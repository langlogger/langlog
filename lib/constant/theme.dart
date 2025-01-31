import 'package:flutter/material.dart';
import 'package:langlog/constant/custom_style.dart';

ThemeData theme = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'Pretendard',
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: Colors.black, // 기본 색상
    // secondary: Colors.grey, // 보조 색상
  ),
  scaffoldBackgroundColor: CustomColors.bg_50,
  appBarTheme: AppBarTheme(
    centerTitle: true,
    backgroundColor: CustomColors.bg_50,
    scrolledUnderElevation: 0,
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      textStyle: CustomText.header_02_SB,
      padding: EdgeInsets.only(top: 12, bottom: 15),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      textStyle: CustomText.header_02_SB,
      padding: EdgeInsets.only(top: 12, bottom: 15),
      backgroundColor: CustomColors.white,
      side: BorderSide(color: CustomColors.grey_300),
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    // 원형 모양
    shape: CircleBorder(),
    // 그림자 제거
    elevation: 0,
    // 색상 지정
    backgroundColor: Colors.black,
  ),
);
