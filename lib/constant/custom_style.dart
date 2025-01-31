import 'package:flutter/material.dart';

class CustomColors {
  // Grayscale
  static Color white = Color(0xffffffff);
  static Color black = Color(0xff000000);
  static Color grey_50 = Color(0xfffbfbfb);
  static Color grey_100 = Color(0xfff5f5f5);
  static Color grey_200 = Color(0xffe0e0e0);
  static Color grey_300 = Color(0xffcccccc);
  static Color grey_400 = Color(0xffb3b3b3);
  static Color grey_500 = Color(0xff8a8a8a);
  static Color grey_600 = Color(0xff777777);
  static Color grey_700 = Color(0xff666666);
  static Color grey_800 = Color(0xff4e4e4e);
  static Color grey_900 = Color(0xff2a2a2a);

  // BG
  static Color bg_50 = Color(0xfff8f7f3);
  static Color bg_100 = Color(0xfff1f0eb);

  // Point
  static Color vl_100 = Color(0xffede6f8);
  static Color vl_400 = Color(0xffa49de5);
  static Color vl_500 = Color(0xff9a80f1);
  static Color vl_600 = Color(0xff7759d9);
}

class CustomText {
  static TextStyle header_01_SB = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.6,
    color: CustomColors.grey_900,
  );
  static TextStyle header_02_SB = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.6,
    color: CustomColors.grey_900,
  );
  static TextStyle header_03_SB = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.6,
    color: CustomColors.grey_900,
  );
  static TextStyle body_01_M = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.6,
    color: CustomColors.grey_900,
  );
  static TextStyle body_02_SB = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.4,
    color: CustomColors.grey_900,
  );
  static TextStyle body_02_M = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.6,
    color: CustomColors.grey_900,
  );
  static TextStyle caption_01_SB = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 1.6,
    color: CustomColors.grey_900,
  );
  static TextStyle caption_01_M = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.6,
    color: CustomColors.grey_900,
  );
}
