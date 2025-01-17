/// 스레드 정보 서비스 모음
library;

import 'package:acebot_front/api/http.dart';

class ThreadService {
  getThreadsList(int page, int size, String? search) {
    return dio.get("/v1/threads",
        queryParameters: {"page": page, "size": size, "search": search});
  }

  getThread(int threadId) {
    return dio
        .get("/v1/threads/$threadId", queryParameters: {"page": 1, "size": 20});
  }

  patchThread(List<dynamic> threadIds, String? title, int? projectId) {
    dynamic data = {"threadIds": threadIds};

    if (title != null) {
      data = {...data, "title": title};
    }

    if (projectId != null) {
      data = {...data, "projectId": projectId};
    }

    return dio.patch("/v1/threads", data: data);
  }

  deleteThreads(List<dynamic> threadIds) {
    String ids = threadIds.join(",");
    return dio.delete("/v1/threads", queryParameters: {"ids": ids});
  }
}
