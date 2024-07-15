/// 홈 페이지
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import 'package:acebot_front/presentation/widget/home/promptCarousel.dart';
import 'package:acebot_front/presentation/widget/home/chattingWrapper.dart';
import 'package:acebot_front/presentation/widget/home/templateWrapper.dart';
import 'package:acebot_front/presentation/widget/common/baseAppBar.dart';
import 'package:acebot_front/presentation/widget/common/baseBody.dart';
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
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
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
                                              setPromptToChat: setPromptToChat,
                                              setPromptData: setPromptData);
                                        });
                                      }))
                              : Container(),
                          const SizedBox(height: 24),
                          ChattingWrapper(
                            setChatContent: setChatContent,
                            updateQuestArray: updateQuestArray,
                            updateIdsArray: updateIdsArray,
                            chatController: chatController,
                            chatFocusNode: chatFocusNode,
                            questArrayLength: questArray.length,
                          )
                        ])),
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
                setPromptToChat: setPromptToChat)
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
                });
                BlocProvider.of<AnswerCubit>(context).clearCubit();
              }
            },
            icon: Image.asset('assets/icons/icon_newchat.png',
                scale: 4,
                color: questArray.isNotEmpty
                    ? const Color(0xff000000)
                    : const Color(0xff5d5d5d)),
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
          ? BaseBody(child: _beforeChatting())
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
