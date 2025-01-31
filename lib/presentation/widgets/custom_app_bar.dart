import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:langlog/constant/custom_style.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? leading;
  final PreferredSizeWidget? bottom;
  final List<Widget>? actions;

  CustomAppBar({
    this.title,
    this.leading,
    this.bottom,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading ?? _popButton(context),
      title: title != null ? _title() : null,
      bottom: bottom,
      actions: actions,
    );
  }

  Text _title() {
    return Text(
      title!,
      style: CustomText.header_02_SB,
    );
  }

  /// 기본 뒤로가기 버튼
  IconButton _popButton(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.pop(context),
      icon: SvgPicture.asset('assets/icons/basic/24/ic_caret_left_big.svg'),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
