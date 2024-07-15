import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

import 'package:acebot_front/api/http.dart';

class QuestionService {
  postInitialQuestion(String question, List<PlatformFile>? files) async {
    FormData formData = FormData.fromMap({
      "question": question,
      "files": files != null
          ? await Future.wait(files
              .map((file) =>
                  MultipartFile.fromFile(file.path!, filename: file.name))
              .toList())
          : []
    });

    return dio.post('/v1/questions',
        data: formData,
        options: Options(headers: {"Content-Type": "multipart/form-data"}));
  }

  feedback(Map<String, bool> feedback, int questionId) {
    return dio.patch('/v1/questions',
        data: {'data': feedback, 'question_id': questionId});
  }
}
