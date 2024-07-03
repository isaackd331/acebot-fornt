import 'package:dio/dio.dart';
import 'package:acebot_front/api/threadService.dart';

class ThreadRepository {
  // 최초 데이터 획득
  Future<Map<String, dynamic>> initThreads() async {
    Response res;

    res = await ThreadService().getThreadsList(1, 20, null);

    return res.data;
  }

  // 이후 데이터 획득
  Future<Map<String, dynamic>> getThreads(int page, String keyword) async {
    Response res = await ThreadService().getThreadsList(page, 20, keyword);

    return res.data;
  }

  // 데이터 삭제
  Future<void> delete(List<dynamic> threadIds) async {
    await ThreadService().deleteThreads(threadIds);
  }
}
