import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';

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

      Map<String, dynamic> authJson =
          await repo.authenticate(userId, userPassword);

      authJson = {...authJson, "email": userId};

      emit(LoadedState(authJson: AuthModel.fromJson(authJson)));
    } on DioException catch (err) {
      emit(ErrorState(
          message: err.toString(), statusCode: err.response?.statusCode));
    }
  }

  Future<void> refresh(String userId, String refreshToken) async {
    try {
      emit(LoadingState());

      Map<String, dynamic> authJson =
          await repo.refreshAuthentication(userId, refreshToken);

      authJson = {...authJson, "email": userId};

      emit(LoadedState(authJson: AuthModel.fromJson(authJson)));
    } on DioException catch (err) {
      emit(ErrorState(
          message: err.toString(), statusCode: err.response?.statusCode));

      repo.sessionOut();
    }
  }
}
