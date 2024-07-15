import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart' as path;

import 'package:acebot_front/presentation/widget/home/record/recordingBottomSheet.dart';
import 'package:acebot_front/presentation/widget/home/record/afterRecordBottomSheet.dart';

class RecordUploadBottomSheet extends StatelessWidget {
  Function setUploadedFiles;

  RecordUploadBottomSheet({super.key, required this.setUploadedFiles});

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
        onClosing: () {},
        builder: (BuildContext context) {
          return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              height: 280,
              decoration: const BoxDecoration(color: Color(0xffffffff)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('업로드 방식을 선택하세요.',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff000000))),
                    const SizedBox(height: 20),
                    const Text('녹음한 내용으로 요약하기, 회의록 작성하기\n같은 다양한 작업을 요청해보세요.',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff000000))),
                    const SizedBox(height: 20),
                    Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                showModalBottomSheet(
                                    context: context,
                                    /**
                         * to allow bottomsheet height from 50% to full.
                         */
                                    isScrollControlled: true,
                                    builder: (BuildContext context) {
                                      return RecordingBottomSheet(
                                          setUploadedFiles: setUploadedFiles);
                                    });
                              },
                              child: Container(
                                width: 160,
                                height: 120,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xffe7e7e7)),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                          width: 36,
                                          height: 36,
                                          child: Image.asset(
                                              'assets/icons/icon_record_upload.png',
                                              color: const Color(0xff000000))),
                                      const SizedBox(height: 20),
                                      const Text('녹음하기',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff000000),
                                          ))
                                    ]),
                              )),
                          GestureDetector(
                              onTap: () async {
                                FilePickerResult? result =
                                    await FilePicker.platform.pickFiles(
                                        allowMultiple: false,
                                        type: FileType.custom,
                                        allowedExtensions: ['wav']);

                                if (result != null) {
                                  Navigator.pop(context);

                                  showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      builder: (BuildContext context) {
                                        return FractionallySizedBox(
                                            heightFactor: 0.7,
                                            child: AfterRecordBottomSheet(
                                                recordedUrl: result.paths[0]!,
                                                setUploadedFiles:
                                                    setUploadedFiles));
                                      });
                                }
                              },
                              child: Container(
                                width: 160,
                                height: 120,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xffe7e7e7)),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                          width: 36,
                                          height: 36,
                                          child: Image.asset(
                                              'assets/icons/icon_recorded_file_upload.png',
                                              color: const Color(0xff000000))),
                                      const SizedBox(height: 14),
                                      const Text('음성 파일\n업로드하기',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff000000),
                                          ))
                                    ]),
                              ))
                        ])
                  ]));
        });
  }
}
