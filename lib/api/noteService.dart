import 'package:dio/dio.dart';

import 'package:acebot_front/api/http.dart';

class NoteService {
  uploadRecords(FormData formData) {
    return dio.post('/v1/note',
        data: formData,
        options: Options(headers: {"Content-Type": "multipart/form-data"}));
  }

  getStt(dynamic id) {
    return dio.get('/v1/note?id=$id');
  }
}
