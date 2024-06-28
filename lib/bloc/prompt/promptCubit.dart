import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import 'package:acebot_front/bloc/prompt/promptState.dart';
import 'package:acebot_front/repository/promptRepository.dart';
import 'package:acebot_front/models/promptModel.dart';

class PromptCubit extends Cubit<PromptState> {
  final PromptRepository repo;

  PromptCubit({required this.repo}) : super(EmptyState());

  // 로그인 성공 시
  Future<void> loginSuccess() async {
    try {
      emit(LoadingState());

      final promptJson = await repo.getPrompts();

      emit(LoadedState(promptJson: PromptModel.fromJson(promptJson)));
    } on DioException catch (err) {
      emit(ErrorState(
          message: err.toString(), statusCode: err.response?.statusCode));
    }
  }

  void clearCubit() {
    emit(EmptyState());
  }
}
