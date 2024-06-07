import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import 'package:acebot_front/models/answerModel.dart';
import 'package:acebot_front/bloc/answer/answerState.dart';
import 'package:acebot_front/repository/answerRepository.dart';
import 'package:acebot_front/repository/questionRepository.dart';

class AnswerCubit extends Cubit<AnswerState> {
  final QuestionRepository qRepo;
  final AnswerRepository aRepo;

  AnswerCubit({
    required this.qRepo,
    required this.aRepo
  }) : super(EmptyState());

  // 질문 후 답변 세팅
  Future<void> quest(String question) async {
    void setLoadedState(dynamic value) {
      print(value);

      emit(LoadedState(answerJson: AnswerModel.fromJson(value)));
    }

    try {
      emit(LoadingState());

      final firstRes = await qRepo.createQuestion(question, null);

      final questionId = firstRes['questionId'];

      await aRepo.createAnswer(questionId, setLoadedState);
    } on DioException catch (err) {
      emit(ErrorState(
        message: err.toString(), statusCode: err.response?.statusCode
      ));
    }
  }
}
