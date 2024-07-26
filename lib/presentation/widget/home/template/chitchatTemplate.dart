import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:acebot_front/presentation/widget/home/additionalAction.dart';

import 'package:acebot_front/bloc/answer/answerState.dart';
import 'package:acebot_front/bloc/answer/answerCubit.dart';

class ChitChatTemplate extends StatefulWidget {
  // final int index;
  final int questionId;
  final int threadId;
  final String question;
  final Function setChatContent;
  final String initMp;
  final List<dynamic> recommendPrompts;

  const ChitChatTemplate(
      {super.key,
      // required this.index,
      required this.questionId,
      required this.threadId,
      required this.question,
      required this.setChatContent,
      required this.initMp,
      required this.recommendPrompts});

  @override
  _ChitChatTemplateState createState() => _ChitChatTemplateState();
}

class _ChitChatTemplateState extends State<ChitChatTemplate> {
  List<String> mainParagraph = [];
  List<dynamic>? recommendedPrompt = [];
  int curPage = 0;

  @override
  void initState() {
    super.initState();

    setState(() {
      mainParagraph[0] = widget.initMp;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 추후 개발 때는 length가 늘어나며 여러 질문/답변이 한 화면에 나타날 수 있어야 함.
    // 1차 개발에서는 한 화면에 한 질문/답변만
    // return BlocListener<AnswerCubit, List<AnswerState>>(
    return BlocListener<AnswerCubit, AnswerState>(listener: (context, state) {
      // 추후 개발 때는 length가 늘어나며 여러 질문/답변이 한 화면에 나타날 수 있어야 함.
      // 1차 개발에서는 한 화면에 한 질문/답변만
      // AnswerState theState = state[widget.index];
      AnswerState theState = state;

      if (theState is LoadedState) {
        setState(() {
          mainParagraph[curPage] = theState.answerJson.main_paragraph;
        });
      }
    },
        // 추후 개발 때는 length가 늘어나며 여러 질문/답변이 한 화면에 나타날 수 있어야 함.
        // 1차 개발에서는 한 화면에 한 질문/답변만
        // child: BlocBuilder<AnswerCubit, List<AnswerState>>(builder: (_, state) {
        child: BlocBuilder<AnswerCubit, AnswerState>(builder: (_, state) {
      // 추후 개발 때는 length가 늘어나며 여러 질문/답변이 한 화면에 나타날 수 있어야 함.
      // 1차 개발에서는 한 화면에 한 질문/답변만
      // AnswerState theState = state[widget.index];
      AnswerState theState = state;

      if (theState is LoadedState) {
        return Container(
            margin: const EdgeInsets.only(top: 20),
            child: Column(children: [
              Row(children: [
                Expanded(
                    child: MarkdownBody(
                  data: mainParagraph[curPage],
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
                  mainParagraph: mainParagraph[curPage],
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
