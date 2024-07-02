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
}
