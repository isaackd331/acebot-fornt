import 'package:go_router/go_router.dart';

import 'package:acebot_front/presentation/screen/Login.dart';
import 'package:acebot_front/presentation/screen/Join.dart';
import 'package:acebot_front/presentation/screen/Home.dart';
import 'package:acebot_front/presentation/screen/Mypage.dart';

abstract class AppRouter {
  static GoRouter router = GoRouter(initialLocation: '/login', routes: [
    GoRoute(path: '/login', builder: (_, __) => Login()),
    GoRoute(path: '/join', builder: (_, __) => Join()),
    GoRoute(path: '/home', builder: (_, __) => Home()),
    GoRoute(path: '/mypage', builder: (_, __) => Mypage())
  ]);
}
