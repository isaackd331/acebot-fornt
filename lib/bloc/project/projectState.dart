import 'package:acebot_front/models/projectModel.dart';

abstract class ProjectState {}

// 데이터 없는 상태
class EmptyState extends ProjectState {}

// 데이터 로드 요청 중 상태
class LoadingState extends ProjectState {}

// 데이터 요청 중 오류 발생 상태
class ErrorState extends ProjectState {
  final String message;
  final int? statusCode;

  ErrorState({required this.message, required this.statusCode});
}

// 데이터 로드 완료 상태
class LoadedState extends ProjectState {
  // 로드 결과 데이터
  final ProjectModel projectJson;

  LoadedState({required this.projectJson});
}
