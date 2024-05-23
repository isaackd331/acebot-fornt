/**
 * 홈 화면 채팅 영역
 */

import 'package:flutter/material.dart';

import 'package:acebot_front/presentation/widget/common/noScrollbar.dart';
import 'package:flutter/widgets.dart';

class ChattingWrapper extends StatefulWidget {
  final Function setIsChatFocusing;
  final Function setChatContent;
  final Function setIsChatEmpty;

  const ChattingWrapper(
      {super.key,
      required this.setIsChatFocusing,
      required this.setChatContent,
      required this.setIsChatEmpty});

  @override
  _ChattingWrapperState createState() => _ChattingWrapperState();
}

class _ChattingWrapperState extends State<ChattingWrapper> {
  FocusNode chatFocusNode = FocusNode();
  String chatPlaceholder = "ACEBOT에게 요청해 보세요";
  TextEditingController chatController = TextEditingController();
  bool isUploadButtonClicked = false;

  void initState() {
    super.initState();

    chatFocusNode.addListener(() {
      setState(() {
        chatPlaceholder = chatFocusNode.hasFocus ? "" : "ACEBOT에게 요청해 보세요";
      });

      widget.setIsChatFocusing(chatFocusNode.hasFocus);
    });

    chatController.addListener(() {
      setState(() {
        widget.setIsChatEmpty(chatController.text.isEmpty);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(clipBehavior: Clip.none, children: [
      isUploadButtonClicked
          ? Positioned(
              bottom: 54,
              right: 0,
              child: Container(
                  width: 142,
                  height: 120,
                  decoration: BoxDecoration(
                      color: const Color(0xff323232),
                      borderRadius: BorderRadius.circular(4)),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
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
                                  const Text('음성 파일 생성',
                                      style: TextStyle(
                                          color: Color(0xffffffff),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400))
                                ])),
                        SizedBox(
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
                                  const Text('이미지 업로드',
                                      style: TextStyle(
                                          color: Color(0xffffffff),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400))
                                ])),
                        SizedBox(
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
                                  const Text('문서 업로드',
                                      style: TextStyle(
                                          color: Color(0xffffffff),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400))
                                ]))
                      ])))
          : Container(),
      Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Expanded(
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                    color: const Color(0xfff4f4f4),
                    borderRadius: BorderRadius.circular(3)),
                child:
                    Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  IconButton(
                      onPressed: () {},
                      icon: SizedBox(
                        width: 24,
                        height: 24,
                        child: Image.asset(
                            'assets/icons/icon_classified_docs.png'),
                      ),
                      color: const Color(0xff999999),
                      padding: const EdgeInsets.only(bottom: 3)),
                  Expanded(
                      child: NoScrollbarWrapper(
                          child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    focusNode: chatFocusNode,
                    controller: chatController,
                    onChanged: (value) {
                      setState(() {
                        widget.setChatContent(value);
                      });
                    },
                    minLines: 1,
                    maxLines: 6,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff000000)),
                    decoration: InputDecoration(
                      fillColor: const Color(0xfff4f4f4),
                      hintText: chatPlaceholder,
                      hintStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff999999)),
                      border: InputBorder.none,
                    ),
                  ))),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.arrow_upward,
                          color: chatController.text.isEmpty
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
      ])
    ]);
  }
}
