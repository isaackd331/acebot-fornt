import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:acebot_front/api/http.dart';
import 'package:acebot_front/appRouter.dart';
import 'package:acebot_front/bloc/eventsObserver.dart';

import 'package:acebot_front/bloc/auth/authCubit.dart';
import 'package:acebot_front/repository/authRepository.dart';
import 'package:acebot_front/bloc/user/selfCubit.dart';
import 'package:acebot_front/bloc/user/otherCubit.dart';
import 'package:acebot_front/repository/userRepository.dart';
import 'package:acebot_front/bloc/thread/threadCubit.dart';
import 'package:acebot_front/repository/threadRepository.dart';
import 'package:acebot_front/bloc/answer/answerCubit.dart';
import 'package:acebot_front/repository/answerRepository.dart';
import 'package:acebot_front/repository/questionRepository.dart';
import 'package:acebot_front/bloc/prompt/promptCubit.dart';
import 'package:acebot_front/repository/promptRepository.dart';
import 'package:acebot_front/bloc/project/projectCubit.dart';
import 'package:acebot_front/repository/projectRepository.dart';

void main() async {
  /**
   * 각 Screen에서 새로운 Cubit을 Listen하기 전에
   * main.dart에서 항상 Provide해야 함.
   */

  // Cubits
  final authCubit = AuthCubit(repo: AuthRepository());
  final selfCubit = SelfCubit(repo: UserRepository());
  final otherCubit = OtherCubit(repo: UserRepository());
  final threadCubit = ThreadCubit(repo: ThreadRepository());
  final answerCubit =
      AnswerCubit(qRepo: QuestionRepository(), aRepo: AnswerRepository());
  final promptCubit = PromptCubit(repo: PromptRepository());
  final projectCubit = ProjectCubit(repo: ProjectRepository());

  // Dio 인스턴스 생성
  configureDio(authCubit);

  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => authCubit),
    BlocProvider(create: (_) => selfCubit),
    BlocProvider(create: (_) => otherCubit),
    BlocProvider(create: (_) => threadCubit),
    BlocProvider(create: (_) => answerCubit),
    BlocProvider(create: (_) => promptCubit),
    BlocProvider(create: (_) => projectCubit)
  ], child: const AppView()));

  Bloc.observer = EventsObserver();
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      builder: FToastBuilder(),
      routerConfig: AppRouter.router,
      theme: ThemeData(
        fontFamily: "Pretendard",
        scaffoldBackgroundColor: const Color(0xffffffff),
      ),
    );
  }
}
