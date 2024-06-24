import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import 'package:acebot_front/models/answerModel.dart';
import 'package:acebot_front/bloc/answer/answerState.dart';
import 'package:acebot_front/repository/answerRepository.dart';
import 'package:acebot_front/repository/questionRepository.dart';

class AnswerCubit extends Cubit<List<AnswerState>> {
  final QuestionRepository qRepo;
  final AnswerRepository aRepo;

  AnswerCubit({required this.qRepo, required this.aRepo}) : super([]);

  // 추후 개발 때는 length가 늘어나며 여러 질문/답변이 한 화면에 나타날 수 있어야 함.
  // 1차 개발에서는 한 화면에 한 질문/답변만
  void ready() {
    // emit([...state, EmptyState()]);
    emit([EmptyState()]);
  }

  // 질문 후 답변 세팅
  Future<dynamic> quest(String question, int idx) async {
    void setLoadedState(dynamic value) {
      try {
        // 추후 개발 때는 length가 늘어나며 여러 질문/답변이 한 화면에 나타날 수 있어야 함.
        // 1차 개발에서는 한 화면에 한 질문/답변만
        // state[idx] = LoadedState(answerJson: AnswerModel.fromJson(value));

        // emit([...state]);
        emit([LoadedState(answerJson: AnswerModel.fromJson(value))]);
      } on DioException catch (err) {
        emit([
          ErrorState(
              message: err.toString(), statusCode: err.response?.statusCode)
        ]);
      }
    }

    try {
      // 추후 개발 때는 length가 늘어나며 여러 질문/답변이 한 화면에 나타날 수 있어야 함.
      // 1차 개발에서는 한 화면에 한 질문/답변만
      // state[idx] = LoadingState();
      // emit([...state]);
      emit([LoadingState()]);

      final firstRes = await qRepo.createQuestion(question, null);

      final questionId = firstRes['questionId'];
      final threadId = firstRes['threadId'];

      await aRepo.createAnswer(questionId, setLoadedState);

      return {"questionId": questionId, "threadId": threadId};
    } on DioException catch (err) {
      // 추후 개발 때는 length가 늘어나며 여러 질문/답변이 한 화면에 나타날 수 있어야 함.
      // 1차 개발에서는 한 화면에 한 질문/답변만
      // state[idx] = ErrorState(
      //     message: err.toString(), statusCode: err.response?.statusCode);
      // emit([...state]);
      emit([
        ErrorState(
            message: err.toString(), statusCode: err.response?.statusCode)
      ]);
    }
  }

  void clearCubit() {
    emit([]);
  }
}
