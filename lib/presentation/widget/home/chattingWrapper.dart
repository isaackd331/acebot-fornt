/// 홈 화면 채팅 영역

/// TODO
/// 네이티브 권한 체크
/// 업로드
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:acebot_front/presentation/widget/common/noScrollbar.dart';
import 'package:acebot_front/presentation/widget/common/baseToast.dart';
import 'package:acebot_front/presentation/widget/home/record/recordUploadBottomSheet.dart';

import 'package:acebot_front/bloc/answer/answerCubit.dart';

class ChattingWrapper extends StatefulWidget {
  final Function setChatContent;
  final Function updateQuestArray;
  final Function updateIdsArray;
  final TextEditingController chatController;
  final FocusNode chatFocusNode;
  final int questArrayLength;

  const ChattingWrapper(
      {super.key,
      required this.setChatContent,
      required this.updateQuestArray,
      required this.updateIdsArray,
      required this.chatController,
      required this.chatFocusNode,
      required this.questArrayLength});

  @override
  _ChattingWrapperState createState() => _ChattingWrapperState();
}

class _ChattingWrapperState extends State<ChattingWrapper> {
  bool isUploadButtonClicked = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    /**
     * 홈페이지에서 벗어날 시 Overlay remove
     */
    if (overlayEntry.mounted) {
      overlayEntry.remove();
    }

    super.dispose();
  }

  /// Overlay Builder
  late final OverlayEntry overlayEntry =
      OverlayEntry(builder: (BuildContext context) {
    return Positioned(
        bottom: 70,
        right: 20,
        child: Container(
            width: 142,
            height: 120,
            decoration: BoxDecoration(
                color: const Color(0xff323232),
                borderRadius: BorderRadius.circular(4)),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () async {
                        overlayEntry.remove();
                        setState(() {
                          isUploadButtonClicked = false;
                        });

                        final audioStatus =
                            await Permission.microphone.request();

                        if (audioStatus.isGranted) {
                          final fileStatus =
                              await Permission.manageExternalStorage.request();

                          if (fileStatus.isGranted) {
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return const RecordUploadBottomSheet();
                                });
                          } else {
                            BaseToast(
                                    content:
                                        '해당 기능을 사용하려면\n녹음 및 파일 접근 권한이 필요합니다.',
                                    context: context)
                                .showToast();

                            if (await Permission
                                .manageExternalStorage.isPermanentlyDenied) {
                              await Future.delayed(const Duration(seconds: 3));
                              openAppSettings();
                            }
                          }
                        } else {
                          BaseToast(
                                  content:
                                      '해당 기능을 사용하려면\n녹음 및 파일 접근 권한이 필요합니다.',
                                  context: context)
                              .showToast();

                          if (await Permission.microphone.isPermanentlyDenied) {
                            await Future.delayed(const Duration(seconds: 3));
                            openAppSettings();
                          }
                        }
                      },
                      child: SizedBox(
                          height: 40,
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(width: 14),
                                SizedBox(
                                    width: 14,
                                    height: 14,
                                    child: Image.asset(
                                        'assets/icons/icon_record_upload.png')),
                                const SizedBox(width: 8),
                                const DefaultTextStyle(
                                    style: TextStyle(
                                        color: Color(0xffffffff),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                    child: Text('음성 파일 생성'))
                              ]))),
                  GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () async {
                        overlayEntry.remove();
                        setState(() {
                          isUploadButtonClicked = false;
                        });

                        final cameraStatus = await Permission.camera.request();

                        if (cameraStatus.isGranted) {
                        } else {}
                      },
                      child: SizedBox(
                          height: 40,
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(width: 14),
                                SizedBox(
                                    width: 14,
                                    height: 14,
                                    child: Image.asset(
                                        'assets/icons/icon_image_upload.png')),
                                const SizedBox(width: 8),
                                const DefaultTextStyle(
                                    style: TextStyle(
                                        color: Color(0xffffffff),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                    child: Text('이미지 업로드'))
                              ]))),
                  GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () async {
                        overlayEntry.remove();
                        setState(() {
                          isUploadButtonClicked = false;
                        });

                        print('doc upload');
                      },
                      child: SizedBox(
                          height: 40,
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(width: 14),
                                SizedBox(
                                    width: 14,
                                    height: 14,
                                    child: Image.asset(
                                        'assets/icons/icon_docs_upload.png')),
                                const SizedBox(width: 8),
                                const DefaultTextStyle(
                                    style: TextStyle(
                                        color: Color(0xffffffff),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                    child: Text('문서 업로드'))
                              ])))
                ])));
  });

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
      Expanded(
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                  color: const Color(0xfff4f4f4),
                  borderRadius: BorderRadius.circular(3)),
              child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                IconButton(
                    onPressed: () {},
                    icon: SizedBox(
                      width: 24,
                      height: 24,
                      child:
                          Image.asset('assets/icons/icon_classified_docs.png'),
                    ),
                    color: const Color(0xff999999),
                    padding: const EdgeInsets.only(bottom: 3)),
                Expanded(
                    child: NoScrollbarWrapper(
                        child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  focusNode: widget.chatFocusNode,
                  controller: widget.chatController,
                  onChanged: (value) {
                    setState(() {
                      widget.setChatContent(value);
                    });
                  },
                  minLines: 1,
                  maxLines: widget.chatFocusNode.hasFocus ? 6 : 1,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff000000)),
                  decoration: InputDecoration(
                    fillColor: const Color(0xfff4f4f4),
                    hintText: !widget.chatFocusNode.hasFocus
                        ? 'ACEBOT에게 요청해 보세요'
                        : '',
                    hintStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff999999)),
                    border: InputBorder.none,
                  ),
                ))),
                IconButton(
                    onPressed: () async {
                      if (widget.chatController.text.isNotEmpty) {
                        final answerCubit =
                            BlocProvider.of<AnswerCubit>(context);

                        // 추후 개발 때는 length가 늘어나며 여러 질문/답변이 한 화면에 나타날 수 있어야 함.
                        // 1차 개발에서는 한 화면에 한 질문/답변만
                        // answerCubit.ready();

                        widget.updateQuestArray(widget.chatController.text);

                        // 추후 개발 때는 length가 늘어나며 여러 질문/답변이 한 화면에 나타날 수 있어야 함.
                        // 1차 개발에서는 한 화면에 한 질문/답변만
                        // final idsData = answerCubit.quest(
                        //     chatController.text, widget.questArrayLength);
                        final idsData = await answerCubit.quest(
                            widget.chatController.text, widget.chatController);

                        widget.updateIdsArray(idsData);
                      }
                    },
                    icon: Icon(Icons.arrow_upward,
                        color: widget.chatController.text.isEmpty
                            ? const Color(0xff999999)
                            : const Color(0xff000000)),
                    padding: const EdgeInsets.only(bottom: 3)),
              ]))),
      const SizedBox(width: 8),
      Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              color: const Color(0xff000000),
              borderRadius: BorderRadius.circular(3)),
          child: IconButton(
            onPressed: () {
              OverlayState overlayState = Overlay.of(context);

              if (!overlayEntry.mounted) {
                overlayState.insert(overlayEntry);
              } else {
                overlayEntry.remove();
              }

              setState(() {
                isUploadButtonClicked = !isUploadButtonClicked;
              });
            },
            icon: !isUploadButtonClicked
                ? const Icon(Icons.add,
                    color: Color(0xffffffff), key: ValueKey('beforeClicked'))
                : const Icon(Icons.clear,
                    color: Color(0xffffffff), key: ValueKey('afterClicked')),
          )),
    ]);
  }
}
