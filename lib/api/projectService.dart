/// 스레드 정보 서비스 모음
library;

import 'package:acebot_front/api/http.dart';

class ProjectService {
  getProjectsList(int page, int size, String? search) {
    return dio.get("/v1/projects",
        queryParameters: {"page": page, "size": size, "search": search});
  }

  postProject(String title) {
    return dio.post("/v1/projects", data: {"title": title});
  }
}
