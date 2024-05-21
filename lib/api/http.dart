/**
 * API Interceptor
 */

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final dio = Dio();
void configureDio() async {
  await dotenv.load(fileName: 'assets/env/.env');

  print("api: ${dotenv.env['API_BASE_URL']}");

  dio.options.baseUrl = dotenv.env['API_BASE_URL'] ?? "";
  dio.options.contentType = 'application/json; charset=UTF-8';

  dio.interceptors.add(DioInterceptor());
}

class DioInterceptor extends Interceptor {
  // request interceptor
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO
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
