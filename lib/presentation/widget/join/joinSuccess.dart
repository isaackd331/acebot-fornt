import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:acebot_front/presentation/widget/common/baseOutlineButton.dart';

class JoinSuccess extends StatelessWidget {
  const JoinSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(),
            Column(children: [
              SizedBox(
                width: 59,
                height: 20,
                child: Image.asset('assets/images/acebot_logo.png'),
              ),
              const SizedBox(height: 14),
              const Text(
                "가입을 완료했어요!",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff000000),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "에이스봇의 다양한 서비스를\n이용해 보세요!",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff1c1c1c),
                ),
              ),
            ]),
            Row(mainAxisSize: MainAxisSize.max, children: [
              BaseOutlineButton(
                onPressedFunc: () {
                  context.go('/home');
                },
                text: '시작하기',
                fontSize: 16.0,
                textColor: const Color(0xffffffff),
                backgroundColor: const Color(0xff000000),
                borderColor: const Color(0xff000000),
              ),
            ])
          ],
        ));
  }
}
