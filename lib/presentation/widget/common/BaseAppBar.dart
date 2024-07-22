/// 커스텀 앱바
/// title: 제목
/// actions: 제목 기준 우측 버튼들
/// leading: 제목 기준 좌측 버튼
library;

import 'package:flutter/material.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final List<Widget> actions;
  final Widget leading;

  const BaseAppBar(
      {super.key,
      required this.title,
      required this.actions,
      required this.leading});

  @override
  Widget build(BuildContext context) {
    List<Widget> paddedActions = actions.map((action) {
      return action;
    }).toList();

    return AppBar(
        toolbarHeight: 60.0,
        centerTitle: true,
        foregroundColor: const Color(0xffffffff),
        backgroundColor: const Color(0xffffffff),
        surfaceTintColor: const Color(0xffffffff),
        shadowColor: const Color(0xffffffff),
        titleTextStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xff000000)),
        title: title,
        actions: paddedActions,
        leading: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
            child: leading));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
