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
  final Function reCreate;

  const AdditionalAction(
      {super.key,
      required this.mainParagraph,
      required this.questionId,
      required this.threadId,
      required this.page,
      required this.answerArrLength,
      required this.setPage,
      required this.reCreate});

  @override
  _AdditionalActionState createState() => _AdditionalActionState();
}

class _AdditionalActionState extends State<AdditionalAction> {
  bool? feedback;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      widget.answerArrLength > 1
          ? Row(children: [
              IconButton(
                  onPressed: () {
                    widget.setPage(widget.page - 1);
                  },
                  icon: const Icon(Icons.arrow_back_ios_new, size: 20)),
              Text('${widget.page + 1} / ${widget.answerArrLength}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff000000),
                  )),
              IconButton(
                  onPressed: () {
                    widget.setPage(widget.page + 1);
                  },
                  icon: const Icon(Icons.arrow_forward_ios, size: 20)),
            ])
          : Container(),
      IconButton(
        onPressed: () {
          widget.reCreate();
        },
        icon: SizedBox(
            width: 20,
            height: 20,
            child: Image.asset('assets/icons/icon_reload.png')),
      ),
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
