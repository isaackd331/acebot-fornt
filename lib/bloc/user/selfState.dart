/**
 * 앱 사용중인 사용자 자신의 Cubit State 정의
 */

import 'package:acebot_front/models/userModel.dart';

abstract class SelfState {}

// 데이터 없는 상태
class EmptyState extends SelfState {}

// 데이터 로드 요청 중 상태
class LoadingState extends SelfState {}

// 데이터 요청 중 오류 발생 상태
class ErrorState extends SelfState {
  final String message;
  final int? statusCode;

  ErrorState({required this.message, required this.statusCode});
}

// 데이터 로드 완료 상태
class LoadedState extends SelfState {
  // 로드 결과 데이터
  final UserModel userJson;

  LoadedState({required this.userJson});
}
