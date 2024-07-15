import 'package:go_router/go_router.dart';

import 'package:acebot_front/presentation/screen/Login.dart';
import 'package:acebot_front/presentation/screen/Join.dart';
import 'package:acebot_front/presentation/screen/Home.dart';
import 'package:acebot_front/presentation/screen/Mypage.dart';
import 'package:acebot_front/presentation/screen/History.dart';
import 'package:acebot_front/presentation/screen/Terms.dart';
import 'package:acebot_front/splash.dart';

abstract class AppRouter {
  static GoRouter router = GoRouter(initialLocation: '/splash', routes: [
    GoRoute(path: '/splash', builder: (_, __) => const Splash()),
    GoRoute(path: '/login', builder: (_, __) => const Login()),
    GoRoute(path: '/join', builder: (_, __) => const Join()),
    GoRoute(path: '/home', builder: (_, __) => const Home()),
    GoRoute(path: '/mypage', builder: (_, __) => const Mypage()),
    GoRoute(path: '/history', builder: (_, __) => const History()),
    GoRoute(path: '/terms', builder: (_, __) => const Terms()),
  ]);
}
