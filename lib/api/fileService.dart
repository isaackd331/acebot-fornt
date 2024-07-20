import 'package:dio/dio.dart';

import 'package:acebot_front/api/http.dart';

class FileService {
  uploadFiles(FormData formData) {
    return dio.post('/v1/files',
        data: formData,
        options: Options(headers: {"Content-Type": "multipart/form-data"}));
  }

  getFiles() {
    return dio.get('/v1/files');
  }
}
