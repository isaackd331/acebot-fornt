import 'package:acebot_front/models/authModel.dart';

abstract class AuthState {}

// 토큰이 없는 상태
class EmptyState extends AuthState {}

// 데이터 로드 요청 중 상태
class LoadingState extends AuthState {}

// 데이터 요청 중 오류 발생 상태
class ErrorState extends AuthState {
  final String message;
  final int? statusCode;

  ErrorState({required this.message, required this.statusCode});
}

// 데이터 로드 완료 상태
class LoadedState extends AuthState {
  // 로드 결과 데이터
  final AuthModel authJson;

  LoadedState({required this.authJson});
}
