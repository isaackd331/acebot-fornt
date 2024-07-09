import 'package:acebot_front/api/http.dart';

class FileService {
  uploadFiles(dynamic params) {
    return dio.post('/v1/files', data: params);
  }
}
