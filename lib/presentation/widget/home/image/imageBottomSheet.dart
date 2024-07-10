import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import 'package:acebot_front/presentation/widget/common/baseBody.dart';
import 'package:acebot_front/presentation/widget/common/baseOutlineButton.dart';

class ImageBottomSheet extends StatefulWidget {
  const ImageBottomSheet({super.key});

  @override
  _ImageBottomSheetState createState() => _ImageBottomSheetState();
}

class _ImageBottomSheetState extends State<ImageBottomSheet> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseBody(
        child: Container(
            padding: const EdgeInsets.fromLTRB(20, 44, 20, 24),
            decoration: const BoxDecoration(color: Color(0xffffffff)),
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Header
                  SizedBox(
                      height: 50,
                      child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(),
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                      'assets/icons/icon_image-upload-beta.png',
                                      scale: 4),
                                  const SizedBox(width: 6),
                                  const Text("이미지 업로드",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff000000)))
                                ]),
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.clear),
                                iconSize: 24)
                          ])),

                  // Text under Header
                  const Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text("JPEG, PNG, GIF, TIFF 확장자를 가진",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff1b1b1b),
                                height: 1.5)),
                        Text("이미지 1장만 업로드 가능해요.",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff000000),
                                height: 1.5)),
                        Text("이미지 분석에 알맞은 크기의 사진(256~4096픽셀)을 업로드해주세요",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff929292),
                                height: 1.5)),
                        Text("가로/세로 중 한 가지 영역만 너무 길거나 짧은 사진은 피해주세요.",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff929292),
                                height: 1.5))
                      ])),

                  // Image upload box
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width,
                      decoration:
                          const BoxDecoration(color: Color(0xfff4f4f4))),

                  // prompt
                  const Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text("프롬프트 입력",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff1b1b1b),
                                height: 1.5)),
                        Text("해당 이미지로 마케팅 문구 생성과 캡션을 추가할 수 있어요.",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff929292),
                                height: 1.5)),
                        SizedBox(height: 10),
                        TextField(
                          style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff000000)),
                          decoration: InputDecoration(
                              hintText: "원하시는 내용을 입력하세요",
                              hintStyle: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff939393)),
                              contentPadding: EdgeInsets.all(12),
                              filled: true,
                              fillColor: Color(0xfff4f4f4),
                              border: InputBorder.none),
                        ),
                      ])),

                  // button
                  Row(children: [
                    BaseOutlineButton(
                        onPressedFunc: () {},
                        text: '요청하기',
                        fontSize: 16.0,
                        textColor: const Color(0xffffffff),
                        backgroundColor: const Color(0xffb3b3b3),
                        borderColor: const Color(0xffb3b3b3))
                  ])
                ])));
  }
}
