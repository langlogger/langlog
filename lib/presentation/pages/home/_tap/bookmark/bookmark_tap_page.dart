import 'package:flutter/material.dart';
import 'package:langlog/presentation/pages/home/widgets/home_my_page_icon.dart';
import 'package:langlog/presentation/widgets/custom_app_bar.dart';

class BookmarkTapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'BookMark',
        actions: [
          HomeMyPageIcon(),
        ],
      ),
      body: Center(
        child: Text("BookmarkTapPage"),
      ),
    );
  }
}
