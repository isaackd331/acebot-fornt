/// 유저 정보 서비스 모음
library;

import 'package:acebot_front/api/http.dart';
import 'package:dio/dio.dart';

class UserService {
  // 유저 정보 획득
  getUserInfo(String userId) {
    return dio.get("/v1/users", options: Options(headers: {'email': userId}));
  }

  // 검증
  verify(String email, String? value, String type) {
    Map<String, dynamic> data;

    if (value != null) {
      data = {"email": email, "value": value};
    } else {
      data = {"email": email};
    }

    return dio.post("/v1/users/verification/$type", data: data);
  }
}
