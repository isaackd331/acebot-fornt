/**
 * API Interceptor
 */

import 'package:acebot_front/bloc/auth/authState.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:acebot_front/bloc/auth/authCubit.dart';

final dio = Dio();
void configureDio(AuthCubit authCubit) async {
  await dotenv.load(fileName: 'assets/env/.env');

  dio.options.baseUrl = dotenv.env['API_BASE_URL'] ?? "";
  dio.options.contentType = 'application/json; charset=UTF-8';

  dio.interceptors.add(DioInterceptor(authCubit));
}

class DioInterceptor extends Interceptor {
  final AuthCubit authCubit;

  DioInterceptor(this.authCubit);

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

    return super.onRequest(options, handler);
  }

  // response interceptor
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO
    return super.onResponse(response, handler);
  }

  // error interceptor
  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    // TODO
    return super.onError(err, handler);
  }
}
