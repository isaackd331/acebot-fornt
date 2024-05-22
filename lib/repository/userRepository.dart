import 'package:acebot_front/api/userService.dart';
import 'package:dio/dio.dart';

class UserRepository {
  // 유저 정보 획득
  Future<Map<String, dynamic>> getUserInfo(userId) async {
    Response res;

    res = await UserService().getUserInfo(userId);

    return res.data;
  }
}
