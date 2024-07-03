import 'package:dio/dio.dart';
import 'package:acebot_front/api/projectService.dart';

class ProjectRepository {
  // 최초 데이터 획득
  Future<Map<String, dynamic>> initProjects() async {
    Response res;

    res = await ProjectService().getProjectsList(1, 20, null);

    return res.data;
  }

  // 이후 데이터 획득
  Future<Map<String, dynamic>> getProjects(int page, String keyword) async {
    Response res = await ProjectService().getProjectsList(page, 20, keyword);

    return res.data;
  }

  // 새 데이터 생성
  Future<dynamic> postProject(String title) async {
    Response res;

    res = await ProjectService().postProject(title);

    return res.data;
  }
}
