import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import 'package:acebot_front/spinner.dart';
import 'package:acebot_front/presentation/widget/common/baseDialog.dart';

import 'package:acebot_front/api/http.dart';
import 'package:acebot_front/appRouter.dart';
import 'package:acebot_front/bloc/eventsObserver.dart';

import 'package:acebot_front/bloc/auth/authCubit.dart';
import 'package:acebot_front/bloc/auth/authState.dart';
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
import 'package:acebot_front/bloc/request/requestBloc.dart';

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

  // bloc
  final requestBloc = RequestBloc();

  // Dio 인스턴스 생성
  configureDio(authCubit, requestBloc);

  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => authCubit),
    BlocProvider(create: (_) => selfCubit),
    BlocProvider(create: (_) => otherCubit),
    BlocProvider(create: (_) => threadCubit),
    BlocProvider(create: (_) => answerCubit),
    BlocProvider(create: (_) => promptCubit),
    BlocProvider(create: (_) => projectCubit),
    BlocProvider(create: (_) => requestBloc)
  ], child: const AppView()));

  Bloc.observer = EventsObserver();
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is ErrorState && state.statusCode == 401) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return BaseDialog(
                      title: "권한 갱신 실패",
                      content: "다시 로그인해주시기 바랍니다.",
                      buttonsList: [
                        Expanded(
                            child: OutlinedButton(
                                onPressed: () {
                                  context.go('/login');
                                  Navigator.pop(context);
                                },
                                style: OutlinedButton.styleFrom(
                                    backgroundColor: const Color(0xff000000),
                                    side: const BorderSide(
                                        color: Color(0xff000000), width: 1.0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0)),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 13)),
                                child: const Text("확인",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xffffffff))))),
                      ]);
                });
          }
        },
        child: MaterialApp.router(
          builder: (context, child) {
            return FToastBuilder()(context,
                BlocBuilder<RequestBloc, RequestState>(
                    builder: (context, requestState) {
              if (requestState.isLoading) {
                return Stack(children: [
                  child!,
                  Container(
                      color: Colors.black54,
                      child: const Center(child: Spinner()))
                ]);
              }

              return child!;
            }));
          },
          routerConfig: AppRouter.router,
          theme: ThemeData(
            fontFamily: "Pretendard",
            scaffoldBackgroundColor: const Color(0xffffffff),
          ),
        ));
  }
}
