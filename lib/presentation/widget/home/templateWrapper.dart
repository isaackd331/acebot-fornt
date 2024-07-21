// 답변 별 템플릿 Wrapper

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:io';
import 'package:collection/collection.dart';

import 'package:acebot_front/presentation/widget/home/template/chitchatTemplate.dart';
import 'package:acebot_front/presentation/widget/home/template/weatherTemplate.dart';
import 'package:acebot_front/presentation/widget/home/template/placeTemplate.dart';
import 'package:acebot_front/presentation/widget/home/template/noteTemplate.dart';
import 'package:acebot_front/presentation/widget/home/recommendPromptSection.dart';
import 'package:acebot_front/presentation/widget/home/record/sttResult.dart';

import 'package:acebot_front/bloc/answer/answerState.dart';
import 'package:acebot_front/bloc/answer/answerCubit.dart';

import 'package:acebot_front/api/noteService.dart';

class TemplateWrapper extends StatefulWidget {
  final String question;
  // final int index;
  // 추후 개발 때는 length가 늘어나며 여러 질문/답변이 한 화면에 나타날 수 있어야 함.
  // 1차 개발에서는 한 화면에 한 질문/답변만
  // final List<dynamic> idsArray;
  final dynamic idsArray;
  final Function setChatContent;
  final ScrollController answerListController;
  final Function setPromptToChat;
  final List<dynamic> uploadedFiles;

  const TemplateWrapper(
      {super.key,
      required this.question,
      // required this.index,
      required this.idsArray,
      required this.setChatContent,
      required this.answerListController,
      required this.setPromptToChat,
      required this.uploadedFiles});

  @override
  _TemplateWrapperState createState() => _TemplateWrapperState();
}

class _TemplateWrapperState extends State<TemplateWrapper> {
  String? templateName = "";
  String mainParagraph = "";
  List<dynamic> recommendPrompts = [];
  bool isOpenUploadedFiles = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _templateSelector() {
    switch (templateName) {
      case 'chitchat':
        return ChitChatTemplate(
          // 추후 개발 때는 length가 늘어나며 여러 질문/답변이 한 화면에 나타날 수 있어야 함.
          // 1차 개발에서는 한 화면에 한 질문/답변만
          // index: widget.index,
          // questionId: widget.idsArray[widget.index]['questionId'],
          // threadId: widget.idsArray[widget.index]['threadId'],
          questionId: widget.idsArray['questionId'],
          threadId: widget.idsArray['threadId'],
          question: widget.question,
          setChatContent: widget.setChatContent,
          initMp: mainParagraph,
          recommendPrompts: recommendPrompts,
        );

      case 'cur_weather':
        return WeatherTemplate(
          // 추후 개발 때는 length가 늘어나며 여러 질문/답변이 한 화면에 나타날 수 있어야 함.
          // 1차 개발에서는 한 화면에 한 질문/답변만
          // index: widget.index,
          // questionId: widget.idsArray[widget.index]['questionId'],
          // threadId: widget.idsArray[widget.index]['threadId'],
          questionId: widget.idsArray['questionId'],
          threadId: widget.idsArray['threadId'],
          question: widget.question,
          setChatContent: widget.setChatContent, initMp: mainParagraph,
          recommendPrompts: recommendPrompts,
        );

      case 'weekly_weather':
        return WeatherTemplate(
          // 추후 개발 때는 length가 늘어나며 여러 질문/답변이 한 화면에 나타날 수 있어야 함.
          // 1차 개발에서는 한 화면에 한 질문/답변만
          // index: widget.index,
          // questionId: widget.idsArray[widget.index]['questionId'],
          // threadId: widget.idsArray[widget.index]['threadId'],
          questionId: widget.idsArray['questionId'],
          threadId: widget.idsArray['threadId'],
          question: widget.question,
          setChatContent: widget.setChatContent, initMp: mainParagraph,
          recommendPrompts: recommendPrompts,
        );

      case 'place_search':
        return PlaceTemplate(
          // 추후 개발 때는 length가 늘어나며 여러 질문/답변이 한 화면에 나타날 수 있어야 함.
          // 1차 개발에서는 한 화면에 한 질문/답변만
          // index: widget.index,
          // questionId: widget.idsArray[widget.index]['questionId'],
          // threadId: widget.idsArray[widget.index]['threadId'],
          questionId: widget.idsArray['questionId'],
          threadId: widget.idsArray['threadId'],
          question: widget.question,
          setChatContent: widget.setChatContent, initMp: mainParagraph,
          recommendPrompts: recommendPrompts,
        );

      case 'note':
        return NoteTemplate(
          // 추후 개발 때는 length가 늘어나며 여러 질문/답변이 한 화면에 나타날 수 있어야 함.
          // 1차 개발에서는 한 화면에 한 질문/답변만
          // index: widget.index,
          // questionId: widget.idsArray[widget.index]['questionId'],
          // threadId: widget.idsArray[widget.index]['threadId'],
          questionId: widget.idsArray['questionId'],
          threadId: widget.idsArray['threadId'],
          question: widget.question,
          setChatContent: widget.setChatContent,
          initMp: mainParagraph,
          recommendPrompts: recommendPrompts,
        );

      default:
        return Container();
    }
  }

