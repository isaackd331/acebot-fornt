import 'dart:io';
import 'package:dio/dio.dart';

import 'package:acebot_front/api/http.dart';

class QuestionService {
  postInitialQuestion(String question, List<dynamic>? files) async {
    FormData formData = FormData.fromMap({
      "question": question,
    });
    if (files != null && files.isNotEmpty) {
      if (files[0] is File) {
        formData = FormData.fromMap({
          "question": question,
          "files": await Future.wait(files
              .map((file) => MultipartFile.fromFile(file.path,
                  filename: file.path.split('/').last))
              .toList())
        });
      } else if (files[0] is int) {
        formData = FormData.fromMap({"question": question, "fileIds": files});
      }
    }

    return dio.post('/v1/questions',
        data: formData,
        options: Options(
            headers: {"Content-Type": "multipart/form-data"},
            extra: {"skipSpinner": true}));
  }

  postVoiceRecordedQuest(String question, List<dynamic>? voicesList) async {
    List<dynamic> tempList = List.from(voicesList!);
    tempList = tempList.map((item) => item.split('.')[0]).toList();

    return dio.post('/v1/note/question',
        data: {"question": question, "content": tempList},
        options: Options(extra: {"skipSpinner": true}));
  }

  feedback(Map<String, bool?> feedback, int questionId) {
    return dio.patch('/v1/questions',
        data: {'data': feedback, 'question_id': questionId});
  }
}
