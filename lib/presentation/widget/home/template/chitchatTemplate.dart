import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:acebot_front/bloc/answer/answerState.dart';
import 'package:acebot_front/bloc/answer/answerCubit.dart';

class ChitChatTemplate extends StatefulWidget {
  final int index;

  const ChitChatTemplate({super.key, required this.index});

  @override
  _ChitChatTemplateState createState() => _ChitChatTemplateState();
}

class _ChitChatTemplateState extends State<ChitChatTemplate> {
  String mainParagraph = "";
  List<dynamic>? recommendedPrompt = [];

  @override
  void initState() {
    super.initState();

    // initialize cubit
    context.read<AnswerCubit>();
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
        return SingleChildScrollView(
            child: Container(
                margin: const EdgeInsets.only(top: 20),
                child: Row(children: [
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
                  ))
                ])));
      } else {
        return Container();
      }
    }));
  }
}
