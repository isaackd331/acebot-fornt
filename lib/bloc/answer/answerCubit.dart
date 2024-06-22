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

  void ready() {
    emit([...state, EmptyState()]);
  }

  // 질문 후 답변 세팅
  Future<void> quest(String question, int idx) async {
    void setLoadedState(dynamic value) {
      state[idx] = LoadedState(answerJson: AnswerModel.fromJson(value));

      emit([...state]);
    }

    try {
      state[idx] = LoadingState();
      emit([...state]);

      final firstRes = await qRepo.createQuestion(question, null);

      final questionId = firstRes['questionId'];

      await aRepo.createAnswer(questionId, setLoadedState);
    } on DioException catch (err) {
      state[idx] = ErrorState(
          message: err.toString(), statusCode: err.response?.statusCode);
      emit([...state]);
    }
  }

  void clearCubit() {
    emit([]);
  }
}
