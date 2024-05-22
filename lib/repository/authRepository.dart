import 'package:acebot_front/api/authService.dart';
import 'package:dio/dio.dart';

class AuthRepository {
  // 토큰 획득을 위한 인증
  Future<Map<String, dynamic>> authenticate(userId, userPassword) async {
    Response res;

    res = await AuthService().getAuthToken(userId, userPassword);

    // return 값에 userId를 추가하기
    final result = res.data;

    return res.data;
  }

  // 토큰 제거
  Future<void> removeToken() async {
    return;
  }

  // 토큰 재발급
  Future<void> reissueToken(String refreshToken) async {
    return;
  }

  // 토근 소지 여부 확인
  Future<void> hasToken() async {
    return;
  }
}
