import 'dart:io';
import 'package:dio/dio.dart';

import 'package:acebot_front/api/http.dart';

class QuestionService {
  postInitialQuestion(String question, List<dynamic>? files) async {
    FormData formData = FormData.fromMap({
      "question": question,
      "files": files != null
          ? await Future.wait(files
              .map((file) => MultipartFile.fromFile(file.path,
                  filename: file.path.split('/').last))
              .toList())
          : []
    });

    return dio.post('/v1/questions',
        data: formData,
        options: Options(headers: {"Content-Type": "multipart/form-data"}));
  }

  postVoiceRecordedQuest(String question, List<dynamic>? voicesList) async {
    List<dynamic> tempList = List.from(voicesList!);
    tempList = tempList.map((item) => item.split('.')[0]).toList();

    return dio.post('/v1/note/question',
        data: {"question": question, "content": tempList});
  }

  feedback(Map<String, bool?> feedback, int questionId) {
    return dio.patch('/v1/questions',
        data: {'data': feedback, 'question_id': questionId});
  }
}
