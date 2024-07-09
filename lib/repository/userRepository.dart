import 'package:acebot_front/api/userService.dart';
import 'package:dio/dio.dart';

class UserRepository {
  // 유저 정보 획득
  Future<Map<String, dynamic>> getUserInfo(userId) async {
    Response res;

    res = await UserService().getUserInfo(userId);

    return res.data;
  }

  // 유저 정보 수정
  Future<void> patchUserInfo(dynamic params) async {
    await UserService().patchUserInfo(params);
  }
}
