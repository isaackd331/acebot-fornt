// /// TODO
// /// 녹음 후 파일 처리 필요
// library;

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:record/record.dart';
// import 'package:intl/intl.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart' as path;

// import 'package:acebot_front/presentation/widget/home/record/afterRecordBottomSheet.dart';

// class RecordingBottomSheet extends StatefulWidget {
//   const RecordingBottomSheet({
//     super.key
//   });

//   @override
//   _RecordingBottomSheetState createState() => _RecordingBottomSheetState();
// }

// class _RecordingBottomSheetState extends State<RecordingBottomSheet> {
//   bool isRecording = false;
//   int elapsedSeconds = 0;
//   Timer? _timer;
//   bool isFirstRecord = true;
//   String? recordedUrl;

//   /// record package
//   final myRecorder = AudioRecorder();
//   String filePath = "";

//   @override
//   void initState() {
//     super.initState();

//     startRecord();
//   }

//   @override
//   void dispose() {
//     pauseTimer();
//     setState(() {
//         isRecording = false;
//       });

//     myRecorder.dispose();

//     super.dispose();
//   }

//   void startTimer() {
//     _timer = Timer.periodic(const Duration(seconds: 1),
//       (timer) {
//         setState(() {
//           elapsedSeconds++;
//         });
//       }
//     );
//   }

//   Future<void> startRecord() async {
//     final dir = await getApplicationDocumentsDirectory();

//     setState(() {
//       filePath = path.join(dir.path, '${DateFormat('yyyyMMddHHmm').format(DateTime.now())}_recorded.wav');
//       isRecording = true;
//       isFirstRecord = false;
//     });

//     /// record encoding options
//     const int numChannel = 1;
//     const int sampleRate = 16000;
//     const int bitRate = sampleRate * 16;

//     await myRecorder.start(
//       const RecordConfig(
//         encoder: AudioEncoder.wav,
//         numChannels: numChannel,
//         sampleRate: sampleRate,
//         bitRate: bitRate,
//       ),
//       path: filePath
//     );

//     startTimer();
//   }

//   void pauseTimer() {
//     _timer!.cancel();
//   }

//   Future<void> pauseRecord() async {
//     await myRecorder.pause();

//     setState(() {
//       isRecording = false;
//     });
//   }

//   Future<void> resumeRecord() async {
//     await myRecorder.resume();

//     setState(() {
//       isRecording = true;
//     });
//   }

//   Future<void> stopRecord() async {
//     final path = await myRecorder.stop();
//     print(path);

//     // await _myRecorder!.stopRecord().then((value) {
//     //   pauseTimer();

//     //   setState(() {
//     //     isRecording = false;
//     //     recordedUrl = value;
//     //   });

//     //   Navigator.pop(context);

//     //   showModalBottomSheet(
//     //     context: context,
//     //     isScrollControlled: true,
//     //     builder: (BuildContext context) {
//     //       return FractionallySizedBox(
//     //         heightFactor: 0.7,
//     //         child: AfterRecordBottomSheet(recordedUrl: recordedUrl)
//     //       );
//     //     }
//     //   );
//     // });
//   }

//   /// calculate elapsedSeconds to MM:SS
//   String get elapsedTime {
//     int minutes = elapsedSeconds ~/ 60;
//     int seconds = elapsedSeconds % 60;

//     return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.height;

//     return Container(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
//           height: screenWidth * 0.9,
//           decoration: const BoxDecoration(
//             color: Color(0xffffffff)
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 mainAxisSize: MainAxisSize.max,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                     child: const Text(
//                       '취소',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                         color: Color(0xff000000)
//                       )
//                     )
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                         stopRecord();
//                     },
//                     child: const Text(
//                       '저장',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w700,
//                         color: Color(0xff000000)
//                       )
//                     )
//                   ),
//                 ]
//               ),
//               const Text(
//                 "말씀해주세요.\n귀 기울여 듣고 있어요.",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                   color: Color(0xff000000)
//                 )
//               ),
//               /**
//                * wave lottie
//                */
//               Column(
//                 children: [
//                   Text(
//                     isRecording ? '음성 인식 중' : '일시 정지 중', style: const TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                       color: Color(0xff888888)
//                     )
//                   ),
//                   const SizedBox(height: 10),
//                   Text(
//                     elapsedTime, style: const TextStyle(
//                       fontSize: 26,
//                       fontWeight: FontWeight.w600,
//                       color: Color(0xff000000)
//                     )
//                   )
//                 ]
//               ),
//               GestureDetector(
//                 onTap: () {
//                   if(isRecording) {
//                     pauseRecord();
//                   } else {
//                     isFirstRecord ? startRecord() : resumeRecord();
//                   }
//                 },
//                 child: Container(
//                   width: 66,
//                   height: 66,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     border: Border.all(
//                       color: const Color(0xff888888)
//                     ),
//                   ),
//                   child: Center(
//                     child: Icon(isRecording ? Icons.pause : Icons.play_arrow, size: 50)
//                   )
//                 )
//               )
//             ]
//           )
//         );
//   }
// }
