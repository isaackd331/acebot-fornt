/// 녹음 후 추가 정보
library;

import 'package:flutter/material.dart';

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
            /**
             * TODO
             * width가 full로 되도록
             */
            width: 20,
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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 24),
      decoration: const BoxDecoration(
        color: Color(0xffffffff)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('참여자는 몇명인가요?', style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xff000000)
          )),
          const SizedBox(height: 36),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _speakers('1명', 1),
              _speakers('2명', 2),
              _speakers('3명', 3),
              _speakers('4명', 4),
              _speakers('5명 이상', 5),
            ]
          )
        ]
      )
    );
  }
}
