/// 권한 관련 서비스 모음
/// 로그인, 로그아웃 등
library;

import 'package:acebot_front/api/http.dart';

class AuthService {
  getAuthToken(String userId, String userPassword) {
    return dio.post("/v1/auth/login",
        data: {"email": userId, "password": userPassword, "redirect": false});
  }

  refresh(String userId, String refreshToken) {
    return dio.post("/v1/auth/refresh",
        data: {"email": userId, "refreshToken": refreshToken});
  }

  logout() {
    return dio.post("/v1/auth/logout");
  }
}
