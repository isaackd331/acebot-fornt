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
    return BlocListener<AnswerCubit, AnswerState>(listener: (context, state) {
      if (state is LoadedState) {
        print(state.answerJson.main_paragraph);
      }
    }, child: BlocBuilder<AnswerCubit, AnswerState>(builder: (_, state) {
      return Container();
    }));
  }
}
