import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:acebot_front/api/http.dart';
import 'package:acebot_front/appRouter.dart';
import 'package:acebot_front/bloc/eventsObserver.dart';

import 'package:acebot_front/bloc/auth/authCubit.dart';
import 'package:acebot_front/repository/authRepository.dart';
import 'package:acebot_front/bloc/user/selfCubit.dart';
import 'package:acebot_front/bloc/user/otherCubit.dart';
import 'package:acebot_front/repository/userRepository.dart';

void main() async {
  // Cubits
  final authCubit = AuthCubit(repo: AuthRepository());
  final selfCubit = SelfCubit(repo: UserRepository());
  final otherCubit = OtherCubit(repo: UserRepository());

  // Dio 인스턴스 생성
  configureDio(authCubit);

  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => authCubit),
    BlocProvider(create: (_) => selfCubit),
    BlocProvider(create: (_) => otherCubit),
  ], child: AppView()));

  Bloc.observer = EventsObserver();
}

class AppView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      theme: ThemeData(fontFamily: "Pretendard"),
    );
  }
}
