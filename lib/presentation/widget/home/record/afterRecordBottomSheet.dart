/// 녹음 후 추가 정보
library;

import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ffmpeg_kit_flutter_audio/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_audio/return_code.dart';
import 'package:path_provider/path_provider.dart' as path;

import 'package:acebot_front/presentation/widget/common/baseOutlineButton.dart';
import 'package:acebot_front/presentation/widget/home/record/sttResult.dart';

import 'package:acebot_front/bloc/user/selfCubit.dart';
import 'package:acebot_front/bloc/user/selfState.dart';

import 'package:acebot_front/api/noteService.dart';

class AfterRecordBottomSheet extends StatefulWidget {
  String recordedUrl;
  Function setUploadedFiles;
  Function setIsRecordFile;

  AfterRecordBottomSheet(
      {super.key,
      required this.recordedUrl,
      required this.setUploadedFiles,
      required this.setIsRecordFile});

  @override
  _AfterRecordBottomSheetState createState() => _AfterRecordBottomSheetState();
}

class _AfterRecordBottomSheetState extends State<AfterRecordBottomSheet> {
  int speakers = 1;
  String type = '';
  bool isUploading = false;

  @override
  void initState() {
    super.initState();
  }

  /// format Converter
  static Future<String?> convert(String sourceFullPath) async {
    final tmpPath = await path.getTemporaryDirectory();
    final tmpFullPathName =
        '${tmpPath.path}/${DateTime.now().millisecondsSinceEpoch}.wav';
    final session = await FFmpegKit.execute(
        '-hide_banner -y -i $sourceFullPath -vn -acodec pcm_s16le -ar 16000 -ac 1 $tmpFullPathName');
    final returnCode = await session.getReturnCode();
    if (ReturnCode.isSuccess(returnCode)) {
      return tmpFullPathName;
    }
    return null;
  }

  /// how many speakers button widget
  Widget _speakers(String title, int activeCondition) {
    return GestureDetector(
        onTap: () {
          setState(() {
            speakers = activeCondition;
          });
        },
        child: Column(children: [
          Container(
              height: 2,
              decoration: BoxDecoration(
                  color: speakers == activeCondition
                      ? const Color(0xff000000)
                      : const Color(0xffdadada))),
          const SizedBox(height: 9),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: speakers == activeCondition
                  ? FontWeight.w700
                  : FontWeight.w500,
              color: speakers == activeCondition
                  ? const Color(0xff000000)
                  : const Color(0xffdadada),
            ),
          )
        ]));
  }

  /// checkbox widget
  Widget _checkbox(String title, String activeCondition) {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      GestureDetector(
          onTap: () {
            setState(() {
              type = activeCondition;
            });
          },
          child: Row(children: [
            SizedBox(
                width: 16,
                height: 16,
                child: Image.asset('assets/icons/icon_check.png',
                    color: type == activeCondition
                        ? const Color(0xff000000)
                        : const Color(0xffb3b3b3))),
            const SizedBox(width: 8),
            Text(title,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff000000)))
          ]))
    ]);
  }

  Widget _beforeUploading() {
    return Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('참여자는 몇명인가요?',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff000000))),
          const SizedBox(height: 36),
          Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(flex: 1, child: _speakers('1명', 1)),
                Flexible(
                  flex: 1,
                  child: _speakers('2명', 2),
                ),
                Flexible(
                  flex: 1,
                  child: _speakers('3명', 3),
                ),
                Flexible(
                  flex: 1,
                  child: _speakers('4명', 4),
                ),
                Flexible(
                  flex: 1,
                  child: _speakers('5명 이상', 5),
                ),
              ]),
          const SizedBox(height: 40),
          const Text('음성의 종류를 선택해 주세요.',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff000000))),
          const SizedBox(height: 30),
          // _checkbox("회의", 'meeting'),
          // const SizedBox(height: 32),
          // _checkbox("인터뷰", 'interview'),
          // const SizedBox(height: 32),
          // _checkbox("메모", 'memo'),
          // const SizedBox(height: 32),
          _checkbox("통화", 'telephone'),
          const SizedBox(height: 40),
          Expanded(
            child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
              BaseOutlineButton(
                  onPressedFunc: () async {
                    if (speakers > 0 && type.isNotEmpty) {
                      setState(() {
                        isUploading = true;
                      });

                      final selfCubit = BlocProvider.of<SelfCubit>(context);
                      final theState = selfCubit.state;

                      try {
                        final converted = await convert(widget.recordedUrl);

                        if (converted != null) {
                          String fileName = converted.split('/').last;

                          FormData formData = FormData.fromMap({
                            'organization': (theState as LoadedState)
                                .userJson
                                .email
                                .split('@')[1],
                            'domain': type,
                            'numSpeakers': speakers,
                            'file': await MultipartFile.fromFile(converted,
                                filename: fileName)
                          });

                          final firstRes =
                              await NoteService().uploadRecords(formData);

                          final secondRes =
                              await NoteService().getStt(firstRes.data['id']);

                          widget
                              .setUploadedFiles(['${firstRes.data['id']}.txt']);
                          widget.setIsRecordFile(true);

                          Navigator.pop(context);

                          // TODO : 실제 secondRes 들어올 시 outputs 제대로 들어가는지 디버그
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return SttResult(
                                  outputs: secondRes.data['outputs'],
                                );
                              });
                        }
                      } catch (err) {
                        print(err);
                        setState(() {
                          isUploading = false;
                        });
                      }
                    }
                  },
                  text: '확인',
                  fontSize: 16.0,
                  textColor: const Color(0xffffffff),
                  backgroundColor: (speakers > 0 && type.isNotEmpty)
                      ? const Color(0xff000000)
                      : const Color(0xffb3b3b3),
                  borderColor: (speakers > 0 && type.isNotEmpty)
                      ? const Color(0xff000000)
                      : const Color(0xffb3b3b3))
            ]),
          )
        ]);
  }

  Widget _uploading() {
    Widget description(String desc) {
      return Text(desc,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xff666666),
            height: 1.8,
          ));
    }

    return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(children: [
            Text('AI가 음성 파일로부터\n질문에 대답하고, 요약을 생성하며,\n필요한 회의록을 작성해줍니다.',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff000000)))
          ]),
          Lottie.asset('assets/lottie/hexagon.json'),
          Row(children: [
            Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    color: Color(0xffe6e6e6)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("아래와 같은 질문이 가능해요!",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff000000))),
                      const SizedBox(height: 10),
                      description("이 회의에서 결정된 주요 사항은 무엇입니까?"),
                      description("회의에서 논의된 핵심 포인트를 간략하게 요약해 주세요."),
                      description("오늘 논의된 내용에 대한 회의록을 작성해주세요."),
                    ]))
          ])
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 24),
        decoration: const BoxDecoration(color: Color(0xffffffff)),
        child: !isUploading ? _beforeUploading() : _uploading());
  }
}
