import 'package:acebot_front/api/http.dart';
import 'package:dio/dio.dart';

class AnswerService {
  getAnswer(int questionId) {
    return dio.get('/v1/answers/$questionId',
      options: Options(
        responseType: ResponseType.stream
      )
    );
  }
}
