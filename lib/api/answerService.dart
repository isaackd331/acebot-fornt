import 'package:acebot_front/api/http.dart';
import 'package:dio/dio.dart';

class AnswerService {
  getAnswer(int questionId) {
    return dio.get('/v1/answers/$questionId',
        options: Options(responseType: ResponseType.stream));
  }

  feedback(int questionId, bool? value) {
    return dio.patch('/v1/questions/$questionId', data: {"feedback": value});
  }
}
