import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:acebot_front/bloc/auth/authState.dart';
import 'package:acebot_front/repository/authRepository.dart';
import 'package:acebot_front/models/authModel.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repo;

  AuthCubit({required this.repo}) : super(EmptyDataState());

  Future<void> pushLoginButtonEvent(String userId, String userPassword) async {
    try {
      emit(LoadingState());

      final authJson = await repo.authenticate(userId, userPassword);

      emit(LoadedState(authJson: AuthModel.fromJson(authJson)));
    } catch (err) {
      emit(ErrorState(message: err.toString()));
    }
  }
}
