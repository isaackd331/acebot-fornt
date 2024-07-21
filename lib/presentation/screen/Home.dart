/// 홈 페이지
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'dart:io';
import 'package:collection/collection.dart';

import 'package:acebot_front/presentation/widget/home/promptCarousel.dart';
import 'package:acebot_front/presentation/widget/home/chattingWrapper.dart';
import 'package:acebot_front/presentation/widget/home/templateWrapper.dart';
import 'package:acebot_front/presentation/widget/common/baseAppBar.dart';
import 'package:acebot_front/presentation/widget/common/noScrollbar.dart';

import 'package:acebot_front/bloc/user/selfState.dart';
import 'package:acebot_front/bloc/user/selfCubit.dart';
import 'package:acebot_front/bloc/answer/answerCubit.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FocusNode chatFocusNode = FocusNode();
  String chatPlaceholder = "ACEBOT에게 요청해 보세요";
  String chatContent = "";
  TextEditingController chatController = TextEditingController();
  bool isUploadButtonClicked = false;
  List<int> promptData = [0, 0, 0, 0];
  // 추후 개발 때는 length가 늘어나며 여러 질문/답변이 한 화면에 나타날 수 있어야 함.
  // 1차 개발에서는 한 화면에 한 질문/답변만
  // 본래 List Type이 아니므로 명명이 이렇게 되어서는 안되나, 2차 개발에서의 주석 해제 시 혼란을 방지하기 위해 2차 개발 건의 데이터와 명명을 맞춤
  // List<String> questArray = [];
  // List<dynamic> idsArray = [];
  String questArray = '';
  dynamic idsArray = {};
  ScrollController answerListController = ScrollController();
  List<dynamic> uploadedFiles = [];
  ScrollController fileScrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    chatFocusNode.addListener(() {
      chatFocusNode.hasFocus
          ? setState(() {
              chatPlaceholder = "";
            })
          : setState(() {
              chatPlaceholder = "ACEBOT에게 요청해 보세요";
            });
    });
  }

  /// chatContent 업데이트
  void setChatContent(String value) {
    setState(() {
      chatContent = value;
    });
  }

  /// prompt setting
  void setPromptToChat(String value) {
    setState(() {
      chatContent = value;
    });

    chatController.text = value;
  }

  void setUploadedFiles(List<dynamic> value) {
    List<dynamic> copiedList = List.from(uploadedFiles);

    copiedList = [...copiedList, ...value];

    setState(() {
      uploadedFiles = copiedList.toSet().toList();
    });
  }

  void clearUploadedFiles() {
    setState(() {
      uploadedFiles = [];
    });
  }

  /// 프롬프트 데이터 업데이트
  void setPromptData(int idx, int value) {
    setState(() {
      promptData[idx] = value;
    });
  }

  // 질문모음 Array
  void updateQuestArray(String value) {
    setState(() {
      // 추후 개발 때는 length가 늘어나며 여러 질문/답변이 한 화면에 나타날 수 있어야 함.
      // 1차 개발에서는 한 화면에 한 질문/답변만
      // questArray = [...questArray, value]
      questArray = value;
    });
  }

  // 질문모음 questionId 및 threadId Array
  void updateIdsArray(dynamic value) {
    setState(() {
      // 추후 개발 때는 length가 늘어나며 여러 질문/답변이 한 화면에 나타날 수 있어야 함.
      // 1차 개발에서는 한 화면에 한 질문/답변만
      // idsArray = [...idsArray, value];
      idsArray = value;
    });
  }

  // Uploaded Files
  Widget _uploadedFiles(dynamic file) {
    String filename;
    print('======fuckyou');
    print(file.runtimeType);

    if (file is File) {
      print('hi');
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

    return Container(
        width: 210,
        height: 40,
        margin: const EdgeInsets.only(left: 10),
        padding: const EdgeInsets.only(left: 12),
        decoration: BoxDecoration(
            color: const Color(0xffffffff),
            borderRadius: const BorderRadius.all(Radius.circular(3)),
            border: Border.all(color: const Color(0xffb3b3b3))),
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                // TODO : 확장자에 맞는 아이콘 추가 필요
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
                            color: Color(0xff000000))))
              ]),
              IconButton(
                  onPressed: () {
                    List<dynamic> tempList = List.from(uploadedFiles);

                    tempList.remove(file);

                    setState(() {
                      uploadedFiles = tempList.toSet().toList();
                    });
                  },
                  icon: const Icon(Icons.clear),
                  iconSize: 16,
                  color: const Color(0xffb3b3b3))
            ]));
  }

  Widget _fileSwiper() {
    return SingleChildScrollView(
        controller: fileScrollController,
        scrollDirection: Axis.horizontal,
        child: Row(
            children: uploadedFiles.mapIndexed((idx, file) {
          return Builder(builder: (BuildContext context) {
            return _uploadedFiles(file);
          });
        }).toList()));
  }

  Widget _beforeChatting() {
    return BlocListener<SelfCubit, SelfState>(
        listener: (context, state) {},
        child: BlocBuilder<SelfCubit, SelfState>(builder: (_, state) {
          return Center(
              child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 70, 20, 20),
                  child: Column(children: [
                    Row(children: [
                      Expanded(
                          child: RichText(
                              textAlign: TextAlign.center,
                              text: const TextSpan(
                                  text: 'ACEBOT ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14.0,
                                      color: Color(0xff000000)),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Universe',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 14.0,
                                            color: Color(0xff000000)))
                                  ]))),
                    ]),
                    const SizedBox(height: 16),
                    Row(children: [
                      Expanded(
                          child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  text: '안녕하세요, ',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 20.0,
                                      color: Color(0xff000000),
                                      height: 1.5),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: state is LoadedState
                                            ? '${state.userJson.name}님'
                                            : '회원님',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 20.0,
                                            color: Color(0xff000000),
                                            height: 1.5))
                                  ])))
                    ]),
                    const Text('무엇을 도와드릴까요?',
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 20.0,
                            color: Color(0xff000000),
                            height: 1.5)),
                    const SizedBox(height: 20),
                    Lottie.asset('assets/lottie/chat.json'),
                    Expanded(
                        child: Stack(children: [
                      Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(height: 20),

                            /**
                             * 포커싱될 시 캐로셀 hide
                             * 채팅 박스에 채팅 있을 시 캐로셀 hide
                             */
                            (!chatFocusNode.hasFocus)
                                ? SizedBox(
                                    height: 314,
                                    child: ListView.separated(
                                        itemCount: 4,
                                        separatorBuilder:
                                            (BuildContext context, int idx) {
                                          return const SizedBox(height: 18);
                                        },
                                        itemBuilder:
                                            (BuildContext context, int idx) {
                                          return Builder(
                                              builder: (BuildContext context) {
                                            return PromptCarousel(
                                                setPromptToChat:
                                                    setPromptToChat,
                                                setPromptData: setPromptData);
                                          });
                                        }))
                                : Container(),
                            ChattingWrapper(
                              setChatContent: setChatContent,
                              updateQuestArray: updateQuestArray,
                              updateIdsArray: updateIdsArray,
                              chatController: chatController,
                              chatFocusNode: chatFocusNode,
                              questArrayLength: questArray.length,
                              uploadedFiles: uploadedFiles,
                              setUploadedFiles: setUploadedFiles,
                              clearUploadedFiles: clearUploadedFiles,
                            )
                          ]),
                      Positioned(
                          bottom: 60,
                          child: uploadedFiles.isNotEmpty
                              ? _fileSwiper()
                              : Container()),
                      Positioned(
                          bottom: 60,
                          right: 0,
                          child: uploadedFiles.isNotEmpty
                              ? IconButton(
                                  onPressed: () {
                                    fileScrollController.animateTo(100,
                                        duration:
                                            const Duration(milliseconds: 2),
                                        curve: Curves.ease);
                                  },
                                  icon: Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: const Color(0xffffffff),
                                          border: Border.all(
                                              color: const Color(0xffe7e7e7))),
                                      child: const Center(
                                          child: Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: Color(0xff000000),
                                              size: 10))))
                              : Container()),
                      Positioned(
                          bottom: 60,
                          left: 0,
                          child: uploadedFiles.isNotEmpty
                              ? IconButton(
                                  onPressed: () {
                                    fileScrollController.animateTo(
                                        fileScrollController.offset - 100,
                                        duration:
                                            const Duration(milliseconds: 2),
                                        curve: Curves.ease);
                                  },
                                  icon: Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: const Color(0xffffffff),
                                          border: Border.all(
                                              color: const Color(0xffe7e7e7))),
                                      child: const Center(
                                          child: Icon(
                                              Icons.arrow_back_ios_rounded,
                                              color: Color(0xff000000),
                                              size: 10))))
                              : Container())
                    ]))
                  ])));
        }));
  }

  Widget _duringChatting() {
    return Column(children: [
      Column(
          // 추후 개발 때는 length가 늘어나며 여러 질문/답변이 한 화면에 나타날 수 있어야 함.
          // 1차 개발에서는 한 화면에 한 질문/답변만
          // children: questArray
          //     .asMap()
          //     .map((idx, value) => MapEntry(
          //         idx,
          //         TemplateWrapper(
          //             question: value,
          //             index: idx,
          //             idsArray: idsArray,
          //             setChatContent: setChatContent,
          //             answerListController: answerListController)))
          //     .values
          //     .toList()
          children: [
            TemplateWrapper(
              question: questArray,
              idsArray: idsArray,
              setChatContent: setChatContent,
              answerListController: answerListController,
              setPromptToChat: setPromptToChat,
              uploadedFiles: uploadedFiles,
            )
          ]),
      Container(
          padding:
              const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
          child: ChattingWrapper(
            setChatContent: setChatContent,
            updateQuestArray: updateQuestArray,
            updateIdsArray: updateIdsArray,
            chatController: chatController,
            chatFocusNode: chatFocusNode,
            questArrayLength: questArray.length,
            uploadedFiles: uploadedFiles,
            setUploadedFiles: setUploadedFiles,
            clearUploadedFiles: clearUploadedFiles,
          ))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: BaseAppBar(
        title: Container(),
        actions: [
          IconButton(
            onPressed: () {
              if (questArray.isNotEmpty) {
                chatController.clear();
                setState(() {
                  chatContent = '';
                  // 추후 개발 때는 length가 늘어나며 여러 질문/답변이 한 화면에 나타날 수 있어야 함.
                  // 1차 개발에서는 한 화면에 한 질문/답변만
                  // questArray = [];
                  // idsArray = [];
                  questArray = '';
                  idsArray = {};
                  uploadedFiles = [];
                });
                BlocProvider.of<AnswerCubit>(context).clearCubit();
              }
            },
            icon: Image.asset(
              questArray.isNotEmpty
                  ? 'assets/icons/icon_newchat-enabled.png'
                  : 'assets/icons/icon_newchat-disabled.png',
              scale: 4,
            ),
            iconSize: 18,
            padding: const EdgeInsets.all(0),
          ),
          IconButton(
            onPressed: () {},
            icon: Image.asset('assets/icons/icon_streamline.png', scale: 4),
            iconSize: 16,
            padding: const EdgeInsets.all(0),
          ),
        ],
        leading: IconButton(
            onPressed: () {
              context.go('/history');
            },
            icon: Image.asset('assets/icons/icon_history.png'),
            iconSize: 8,
            padding: const EdgeInsets.all(0)),
      ),
      body: questArray.isEmpty
          ? Column(children: [
              Expanded(child: LayoutBuilder(builder: (context, constraint) {
                return NoScrollbarWrapper(
                    child: ConstrainedBox(
                        constraints:
                            BoxConstraints(minHeight: constraint.maxHeight),
                        child: IntrinsicHeight(child: _beforeChatting())));
              }))
            ])
          // scrollController를 쉽게 조작하기 위해 BaseBody의 위젯을 그대로 복붙하였음.
          : Column(children: [
              Expanded(child: LayoutBuilder(builder: (context, constraint) {
                return NoScrollbarWrapper(
                    child: SingleChildScrollView(
                        controller: answerListController,
                        child: ConstrainedBox(
                            constraints:
                                BoxConstraints(minHeight: constraint.maxHeight),
                            child: IntrinsicHeight(child: _duringChatting()))));
              }))
            ]),
    ));
  }
}
