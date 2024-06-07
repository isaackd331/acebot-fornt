import 'package:acebot_front/api/questionService.dart';
import 'package:dio/dio.dart';
import 'dart:io';

class QuestionRepository {
  Future<Map<String, dynamic>> createQuestion(String question, List<File>? files) async {
    Response res = await QuestionService().postInitialQuestion(question, files);

    return res.data;
  }
}
