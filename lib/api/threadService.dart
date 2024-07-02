/// 스레드 정보 서비스 모음
library;

import 'package:acebot_front/api/http.dart';
import 'package:dio/dio.dart';

class ThreadService {
  getThreadsList(int page, int size, String? search) {
    return dio.get("/v1/threads",
        queryParameters: {"page": page, "size": size, "search": search});
  }

  patchThread(int threadId, String? title, int? projectId) {
    dynamic data = {};

    if (title == null) {
      data = {"projectId": projectId};
    } else {
      data = {"title": title, "projectId": projectId};
    }
    return dio.patch("/v1/threads/$threadId", data: data);
  }
}
