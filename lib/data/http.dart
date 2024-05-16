/**
 * API Interceptor
 */

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final dio = Dio();
void configureDio() async {
  await dotenv.load(fileName: 'env/.env');

  dio.options.baseUrl = dotenv.env['API_BASE_URL'] ?? "";
  dio.options.contentType = 'application/json';

  dio.interceptors.add(DioInterceptor());
}

class DioInterceptor extends Interceptor {
  // request interceptor
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('[REQ] [${options.method}] ${options.uri}');

    super.onRequest(options, handler);
  }

  // response interceptor
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO

    super.onResponse(response, handler);
  }

  // error interceptor
  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    // TODO

    super.onError(err, handler);
  }
}
