import 'package:acebot_front/models/threadModel.dart';

abstract class ThreadState {}

// 데이터 없는 상태
class EmptyState extends ThreadState {}

// 데이터 로드 요청 중 상태
class LoadingState extends ThreadState {}

// 데이터 요청 중 오류 발생 상태
class ErrorState extends ThreadState {
  final String message;
  final int? statusCode;

  ErrorState({required this.message, required this.statusCode});
}

// 데이터 로드 완료 상태
class LoadedState extends ThreadState {
  // 로드 결과 데이터
  final ThreadModel threadJson;

  LoadedState({required this.threadJson});
}
