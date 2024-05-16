/**
 * 권한 관련 서비스 모음
 * 로그인, 로그아웃 등
 */

import 'package:dio/dio.dart';
import 'package:acebot_front/data/http.dart';

class AuthService {
  login(String userId, String userPassword) async {
    Response res;

    res = await dio.post("/v1/auth/login",
        data: {"email": userId, "password": userPassword, "redirect": false});

    return res.data;
  }
}
