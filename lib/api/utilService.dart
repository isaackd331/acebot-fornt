import 'package:acebot_front/api/http.dart';
import 'package:dio/dio.dart';

class UtilService {
  getHomePrompts() {
    return dio.get("/prompts?client_type=App");
  }

  getWorksRolesList() {
    return dio.get("/roles-works");
  }

  getPrivacyPolicy() {
    return dio.get("/terms/privacy");
  }

  getServicePolicy() {
    return dio.get("/terms/service");
  }
}
