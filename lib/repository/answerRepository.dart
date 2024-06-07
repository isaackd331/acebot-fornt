import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:acebot_front/api/answerService.dart';
import 'package:dio/dio.dart';

class QuestionRepository {
  Future<StreamSubscription<String>?> createAnswer(int questionId, dynamic state) async {
     Response<dynamic> res;

     res = await AnswerService().getAnswer(questionId);

     StreamTransformer<Uint8List, List<int>> unit8Transformer = StreamTransformer.fromHandlers(
      handleData: (data, sink) {
        sink.add(List<int>.from(data));
      }
     );

     res.data?.stream.transform(unit8Transformer)
                      .transform(const Utf8Decoder())
                      .transform(const LineSplitter())
                      .listen((evt) {
                        String refinedData = evt.replaceFirst('data: ', '');

                        if(refinedData.isNotEmpty) {
                          final jsonRes = json.decode(refinedData);

                          state(jsonRes);
                        }
                      });
     return null;
  }
}
