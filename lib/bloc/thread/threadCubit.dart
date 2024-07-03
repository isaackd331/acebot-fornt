import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import 'package:acebot_front/bloc/thread/threadState.dart';
import 'package:acebot_front/models/threadModel.dart';
import 'package:acebot_front/repository/threadRepository.dart';

class ThreadCubit extends Cubit<ThreadState> {
  final ThreadRepository repo;

  ThreadCubit({required this.repo}) : super(EmptyState());

  // init
  Future<void> init() async {
    try {
      emit(LoadingState());

      final threadJson = await repo.initThreads();

      emit(LoadedState(threadJson: ThreadModel.fromJson(threadJson)));
    } on DioException catch (err) {
      emit(ErrorState(
          message: err.toString(), statusCode: err.response?.statusCode));
    }
  }

  // paging
  Future<void> paging(int pageKey, String keyword) async {
    try {
      final threadJson = await repo.getThreads(pageKey, keyword);

      emit(LoadedState(threadJson: ThreadModel.fromJson(threadJson)));
    } on DioException catch (err) {
      emit(ErrorState(
          message: err.toString(), statusCode: err.response?.statusCode));
    }
  }

  // delete
  Future<void> delete(List<dynamic> threadIds, Function clearFunc) async {
    try {
      await repo.delete(threadIds);

      final threadJson = await repo.initThreads();

      clearFunc();

      emit(LoadedState(threadJson: ThreadModel.fromJson(threadJson)));
    } on DioException catch (err) {
      emit(ErrorState(
          message: err.toString(), statusCode: err.response?.statusCode));
    }
  }

  void clearCubit() {
    emit(EmptyState());
  }
}
