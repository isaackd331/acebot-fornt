import 'package:acebot_front/api/http.dart';
import 'package:dio/dio.dart';

class QuestionService {
  postInitialQuestion(String question) {
    return dio.post('/v1/questions', data: {
      'question': question
    });
  }

  getAnswer(int questionId) {
    return dio.get('/v1/questions/$questionId');
  }

  feedback(Map<String, bool> feedback, int questionId) {
    return dio.patch('/v1/questions', data: {
      'data': feedback,
      'question_id': questionId
    });
  }
}
