import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:langlog/presentation/pages/my/my_page.dart';

class HomeMyPageIcon extends StatelessWidget {
  const HomeMyPageIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 마이페이지로 이동
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyPage()),
        );
      },
      child: Container(
        margin: EdgeInsets.only(right: 10),
        height: 50,
        width: 50,
        color: Colors.transparent,
        child: SvgPicture.asset(
          'assets/icons/basic/24/ic_my.svg',
          fit: BoxFit.none,
        ),
      ),
    );
  }
}
