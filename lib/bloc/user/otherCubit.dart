/**
 * 앱 사용중인 사용자 자신의 Cubit 정의
 */

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import 'package:acebot_front/bloc/user/otherState.dart';
import 'package:acebot_front/repository/userRepository.dart';
import 'package:acebot_front/models/userModel.dart';

class OtherCubit extends Cubit<OtherState> {
  final UserRepository repo;

  OtherCubit({required this.repo}) : super(EmptyState());

  // 홈 화면 진입 시 이벤트 및 데이터 가공
  Future<void> getOtherData(String userId) async {
    try {
      // 다른 유저를 검색할 때마다 Cubit 내 데이터 초기화
      emit(EmptyState());

      emit(LoadingState());

      final userJson = await repo.getUserInfo(userId);

      emit(LoadedState(userJson: UserModel.fromJson(userJson)));
    } on DioException catch (err) {
      emit(ErrorState(
          message: err.toString(), statusCode: err.response?.statusCode));
    }
  }
}
