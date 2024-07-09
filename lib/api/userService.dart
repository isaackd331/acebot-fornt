/// 유저 정보 서비스 모음
library;

import 'package:acebot_front/api/http.dart';
import 'package:dio/dio.dart';

class UserService {
  // 유저 정보 획득
  getUserInfo(String userId) {
    return dio.get("/v1/users", options: Options(headers: {'email': userId}));
  }

  /// 검증
  /// email: 가입 이메일 검증
  /// activated: 이메일 활성 코드 검증
  /// send-activated: 활성 코드 발송
  /// password: 비밀번호 재설정 코드 검증
  /// send-password: 비밀번호 재설정 코드 발송
  verify(String email, String? value, String type) {
    Map<String, dynamic> data;

    if (value != null) {
      data = {"email": email, "value": value};
    } else {
      data = {"email": email};
    }

    return dio.post("/v1/users/verification/$type", data: data);
  }

  // 가입
  join(dynamic params) {
    return dio.post("/v1/users", data: params);
  }

  // 유저 정보 수정
  patchUserInfo(dynamic params) {
    return dio.patch('/v1/users', data: params);
  }
}
