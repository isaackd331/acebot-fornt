/// 앱 사용중인 사용자 자신의 Cubit 정의
library;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import 'package:acebot_front/bloc/user/selfState.dart';
import 'package:acebot_front/repository/userRepository.dart';
import 'package:acebot_front/models/userModel.dart';

class SelfCubit extends Cubit<SelfState> {
  final UserRepository repo;

  SelfCubit({required this.repo}) : super(EmptyState());

  // 홈 화면 진입 시 이벤트 및 데이터 가공
  Future<void> getSelfData(String userId) async {
    try {
      emit(LoadingState());

      final userJson = await repo.getUserInfo(userId);

      emit(LoadedState(userJson: UserModel.fromJson(userJson)));
    } on DioException catch (err) {
      emit(ErrorState(
          message: err.toString(), statusCode: err.response?.statusCode));
    }
  }

  // 유저 정보 수정
  Future<void> patchSelfData(dynamic params) async {
    try {
      await repo.patchUserInfo(params);

      if (state is LoadedState) {
        // how to get the previous userJson
        final thePrev = (state as LoadedState).userJson.toJson();

        emit(
            LoadedState(userJson: UserModel.fromJson({...thePrev, ...params})));
      }
    } on DioException catch (err) {
      emit(ErrorState(
          message: err.toString(), statusCode: err.response?.statusCode));
    }
  }
}
