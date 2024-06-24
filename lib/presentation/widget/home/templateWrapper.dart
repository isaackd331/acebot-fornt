// 답변 별 템플릿 Wrapper

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:acebot_front/presentation/widget/home/template/chitchatTemplate.dart';
import 'package:acebot_front/presentation/widget/home/template/weatherTemplate.dart';
import 'package:acebot_front/presentation/widget/home/template/placeTemplate.dart';

import 'package:acebot_front/bloc/answer/answerState.dart';
import 'package:acebot_front/bloc/answer/answerCubit.dart';

class TemplateWrapper extends StatefulWidget {
  final String question;
  final int index;
  final List<dynamic> idsArray;
  final Function setChatContent;
  final ScrollController answerListController;

  const TemplateWrapper(
      {super.key,
      required this.question,
      required this.index,
      required this.idsArray,
      required this.setChatContent,
      required this.answerListController});

  @override
  _TemplateWrapperState createState() => _TemplateWrapperState();
}

class _TemplateWrapperState extends State<TemplateWrapper> {
  String? templateName = "";

  @override
  void initState() {
    super.initState();

    // initialize Cubit
    context.read<AnswerCubit>();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _templateSelector() {
    switch (templateName) {
      case 'chitchat':
        return ChitChatTemplate(
            index: widget.index,
            questionId: widget.idsArray[widget.index]['questionId'],
            threadId: widget.idsArray[widget.index]['threadId'],
            question: widget.question,
            setChatContent: widget.setChatContent);

      case 'cur_weather':
        return WeatherTemplate(
            index: widget.index,
            questionId: widget.idsArray[widget.index]['questionId'],
            threadId: widget.idsArray[widget.index]['threadId'],
            question: widget.question,
            setChatContent: widget.setChatContent);

      case 'weekly_weather':
        return WeatherTemplate(
            index: widget.index,
            questionId: widget.idsArray[widget.index]['questionId'],
            threadId: widget.idsArray[widget.index]['threadId'],
            question: widget.question,
            setChatContent: widget.setChatContent);

      case 'place_search':
        return PlaceTemplate(
            index: widget.index,
            questionId: widget.idsArray[widget.index]['questionId'],
            threadId: widget.idsArray[widget.index]['threadId'],
            question: widget.question,
            setChatContent: widget.setChatContent);

      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AnswerCubit, List<AnswerState>>(
        listener: (context, state) {
      AnswerState theState = state[widget.index];
      AnswerState lastState = state[state.length - 1];

      scrollToBottom(int duration) {
        Future.delayed(
            duration == 0 ? Duration.zero : Duration(milliseconds: duration),
            () {
          widget.answerListController.animateTo(
              widget.answerListController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeInOut);
        });
      }

      if (theState is LoadedState) {
        setState(() {
          templateName = theState.answerJson.template_name;
        });
      }

      if (lastState is EmptyState || lastState is LoadingState) {
        scrollToBottom(100);
      } else if (lastState is LoadedState) {
        print(widget.index);
        scrollToBottom(0);
      }
    }, child: BlocBuilder<AnswerCubit, List<AnswerState>>(builder: (_, state) {
      AnswerState theState = state[widget.index];

      return Container(
          margin: const EdgeInsets.only(top: 40),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(mainAxisSize: MainAxisSize.max, children: [
            Row(children: [
              Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xff666666)),
                  // TODO : 추후 유저 아이콘으로 변경 필요
                  child: const Text(
                    'T',
                    style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: Color(0xffffffff)),
                    textAlign: TextAlign.center,
                  )),
              const SizedBox(width: 7),
              const Text('You',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff111111)))
            ]),
            const SizedBox(height: 14),
            Row(
              children: [
                Flexible(
                    child: Text(
                  widget.question,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff000000)),
                ))
              ],
            ),
            const SizedBox(height: 60),
            Row(children: [
              Image.asset('assets/icons/icon_answer-start-symbol.png', scale: 3)
            ]),
            const SizedBox(height: 20),
            Row(children: [
              Image.asset('assets/icons/icon_exaone-logo.png', scale: 3),
              const SizedBox(width: 4),
              const Text("ACEBOT",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff111111)))
            ]),
            theState is LoadingState
                ? Row(children: [
                    Expanded(
                        child: Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: const Text('Loading...',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 51, 21, 21)))))
                  ])
                : Container(),
            theState is ErrorState
                ? Row(children: [
                    Expanded(
                        child: Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: const Text(
                                "시스템에 문제가 발생하였습니다.\n관리자에게 문의바랍니다.",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 51, 21, 21)))))
                  ])
                : Container(),
            theState is LoadedState ? _templateSelector() : Container()
          ]));
    }));
  }
}
