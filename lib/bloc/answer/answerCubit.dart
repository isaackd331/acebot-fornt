import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import 'package:acebot_front/models/answerModel.dart';
import 'package:acebot_front/bloc/answer/answerState.dart';
import 'package:acebot_front/repository/answerRepository.dart';
import 'package:acebot_front/repository/questionRepository.dart';

// 추후 개발 때는 length가 늘어나며 여러 질문/답변이 한 화면에 나타날 수 있어야 함.
// 1차 개발에서는 한 화면에 한 질문/답변만
// class AnswerCubit extends Cubit<List<AnswerState>> {
class AnswerCubit extends Cubit<AnswerState> {
  final QuestionRepository qRepo;
  final AnswerRepository aRepo;

  // 추후 개발 때는 length가 늘어나며 여러 질문/답변이 한 화면에 나타날 수 있어야 함.
  // 1차 개발에서는 한 화면에 한 질문/답변만
  // AnswerCubit({required this.qRepo, required this.aRepo}) : super([]);
  AnswerCubit({required this.qRepo, required this.aRepo}) : super(EmptyState());

  // 추후 개발 때는 length가 늘어나며 여러 질문/답변이 한 화면에 나타날 수 있어야 함.
  // 1차 개발에서는 한 화면에 한 질문/답변만
  // void ready() {
  // emit([...state, EmptyState()]);
  // }

  // 질문 후 답변 세팅
  // 추후 개발 때는 length가 늘어나며 여러 질문/답변이 한 화면에 나타날 수 있어야 함.
  // 1차 개발에서는 한 화면에 한 질문/답변만
  // Future<dynamic> quest(String question, int idx) async {
  Future<dynamic> quest(String question, TextEditingController controller,
      List<dynamic>? uploadedFiles, bool isVoiceRecorded) async {
    void setLoadedState(dynamic value) {
      try {
        // 추후 개발 때는 length가 늘어나며 여러 질문/답변이 한 화면에 나타날 수 있어야 함.
        // 1차 개발에서는 한 화면에 한 질문/답변만
        // state[idx] = LoadedState(answerJson: AnswerModel.fromJson(value));

        // emit([...state]);
        emit(LoadedState(answerJson: AnswerModel.fromJson(value)));
      } on DioException catch (err) {
        emit(ErrorState(
            message: err.toString(), statusCode: err.response?.statusCode));
      }
    }

    try {
      // 추후 개발 때는 length가 늘어나며 여러 질문/답변이 한 화면에 나타날 수 있어야 함.
      // 1차 개발에서는 한 화면에 한 질문/답변만
      // state[idx] = LoadingState();
      // emit([...state]);
      emit(LoadingState());
      final receivedQuestion = question;
      controller.clear();

      if (uploadedFiles!.isNotEmpty) {
        if (!isVoiceRecorded) {
          final firstRes =
              await qRepo.createQuestion(receivedQuestion, uploadedFiles);

          final questionId = firstRes['questionId'];
          final threadId = firstRes['threadId'];

          await aRepo.createAnswer(questionId, setLoadedState);

          return {"questionId": questionId, "threadId": threadId};
        } else {
          final res =
              await qRepo.createVoiceQuestion(receivedQuestion, uploadedFiles);

          final dynamic tempJson = {
            "result_code": res['result_code'],
            "q_id": res['id'],
            "question": receivedQuestion,
            "template_name": "note",
            "main_paragraph": res['outputs'][0],
            "sub_paragraph": [],
            "feedback": "0",
            "date": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
            "recommend_prompt": [],
            "progress_state": "",
            "progress_message": [],
            "file_list": []
          };

          emit(LoadedState(answerJson: AnswerModel.fromJson(tempJson)));

          return {
            "questionId": DateTime.now().millisecondsSinceEpoch,
            "threadId": DateTime.now().millisecondsSinceEpoch
          };
        }
      } else {
        final firstRes = await qRepo.createQuestion(receivedQuestion, []);

        final questionId = firstRes['questionId'];
        final threadId = firstRes['threadId'];

        await aRepo.createAnswer(questionId, setLoadedState);

        return {"questionId": questionId, "threadId": threadId};
      }
    } on DioException catch (err) {
      // 추후 개발 때는 length가 늘어나며 여러 질문/답변이 한 화면에 나타날 수 있어야 함.
      // 1차 개발에서는 한 화면에 한 질문/답변만
      // state[idx] = ErrorState(
      //     message: err.toString(), statusCode: err.response?.statusCode);
      // emit([...state]);
      emit(ErrorState(
          message: err.toString(), statusCode: err.response?.statusCode));
    }
  }

  void clearCubit() {
    // 추후 개발 때는 length가 늘어나며 여러 질문/답변이 한 화면에 나타날 수 있어야 함.
    // 1차 개발에서는 한 화면에 한 질문/답변만
    // emit([]);
    emit(EmptyState());
  }
}
