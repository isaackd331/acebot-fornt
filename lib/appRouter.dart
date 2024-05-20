import 'package:go_router/go_router.dart';

import 'package:acebot_front/presentation/screen/Login.dart';
import 'package:acebot_front/presentation/screen/Join.dart';

abstract class AppRouter {
  static GoRouter router = GoRouter(initialLocation: '/login', routes: [
    GoRoute(path: '/login', builder: (_, __) => Login()),
    GoRoute(path: '/join', builder: (_, __) => Join()),
  ]);
}
