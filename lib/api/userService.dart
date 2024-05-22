/**
 * 유저 정보 서비스 모음
 */

import 'package:acebot_front/api/http.dart';
import 'package:dio/dio.dart';

class UserService {
  getUserInfo(String userId) {
    return dio.get("/v1/users", options: Options(headers: {'email': userId}));
  }
}
