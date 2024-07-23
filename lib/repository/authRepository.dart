import 'package:acebot_front/api/authService.dart';
import 'package:dio/dio.dart';

class AuthRepository {
  // 토큰 획득을 위한 인증
  Future<Map<String, dynamic>> authenticate(userId, userPassword) async {
    Response res;

    res = await AuthService().getAuthToken(userId, userPassword);

    return res.data;
  }

  Future<Map<String, dynamic>> refreshAuthentication(
      userId, refreshToken) async {
    Response res = await AuthService().refresh(userId, refreshToken);

    return res.data;
  }

  void sessionOut() async {
    await AuthService().logout();
  }
}
