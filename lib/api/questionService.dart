import 'package:acebot_front/api/http.dart';

class QuestionService {
  postInitialQuestion(String question) {
    return dio.post('/v1/questions', data: {
      'question': question
    });
  }

  feedback(Map<String, bool> feedback, int questionId) {
    return dio.patch('/v1/questions', data: {
      'data': feedback,
      'question_id': questionId
    });
  }
}
