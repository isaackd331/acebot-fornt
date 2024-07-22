import 'package:flutter_bloc/flutter_bloc.dart';

enum RequestEvent { start, complete, error }

class RequestState {
  final bool isLoading;
  final bool hasError;

  RequestState({required this.isLoading, this.hasError = false});

  RequestState copyWith({bool? isLoading, bool? hasError}) {
    return RequestState(
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
    );
  }
}

class RequestBloc extends Bloc<RequestEvent, RequestState> {
  RequestBloc() : super(RequestState(isLoading: false)) {
    on<RequestEvent>((event, emit) {
      switch (event) {
        case RequestEvent.start:
          emit(state.copyWith(isLoading: true, hasError: false));
          break;
        case RequestEvent.complete:
          emit(state.copyWith(isLoading: false, hasError: false));
          break;
        case RequestEvent.error:
          emit(state.copyWith(isLoading: false, hasError: true));
          break;
      }
    });
  }
}
