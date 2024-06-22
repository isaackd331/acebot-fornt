// 답변 별 템플릿 Wrapper

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:acebot_front/presentation/widget/home/template/chitchatTemplate.dart';
import 'package:acebot_front/presentation/widget/home/template/weatherTemplate.dart';

import 'package:acebot_front/bloc/answer/answerState.dart';
import 'package:acebot_front/bloc/answer/answerCubit.dart';

class TemplateWrapper extends StatefulWidget {
  final String question;

  const TemplateWrapper({super.key, required this.question});

  @override
  _TemplateWrapperState createState() => _TemplateWrapperState();
}

class _TemplateWrapperState extends State<TemplateWrapper> {
  String? templateName;

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
        return const ChitChatTemplate();

      case 'cur_weather':
        return const WeatherTemplate();

      case 'weekly_weather':
        return const WeatherTemplate();

      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AnswerCubit, AnswerState>(listener: (context, state) {
      if (state is LoadedState) {
        setState(() {
          templateName = state.answerJson.template_name;
        });
      }
    }, child: BlocBuilder<AnswerCubit, AnswerState>(builder: (_, state) {
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
            _templateSelector()
          ]));
    }));
  }
}
