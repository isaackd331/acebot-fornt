import 'package:dio/dio.dart';
import 'package:acebot_front/api/projectService.dart';

class ProjectRepository {
  // 최초 데이터 획득
  Future<Map<String, dynamic>> getProjectsList() async {
    Response res;

    res = await ProjectService().getProjectsList(1, 20, null);

    return res.data;
  }

  // 새 데이터 생성
  Future<void> postProject(String title) async {
    Response res;

    res = await ProjectService().postProject(title);

    return res.data;
  }
}
