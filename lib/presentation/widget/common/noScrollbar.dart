/**
 * Child Widget의 스크롤바를 없앰
 */

import 'package:flutter/material.dart';

class NoScrollBehavior extends ScrollBehavior {
  const NoScrollBehavior();

  @override
  Widget buildScrollbar(context, child, details) {
    return child;
  }
}

class NoScrollbarWrapper extends StatelessWidget {
  final Widget child;

  const NoScrollbarWrapper({required this.child});

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
        behavior: const NoScrollBehavior(), child: child);
  }
}
