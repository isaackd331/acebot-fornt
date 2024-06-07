import 'package:acebot_front/models/answerModel.dart';

abstract class AnswerState {}

// 데이터 없는 상태
class EmptyState extends AnswerState {}

// 데이터 로드 요청 중 상태
class LoadingState extends AnswerState {}

// 데이터 요청 중 오류 발생 상태
class ErrorState extends AnswerState {
  final String message;
  final int? statusCode;

  ErrorState({required this.message, required this.statusCode});
}

// 데이터 로드 완료 상태
class LoadedState extends AnswerState {
  // 로드 결과 데이터
  final AnswerModel answerJson;

  LoadedState({required this.answerJson});
}
