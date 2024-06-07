import 'dart:io';

import 'package:acebot_front/api/http.dart';
import 'package:dio/dio.dart';

class QuestionService {
  postInitialQuestion(String question, List<File>? files) {
    FormData formData = FormData.fromMap({
      "question": question,
      "files": files
    });

    return dio.post('/v1/questions', data: formData,
    options: Options(
      headers: {
        "Content-Type": "multipart/form-data"
      }
    )
    );
  }

  feedback(Map<String, bool> feedback, int questionId) {
    return dio.patch('/v1/questions', data: {
      'data': feedback,
      'question_id': questionId
    });
  }
}
