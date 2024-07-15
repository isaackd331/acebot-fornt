import 'package:acebot_front/api/questionService.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

class QuestionRepository {
  Future<Map<String, dynamic>> createQuestion(
      String question, List<PlatformFile>? files) async {
    Response res = await QuestionService().postInitialQuestion(question, files);

    return res.data;
  }
}
