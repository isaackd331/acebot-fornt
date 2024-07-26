import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dio/dio.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart' as path;

import 'package:acebot_front/presentation/widget/common/baseBody.dart';
import 'package:acebot_front/presentation/widget/common/baseOutlineButton.dart';
import 'package:acebot_front/presentation/widget/common/baseAppBar.dart';

import 'package:acebot_front/bloc/answer/answerCubit.dart';

import 'package:acebot_front/api/fileService.dart';

class ImageBottomSheet extends StatefulWidget {
  TextEditingController chatController;
  Function updateQuestArray;
  Function updateIdsArray;

  ImageBottomSheet(
      {super.key,
      required this.chatController,
      required this.updateQuestArray,
      required this.updateIdsArray});

  @override
  _ImageBottomSheetState createState() => _ImageBottomSheetState();
}

class _ImageBottomSheetState extends State<ImageBottomSheet> {
  bool isUploading = false;
  File? uploadedFile;
  TextEditingController promptController = TextEditingController();
  String promptContent = "";
  File? previewImageFile;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _bodyWidget() {
    return Container(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        decoration: const BoxDecoration(color: Color(0xffffffff)),
        child: Column(mainAxisSize: MainAxisSize.max, children: [
          // Header
          BaseAppBar(
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/icons/icon_image-upload-beta.png',
                        scale: 4),
                    const SizedBox(width: 6),
                    const Text("이미지 업로드",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff000000)))
                  ]),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.clear, color: Color(0xff000000)),
                    iconSize: 24)
              ],
              leading: Container()),

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
          GestureDetector(
              onTap: () async {
                if (!isUploading) {
                  FilePickerResult? result = await FilePicker.platform
                      .pickFiles(
                          allowMultiple: false,
                          type: FileType.custom,
                          allowedExtensions: ['jpeg', 'png', 'gif', 'tiff']);

                  if (result != null) {
                    PlatformFile file = result.files.first;

                    if (file.size > 1024 * 1024 * 10) {
                      // TODO : 얼럿창 띄우기
                    } else {
                      MultipartFile uploadingFile =
                          await MultipartFile.fromFile(file.path!,
                              filename: file.name);

                      FormData formData =
                          FormData.fromMap({"files": uploadingFile});

                      setState(() {
                        uploadedFile = File(file.path!);
                      });

                      setState(() {
                        isUploading = true;
                      });

                      try {
                        // TODO : secondRes로 오는 바이너리 코드를 원래 프리뷰에 보여주는 단계가 있어야 함.
                        Response firstRes =
                            await FileService().uploadFiles(formData);

                        setState(() {
                          isUploading = false;
                        });

                        Response secondRes = await FileService()
                            .getImagePreview(firstRes.data['content'][0]['id']);

                        final imageBytes = secondRes.data as List<int>;

                        final directory = await path.getTemporaryDirectory();
                        final filePath =
                            '${directory.path}/${firstRes.data['content'][0]['file_name']}';

                        File file = File(filePath);
                        file = await file.writeAsBytes(imageBytes);

                        setState(() {
                          previewImageFile = file;
                        });
                      } catch (err) {
                        setState(() {
                          isUploading = false;
                        });
                      }
                    }
                  }
                }
              },
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(color: Color(0xfff4f4f4)),
                  child: isUploading == false
                      ? previewImageFile == null
                          ? Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                  Image.asset(
                                      'assets/icons/icon_image-upload-add.png',
                                      scale: 4),
                                  const SizedBox(height: 10),
                                  const Text("여기를 탭하여 이미지를 추가하세요.",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xffb3b3b3),
                                          height: 1.5))
                                ])
                          : Image.file(previewImageFile!, fit: BoxFit.fill)
                      : Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                              Lottie.asset('assets/lottie/hexagon.json')
                            ]))),

          const SizedBox(height: 30),

          // prompt
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                const Text("프롬프트 입력",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff1b1b1b),
                        height: 1.5)),
                const Text("해당 이미지로 마케팅 문구 생성과 캡션을 추가할 수 있어요.",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff929292),
                        height: 1.5)),
                const SizedBox(height: 10),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      promptContent = value;
                    });
                  },
                  controller: promptController,
                  minLines: 3,
                  maxLines: 3,
                  style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff000000)),
                  decoration: const InputDecoration(
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

          const SizedBox(height: 27),

          // button
          Row(children: [
            BaseOutlineButton(
                onPressedFunc: () async {
                  if (uploadedFile != null &&
                      promptContent.isNotEmpty &&
                      !isUploading) {
                    AnswerCubit answerCubit =
                        BlocProvider.of<AnswerCubit>(context);

                    widget.updateQuestArray(promptContent);

                    Navigator.pop(context);

                    final idsData = await answerCubit.quest(promptContent,
                        widget.chatController, [uploadedFile!], false);

                    widget.updateIdsArray(idsData);
                  }
                },
                text: '요청하기',
                fontSize: 16.0,
                textColor: const Color(0xffffffff),
                backgroundColor: (uploadedFile != null &&
                        promptController.text.isNotEmpty &&
                        !isUploading)
                    ? const Color(0xff000000)
                    : const Color(0xffb3b3b3),
                borderColor: (uploadedFile != null &&
                        promptController.text.isNotEmpty &&
                        !isUploading)
                    ? const Color(0xff000000)
                    : const Color(0xffb3b3b3))
          ])
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
                backgroundColor: const Color(0xffffffff), leading: Container()),
            body: BaseBody(child: _bodyWidget())));
  }
}
