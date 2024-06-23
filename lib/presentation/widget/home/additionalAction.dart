import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:acebot_front/presentation/widget/common/baseToast.dart';

class AdditionalAction extends StatefulWidget {
  final String mainParagraph;
  final int questionId;
  final int threadId;
  final int page;
  final int answerArrLength;
  final Function setPage;

  const AdditionalAction(
      {super.key,
      required this.mainParagraph,
      required this.questionId,
      required this.threadId,
      required this.page,
      required this.answerArrLength,
      required this.setPage});

  @override
  _AdditionalActionState createState() => _AdditionalActionState();
}

class _AdditionalActionState extends State<AdditionalAction> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      IconButton(
        onPressed: () {},
        icon: SizedBox(
            width: 20,
            height: 20,
            child: Image.asset('assets/icons/icon_reload.png')),
      ),
      const SizedBox(width: 20),
      IconButton(
        onPressed: () {
          Clipboard.setData(ClipboardData(text: widget.mainParagraph));

          BaseToast(content: '답변 내용이 클립보드에 복사되었습니다.', context: context)
              .showToast();
        },
        icon: SizedBox(
            width: 20,
            height: 20,
            child: Image.asset('assets/icons/icon_copy-clipboard.png')),
      ),
      const SizedBox(width: 20),
      IconButton(
        onPressed: () {},
        icon: SizedBox(
            width: 20,
            height: 20,
            child: Image.asset('assets/icons/icon_feedback-good.png')),
      ),
      const SizedBox(width: 20),
      IconButton(
        onPressed: () {},
        icon: SizedBox(
            width: 20,
            height: 20,
            child: Image.asset('assets/icons/icon_feedback-bad.png')),
      ),
    ]);
  }
}
