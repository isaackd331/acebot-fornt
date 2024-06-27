import 'package:acebot_front/api/utilService.dart';
import 'package:dio/dio.dart';

class PromptRepository {
  // 프롬프트 얻어오기
  Future<Map<String, dynamic>> getPrompts() async {
    Response res;

    res = await UtilService().getHomePrompts();

    return res.data;
  }
}
