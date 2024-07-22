import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:acebot_front/presentation/widget/common/baseToast.dart';

import 'package:acebot_front/api/answerService.dart';

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
  bool? feedback;

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
        onPressed: () async {
          if (feedback == null || feedback! == false) {
            await AnswerService().feedback(widget.questionId, true);

            setState(() {
              feedback = true;
            });
          } else {
            await AnswerService().feedback(widget.questionId, null);

            setState(() {
              feedback = null;
            });
          }
        },
        icon: SizedBox(
            width: 20,
            height: 20,
            child: Image.asset('assets/icons/icon_feedback-good.png',
                color: (feedback != null && feedback == true)
                    ? const Color(0xff000000)
                    : const Color(0xff666666))),
      ),
      const SizedBox(width: 20),
      IconButton(
        onPressed: () async {
          await AnswerService().feedback(widget.questionId, false);

          if (feedback == null || feedback! == true) {
            setState(() {
              feedback = false;
            });
          } else {
            await AnswerService().feedback(widget.questionId, null);

            setState(() {
              feedback = null;
            });
          }
        },
        icon: SizedBox(
            width: 20,
            height: 20,
            child: Image.asset('assets/icons/icon_feedback-bad.png',
                color: (feedback != null && feedback == false)
                    ? const Color(0xff000000)
                    : const Color(0xff666666))),
      ),
    ]);
  }
}
