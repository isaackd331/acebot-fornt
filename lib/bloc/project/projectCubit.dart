import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import 'package:acebot_front/bloc/project/projectState.dart';
import 'package:acebot_front/models/projectModel.dart';
import 'package:acebot_front/repository/projectRepository.dart';

class ProjectCubit extends Cubit<ProjectState> {
  final ProjectRepository repo;

  ProjectCubit({required this.repo}) : super(EmptyState());

  // init
  Future<void> init() async {
    try {
      emit(LoadingState());

      final projectJson = await repo.initProjects();

      emit(LoadedState(projectJson: ProjectModel.fromJson(projectJson)));
    } on DioException catch (err) {
      emit(ErrorState(
          message: err.toString(), statusCode: err.response?.statusCode));
    }
  }

  // paging
  Future<void> paging(int pageKey, String keyword) async {
    try {
      final projectJson = await repo.getProjects(pageKey, keyword);

      emit(LoadedState(projectJson: ProjectModel.fromJson(projectJson)));
    } on DioException catch (err) {
      emit(ErrorState(
          message: err.toString(), statusCode: err.response?.statusCode));
    }
  }

  // createAndReread
  Future<void> create(String title, Function clearFunc) async {
    try {
      await repo.postProject(title);

      final projectJson = await repo.initProjects();

      clearFunc();

      emit(LoadedState(projectJson: ProjectModel.fromJson(projectJson)));
    } on DioException catch (err) {
      emit(ErrorState(
          message: err.toString(), statusCode: err.response?.statusCode));
    }
  }

  // delete
  Future<void> delete(List<dynamic> projectIds, Function clearFunc) async {
    try {
      await repo.delete(projectIds);

      final projectJson = await repo.initProjects();

      clearFunc();

      emit(LoadedState(projectJson: ProjectModel.fromJson(projectJson)));
    } on DioException catch (err) {
      emit(ErrorState(
          message: err.toString(), statusCode: err.response?.statusCode));
    }
  }

  // reload
  Future<void> reload(Function clearFunc) async {
    try {
      final projectJson = await repo.initProjects();

      clearFunc();

      emit(LoadedState(projectJson: ProjectModel.fromJson(projectJson)));
    } on DioException catch (err) {
      emit(ErrorState(
          message: err.toString(), statusCode: err.response?.statusCode));
    }
  }

  void clearCubit() {
    emit(EmptyState());
  }
}
