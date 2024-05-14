/**
 * 커스텀 앱바
 * title: 제목
 * actions: 제목 기준 우측 버튼들
 * leading: 제목 기준 좌측 버튼
 */

import 'package:flutter/material.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;
  final Widget leading;

  const BaseAppBar(
      {super.key,
      required this.title,
      required this.actions,
      required this.leading});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        centerTitle: true,
        titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        title: Text(title),
        actions: actions,
        leading: leading);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
