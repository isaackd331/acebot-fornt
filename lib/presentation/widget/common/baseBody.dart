/**
 * Screen Body
 * 네이티브 키보드가 올라오더라도 기존 위젯들을
 * scrollable 하게 변경함
 */

import 'package:flutter/material.dart';

import 'package:acebot_front/presentation/widget/common/noScrollbar.dart';

class BaseBody extends StatelessWidget {
  final Widget child;

  const BaseBody({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(child: LayoutBuilder(builder: (context, constraint) {
        return NoScrollbarWrapper(
            child: SingleChildScrollView(
                child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraint.maxHeight),
                    child: IntrinsicHeight(child: child))));
      }))
    ]);
  }
}
