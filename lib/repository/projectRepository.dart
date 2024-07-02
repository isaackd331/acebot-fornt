import 'package:dio/dio.dart';
import 'package:acebot_front/api/projectService.dart';

class ProjectRepository {
  // 최초 데이터 획득
  Future<Map<String, dynamic>> initProjects() async {
    Response res;

    res = await ProjectService().getProjectsList(1, 20, null);

    return res.data;
  }
}