  Widget _uploadedFile(dynamic file) {
    String filename;

    if (file is File) {
      filename = file.path.split('/').last;
    } else {
      filename = file;
    }

    String ellipsizeMiddle(String text, int maxLength) {
      if (text.length <= maxLength) {
        return text;
      }
      int ellipsisLength = 3;
      int keepLength = (maxLength - ellipsisLength) ~/ 2;
      return '${text.substring(0, keepLength)}...${text.substring(text.length - keepLength)}';
    }

    return GestureDetector(
        onTap: () async {
          if (file.runtimeType != File) {
            final String fileId = filename.split('.')[0];

            final res = await NoteService().getStt(fileId);

            // TODO : 실제 secondRes 들어올 시 outputs 제대로 들어가는지 디버그
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return SttResult(
                    outputs: res.data['outputs'],
                  );
                });
          } else {}
        },
        child: Container(
          height: 44,
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
              color: Color(0xfff6f6f6),
              borderRadius: BorderRadius.all(Radius.circular(4))),
          child: Row(mainAxisSize: MainAxisSize.max, children: [
            SizedBox(
                width: 20,
                height: 20,
                child: Image.asset('assets/icons/icon_etc.png',
                    scale: 4, fit: BoxFit.fill)),
            const SizedBox(width: 6),
            SizedBox(
                width: 120,
                child: Text(ellipsizeMiddle(filename, 16),
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff000000)),
                    overflow: TextOverflow.ellipsis)),
          ]),
        ));
  }

  Widget _uploadedFilesWrapper() {
    if (widget.uploadedFiles.isNotEmpty) {
      return Column(children: [
        const SizedBox(height: 14),
        GestureDetector(
            onTap: () {
              setState(() {
                isOpenUploadedFiles = !isOpenUploadedFiles;
              });
            },
            child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    const Text('업로드 파일',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff4f4f4f))),
                    const SizedBox(width: 6),
                    Text('${widget.uploadedFiles.length}',
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff4f4f4f)))
                  ]),
                  Image.asset(
                      !isOpenUploadedFiles
                          ? 'assets/icons/icon_arrow-downward.png'
                          : 'assets/icons/icon_arrow-upward.png',
                      scale: 4,
                      color: const Color(0xff000000))
                ])),
        const SizedBox(height: 12),
        isOpenUploadedFiles
            ? Align(
                alignment: Alignment.centerLeft,
                child: CarouselSlider(
                    items: widget.uploadedFiles.mapIndexed((idx, datum) {
                      return Builder(builder: (BuildContext context) {
                        return _uploadedFile(datum);
                      });
                    }).toList(),
                    options: CarouselOptions(
                        height: 44,
                        viewportFraction: 0.5,
                        pageSnapping: false,
                        enableInfiniteScroll: false,
                        disableCenter: false,
                        padEnds: false)))
            : Container()
      ]);
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    // 추후 개발 때는 length가 늘어나며 여러 질문/답변이 한 화면에 나타날 수 있어야 함.
    // 1차 개발에서는 한 화면에 한 질문/답변만
    // return BlocListener<AnswerCubit, List<AnswerState>>(
    return BlocListener<AnswerCubit, AnswerState>(listener: (context, state) {
      // 추후 개발 때는 length가 늘어나며 여러 질문/답변이 한 화면에 나타날 수 있어야 함.
      // 1차 개발에서는 한 화면에 한 질문/답변만
      // theState와 lastState를 따로 둘 필요가 없으나, 이후 주석 해제 시를 대비하여 따로 변수를 둠.
      // AnswerState theState = state[widget.index];
      // AnswerState lastState = state[state.length - 1];
      AnswerState theState = state;
      AnswerState lastState = state;

      void scrollToBottom(int duration) {
        if (widget.answerListController.hasClients) {
          Future.delayed(
              duration == 0 ? Duration.zero : Duration(milliseconds: duration),
              () {
            widget.answerListController.animateTo(
                widget.answerListController.position.maxScrollExtent,
                duration: const Duration(milliseconds: 100),
                curve: Curves.easeInOut);
          });
        }
      }

      if (theState is LoadingState) {
        setState(() {
          templateName = '';
        });
      } else if (theState is LoadedState) {
        setState(() {
          templateName = theState.answerJson.template_name;
          mainParagraph = theState.answerJson.main_paragraph;
          recommendPrompts = theState.answerJson.recommend_prompt;
        });
        print(mainParagraph);

        if (widget.answerListController.hasClients) {
          scrollToBottom(0);
        }
      }
      // if (widget.answerListController.hasClients) {
      //   if (lastState is EmptyState || lastState is LoadingState) {
      //     scrollToBottom(100);
      //   } else if (lastState is LoadedState) {
      //     scrollToBottom(0);
      //   }
      // }
    },
        // 추후 개발 때는 length가 늘어나며 여러 질문/답변이 한 화면에 나타날 수 있어야 함.
        // 1차 개발에서는 한 화면에 한 질문/답변만
        // child: BlocBuilder<AnswerCubit, List<AnswerState>>(builder: (_, state) {
        child: BlocBuilder<AnswerCubit, AnswerState>(builder: (_, state) {
      // 추후 개발 때는 length가 늘어나며 여러 질문/답변이 한 화면에 나타날 수 있어야 함.
      // 1차 개발에서는 한 화면에 한 질문/답변만
      // AnswerState theState = state[widget.index];
      AnswerState theState = state;

      return Container(
          margin: const EdgeInsets.only(top: 40),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(mainAxisSize: MainAxisSize.max, children: [
            Row(children: [
              Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xff666666)),
                  // TODO : 추후 유저 아이콘으로 변경 필요
                  child: const Text(
                    'T',
                    style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: Color(0xffffffff)),
                    textAlign: TextAlign.center,
                  )),
              const SizedBox(width: 7),
              const Text('You',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff111111)))
            ]),
            const SizedBox(height: 14),
            Row(
              children: [
                Flexible(
                    child: Text(
                  widget.question,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff000000)),
                ))
              ],
            ),
            _uploadedFilesWrapper(),
            const SizedBox(height: 60),
            Row(children: [
              Image.asset('assets/icons/icon_answer-start-symbol.png', scale: 3)
            ]),
            const SizedBox(height: 20),
            Row(children: [
              Image.asset('assets/icons/icon_exaone-logo.png', scale: 3),
              const SizedBox(width: 4),
              const Text("ACEBOT",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff111111)))
            ]),
            theState is LoadingState
                ? Row(children: [
                    Expanded(
                        child: Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: const Text('Loading...',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 51, 21, 21)))))
                  ])
                : Container(),
            theState is ErrorState
                ? Row(children: [
                    Expanded(
                        child: Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: const Text(
                                "시스템에 문제가 발생하였습니다.\n관리자에게 문의바랍니다.",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 51, 21, 21)))))
                  ])
                : Container(),
            (theState is LoadedState &&
                    widget.idsArray['questionId'] != null &&
                    widget.idsArray['threadId'] != null)
                ? Column(children: [
                    _templateSelector(),
                    templateName != 'note'
                        ? RecommendPromptSection(
                            recommendPrompts: recommendPrompts,
                            setPromptToChat: widget.setPromptToChat,
                          )
                        : Container()
                  ])
                : Container()
          ]));
    }));
  }
}
