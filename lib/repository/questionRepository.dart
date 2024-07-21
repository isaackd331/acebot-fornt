import 'package:acebot_front/api/questionService.dart';
import 'package:dio/dio.dart';
import 'dart:io';

class QuestionRepository {
  Future<Map<String, dynamic>> createQuestion(
      String question, List<dynamic>? files) async {
    Response res = await QuestionService().postInitialQuestion(question, files);

    return res.data;
  }

  Future<Map<String, dynamic>> createVoiceQuestion(
      String question, List<dynamic>? voicesList) async {
    Response res =
        await QuestionService().postVoiceRecordedQuest(question, voicesList);

    return res.data;
  }
}
