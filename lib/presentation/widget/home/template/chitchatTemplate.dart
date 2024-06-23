import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:acebot_front/presentation/widget/home/additionalAction.dart';

import 'package:acebot_front/bloc/answer/answerState.dart';
import 'package:acebot_front/bloc/answer/answerCubit.dart';

class ChitChatTemplate extends StatefulWidget {
  final int index;
  final int questionId;
  final int threadId;
  final String question;
  final Function setChatContent;

  const ChitChatTemplate(
      {super.key,
      required this.index,
      required this.questionId,
      required this.threadId,
      required this.question,
      required this.setChatContent});

  @override
  _ChitChatTemplateState createState() => _ChitChatTemplateState();
}

class _ChitChatTemplateState extends State<ChitChatTemplate> {
  String mainParagraph = "";
  List<dynamic>? recommendedPrompt = [];

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
    return BlocListener<AnswerCubit, List<AnswerState>>(
        listener: (context, state) {
      AnswerState theState = state[widget.index];

      if (theState is LoadedState) {
        setState(() {
          mainParagraph = theState.answerJson.main_paragraph;
        });
      }
    }, child: BlocBuilder<AnswerCubit, List<AnswerState>>(builder: (_, state) {
      AnswerState theState = state[widget.index];

      if (theState is LoadedState) {
        return Container(
            margin: const EdgeInsets.only(top: 20),
            child: Column(children: [
              Row(children: [
                Expanded(
                    child: MarkdownBody(
                  data: mainParagraph,
                  listItemCrossAxisAlignment:
                      MarkdownListItemCrossAxisAlignment.start,
                  styleSheet: MarkdownStyleSheet(
                      textAlign: WrapAlignment.start,
                      p: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff4f4f4f),
                          height: 1.5)),
                )),
              ]),
              const SizedBox(height: 28),
              AdditionalAction(
                  mainParagraph: mainParagraph,
                  questionId: widget.questionId,
                  threadId: widget.threadId,
                  page: 0,
                  answerArrLength: 0,
                  setPage: () {})
            ]));
      } else {
        return Container();
      }
    }));
  }
}
