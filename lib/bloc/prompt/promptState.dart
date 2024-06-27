import 'package:acebot_front/models/promptModel.dart';

abstract class PromptState {}

// 데이터 없는 상태
class EmptyState extends PromptState {}

// 데이터 로드 요청 중 상태
class LoadingState extends PromptState {}

// 데이터 요청 중 오류 발생 상태
class ErrorState extends PromptState {
  final String message;
  final int? statusCode;

  ErrorState({required this.message, required this.statusCode});
}

// 데이터 로드 완료 상태
class LoadedState extends PromptState {
  // 로드 결과 데이터
  final PromptModel promptJson;

  LoadedState({required this.promptJson});
}
