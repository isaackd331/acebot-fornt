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

  patchProject(int projectId, String title) {
    return dio.patch("/v1/projects/$projectId", data: {"title": title});
  }

  deleteProjects(List<dynamic> projectIds) {
    String ids = projectIds.join(",");
    return dio.delete("/v1/projects", queryParameters: {"ids": ids});
  }
}
