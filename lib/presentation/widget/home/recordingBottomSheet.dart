/**
 * TODO
 * 녹음 후 파일 처리 필요
 */

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';

class RecordingBottomSheet extends StatefulWidget {
  const RecordingBottomSheet({
    super.key
  });

  @override
  _RecordingBottomSheetState createState() => _RecordingBottomSheetState();
}

class _RecordingBottomSheetState extends State<RecordingBottomSheet> {
  bool isRecording = false;
  int elapsedSeconds = 0;
  Timer? _timer;
  FlutterSoundRecorder? _myRecorder = FlutterSoundRecorder();
  final String _recordFilePath = 'test';
  bool isFirstRecord = true;

  
  @override
  void initState() {
    super.initState();

    _myRecorder!.openRecorder();
  }

  @override
  void dispose() {
    pauseTimer();
    setState(() {
        isRecording = false;
      });
    _myRecorder!.closeRecorder();
    _myRecorder = null;

    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1),
      (timer) {
        setState(() {
          elapsedSeconds++;
        });
      } 
    );
  }

  Future<void> startRecord() async {
    await _myRecorder!.startRecorder(
      toFile: _recordFilePath,
      // codec: _codec,
    ).then((value) {
      startTimer();

      setState(() {
        isRecording = true;
        isFirstRecord = false;
      });
    });
  }

  Future<void> resumeRecord() async {
    await _myRecorder!.resumeRecorder().then((value) {
      startTimer();

      setState(() {
        isRecording = true;
      });
    });
  }

  void pauseTimer() {
    _timer!.cancel();
  }

  Future<void> pauseRecord() async {
    await _myRecorder!.pauseRecorder().then(
      (value) {
        pauseTimer();

        setState(() {
          isRecording = false;
        });
      }
    );
  }

  /**
   * calculate elapsedSeconds to MM:SS
   */
  String get elapsedTime {
    int minutes = elapsedSeconds ~/ 60;
    int seconds = elapsedSeconds % 60;

    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.height;

    return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          height: screenWidth * 0.9,
          decoration: const BoxDecoration(
            color: Color(0xffffffff)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      '취소',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff000000)
                      )
                    )
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      '저장',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff000000)
                      )
                    )
                  ),
                ]
              ),
              const Text(
                "말씀해주세요.\n귀 기울여 듣고 있어요.",
                textAlign: TextAlign.center, 
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff000000)
                )
              ),
              /**
               * wave lottie
               */
              Column(
                children: [
                  Text(
                    isRecording ? '음성 인식 중' : '일시 정지 중', style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff888888)
                    )
                  ),
                  const SizedBox(height: 10),
                  Text(
                    elapsedTime, style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff000000)
                    )
                  )
                ]
              ),
              GestureDetector(
                onTap: () {
                  if(isRecording) {
                    pauseRecord();
                  } else {
                    isFirstRecord ? startRecord() : resumeRecord();
                  }
                },
                child: Container(
                  width: 66,
                  height: 66,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xff888888)
                    ),
                  ),
                  child: Center(
                    child: Icon(isRecording ? Icons.pause : Icons.play_arrow, size: 50)
                  )
                )
              )
            ]
          )
        );
  }
} 