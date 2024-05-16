import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:acebot_front/data/http.dart';
import 'package:acebot_front/presentation/screen/Login.dart';

void main() async {
  /**
   * Splash Image 관련 코드
   * Splash Image를 특정 행위가 종료되기 전까지 유지시킬 수 있음
   */
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Dio 인스턴스 생성
  configureDio();

  runApp(MaterialApp.router(
    routerConfig: Router.router,
    theme: ThemeData(fontFamily: "Pretendard"),
  ));
}

class Router {
  static GoRouter router = GoRouter(
      initialLocation: '/login',
      routes: [GoRoute(path: '/login', builder: (_, __) => Login())]);
}
