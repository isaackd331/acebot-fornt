import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';

import 'package:acebot_front/api/answerService.dart';

class AnswerRepository {
  Future<StreamSubscription<String>?> createAnswer(
      int questionId, Function state) async {
    Response<dynamic> res;

    res = await AnswerService().getAnswer(questionId);

    StreamTransformer<Uint8List, List<int>> unit8Transformer =
        StreamTransformer.fromHandlers(handleData: (data, sink) {
      sink.add(List<int>.from(data));
    });

    res.data?.stream
        .transform(unit8Transformer)
        .transform(const Utf8Decoder())
        .transform(const LineSplitter())
        .listen((evt) {
      String refinedData = evt.replaceFirst('data: ', '');

      if (refinedData.isNotEmpty) {
        Map<String, dynamic> mapped = json.decode(refinedData);

        state(mapped);
      }
    });
    return null;
  }
}
