import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:acebot_front/api/http.dart';
import 'package:acebot_front/appRouter.dart';
import 'package:acebot_front/bloc/auth/authCubit.dart';
import 'package:acebot_front/repository/authRepository.dart';
import 'package:acebot_front/bloc/events_observer.dart';

void main() async {
  // Dio 인스턴스 생성
  configureDio();

  runApp(BlocProvider(
      create: (_) => AuthCubit(repo: AuthRepository()), child: AppView()));

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
