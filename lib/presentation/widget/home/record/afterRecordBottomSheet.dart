/// 녹음 후 추가 정보
library;

import 'package:flutter/material.dart';

import 'package:acebot_front/presentation/widget/common/baseOutlineButton.dart';

class AfterRecordBottomSheet extends StatefulWidget {
  final String? recordedUrl;

  const AfterRecordBottomSheet({
    super.key,
    required this.recordedUrl
  });

  @override
  _AfterRecordBottomSheetState createState() => _AfterRecordBottomSheetState();
}

class _AfterRecordBottomSheetState extends State<AfterRecordBottomSheet> {
  int speakers = 1;
  String type = '';

  @override
  void initState() {
    super.initState();
  }

  /// how many speakers button widget
  Widget _speakers(String title, int activeCondition) {
    return GestureDetector(
      onTap: () {
        setState(() {
          speakers = activeCondition;
        });
      },
      child: Column(
        children: [
          Container(
            height: 2,
            decoration: BoxDecoration(
              color: speakers == activeCondition ? const Color(0xff000000) : const Color(0xffdadada)
            )
          ),
          const SizedBox(height: 9),
          Text(title, style: TextStyle(
            fontSize: 16,
            fontWeight: speakers == activeCondition ? FontWeight.w700 : FontWeight.w500,
            color: speakers == activeCondition ? const Color(0xff000000) : const Color(0xffdadada),
            ),
          )
        ]
      )
    );
  }

  /// checkbox widget
  Widget _checkbox(String title, String activeCondition) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              type = activeCondition;
            });
          },
          child: Row(
            children: [
              SizedBox(
                width: 16,
                height: 16,
                child: Image.asset('assets/icons/icon_check.png', color: type == activeCondition ? const Color(0xff000000) : const Color(0xffb3b3b3))
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff000000)
                )
              )
            ]
          )
        )
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 24),
      decoration: const BoxDecoration(
        color: Color(0xffffffff)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('참여자는 몇명인가요?', style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xff000000)
          )),
          const SizedBox(height: 36),
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 1,
                child: _speakers('1명', 1)
              ),
              Flexible(
                flex: 1,
                child: _speakers('2명', 2),
              ),
              Flexible(
                flex: 1,
                child: _speakers('3명', 3),
              ),
              Flexible(
                flex: 1,
                child: _speakers('4명', 4),
              ),
              Flexible(
                flex: 1,
                child: _speakers('5명 이상', 5),
              ),
            ]
          ),
          const SizedBox(height: 40),
          const Text('음성의 종류를 선택해 주세요.', style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xff000000)
          )),
          const SizedBox(height: 30),
          _checkbox("회의", 'meeting'),
          const SizedBox(height: 32),
          _checkbox("인터뷰", 'interview'),
          const SizedBox(height: 32),
          _checkbox("메모", 'memo'),
          const SizedBox(height: 32),
          _checkbox("통화", 'call'),
          const SizedBox(height: 40),
          Row(children: [
            BaseOutlineButton(
                onPressedFunc: () {
                  if (speakers > 0 && type.isNotEmpty) {
                  }
                },
                text: '확인',
                fontSize: 16.0,
                textColor: const Color(0xffffffff),
                backgroundColor: (speakers > 0 && type.isNotEmpty)
                    ? const Color(0xff000000)
                    : const Color(0xffb3b3b3),
                borderColor: (speakers > 0 && type.isNotEmpty)
                    ? const Color(0xff000000)
                    : const Color(0xffb3b3b3))
          ]),
        ]
      )
    );
  }
}
