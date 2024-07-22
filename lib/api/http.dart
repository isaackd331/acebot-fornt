/// API Interceptor
library;

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:acebot_front/bloc/auth/authState.dart';
import 'package:acebot_front/bloc/auth/authCubit.dart';
import 'package:acebot_front/bloc/request/requestBloc.dart';

final dio = Dio();
void configureDio(AuthCubit authCubit, RequestBloc requestBloc) async {
  await dotenv.load(fileName: 'assets/env/.env');

  dio.options.baseUrl = dotenv.env['API_BASE_URL'] ?? "";
  dio.options.contentType = 'application/json; charset=UTF-8';

  dio.interceptors.add(DioInterceptor(authCubit, requestBloc));
}

class DioInterceptor extends Interceptor {
  final AuthCubit authCubit;
  final RequestBloc requestBloc;

  DioInterceptor(this.authCubit, this.requestBloc);

  // request interceptor
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    /**
     * AuthCubit의 State가 LoadedState일 때,
     * LoadedState의 authJson의 accessToken으로
     * BearerToken을 만듦
     */
    final state = authCubit.state;
    if (state is LoadedState) {
      options.headers['Authorization'] = 'Bearer ${state.authJson.accessToken}';
    }

    if (options.extra['skipSpinner'] != true) {
      requestBloc.add(RequestEvent.start);
    }

    return super.onRequest(options, handler);
  }

  // response interceptor
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.requestOptions.extra['skipSpinner'] != true) {
      requestBloc.add(RequestEvent.complete);
    }

    return super.onResponse(response, handler);
  }

  // error interceptor
  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.requestOptions.extra['skipSpinner'] != true) {
      requestBloc.add(RequestEvent.error);
    }

    return super.onError(err, handler);
  }
}
