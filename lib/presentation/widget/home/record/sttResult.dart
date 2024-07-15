// 현재 STT 데이터는 가 데이터임
// DB 쪽 처리가 되고 있질 않음

import 'package:flutter/material.dart';

class SttResult extends StatelessWidget {
  final List<dynamic> outputs;

  @override
  const SttResult({super.key, required this.outputs});

  Widget _sttWrapper(dynamic output) {
    List<dynamic> splittedOutput = output.split('|');

// 참가자 번호
    int speakerIndex = int.parse(splittedOutput[0]);

// 시작 시간(ms)
    int startTime = int.parse(splittedOutput[1]);
    int seconds = (startTime / 1000).truncate();
    int minutes = (seconds / 60).truncate();
    seconds = seconds % 60;
    // mm:ss로 변환
    String parsedTime =
        "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";

    // 내용
    String content = splittedOutput[3];

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Container(
            width: 20,
            height: 20,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Color(0xff323232)),
            child: Align(
                alignment: Alignment.center,
                child: Text(
                  speakerIndex.toString(),
                  style: const TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: Color(0xffffffff)),
                  textAlign: TextAlign.center,
                ))),
        const SizedBox(width: 6),
        Text('참여자 $speakerIndex',
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xff111111))),
        const SizedBox(width: 6),
        Text(parsedTime,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xff737373)))
      ]),
      const SizedBox(height: 16),
      Text(content,
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xff4f4f4f))),
      const SizedBox(height: 28)
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(20, 27, 20, 20),
        decoration: const BoxDecoration(color: Color(0xffffffff)),
        child: Column(children: [
          Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("새로운 음성 녹음",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff000000))),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.clear),
                    iconSize: 24,
                    color: const Color(0xff000000))
              ]),
          const SizedBox(height: 17),
          const Row(
            children: [
              Text('N월 N일 오후 NN:NN',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff737373))),
              SizedBox(width: 12),
              Text('NN시간 NN분 NN초',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff737373))),
            ],
          ),
          const SizedBox(height: 30),
          Expanded(
              child: SingleChildScrollView(
                  child: Column(
                      children: outputs
                          .map((output) => _sttWrapper(output))
                          .toList()))),
        ]));
  }
}
