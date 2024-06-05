import 'package:dio/dio.dart';
import 'package:acebot_front/api/threadService.dart';

class ThreadRepository {
  // 최초 데이터 획득
  Future<Map<String, dynamic>> initThreads() async {
    Response res;

    res = await ThreadService().getThreadsList(1, 20, null);

    return res.data;
  }
}
