import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import 'package:acebot_front/bloc/auth/authState.dart';
import 'package:acebot_front/repository/authRepository.dart';
import 'package:acebot_front/models/authModel.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repo;

  AuthCubit({required this.repo}) : super(EmptyState());

  // 로그인 버튼 누를 시 이벤트 및 데이터 가공
  Future<void> pushLoginButtonEvent(String userId, String userPassword) async {
    try {
      emit(LoadingState());

      final authJson = await repo.authenticate(userId, userPassword);

      emit(LoadedState(authJson: AuthModel.fromJson(authJson)));
    } on DioException catch (err) {
      emit(ErrorState(
          message: err.toString(), statusCode: err.response?.statusCode));
    }
  }
}
