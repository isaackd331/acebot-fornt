// 답변 별 템플릿 Wrapper

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:acebot_front/bloc/answer/answerState.dart';
import 'package:acebot_front/bloc/answer/answerCubit.dart';

class TemplateWrapper extends StatefulWidget {
  final String question;

  const TemplateWrapper({super.key, required this.question});

  @override
  _TemplateWrapperState createState() => _TemplateWrapperState();
}

class _TemplateWrapperState extends State<TemplateWrapper> {
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

  @override
  Widget build(BuildContext context) {
    return BlocListener<AnswerCubit, AnswerState>(
        listener: (context, state) {},
        child: BlocBuilder<AnswerCubit, AnswerState>(builder: (_, state) {
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
                  mainAxisSize: MainAxisSize.max,
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
                )
              ]));
        }));
  }
}
