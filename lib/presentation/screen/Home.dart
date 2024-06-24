/// 홈 페이지
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:acebot_front/presentation/widget/home/promptCarouselWrapper.dart';
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
  bool isChatFocusing = false;
  String chatPlaceholder = "ACEBOT에게 요청해 보세요";
  String chatContent = "";
  bool isChatEmpty = true;
  TextEditingController chatController = TextEditingController();
  bool isUploadButtonClicked = false;
  List<int> promptData = [0, 0, 0, 0];
  List<String> questArray = [];
  List<dynamic> idsArray = [];
  ScrollController answerListController = ScrollController();

  @override
  void initState() {
    super.initState();

    chatFocusNode.addListener(() {
      chatFocusNode.hasFocus
          ? setState(() {
              chatPlaceholder = "";
              isChatFocusing = true;
            })
          : setState(() {
              chatPlaceholder = "ACEBOT에게 요청해 보세요";
              isChatFocusing = false;
            });
    });

    chatController.addListener(() {
      setState(() {
        isChatEmpty = chatController.text.isEmpty;
      });
    });

    /**
     * 사용할 Cubit 초기화
     */
    context.read<SelfCubit>();
  }

  /// 채팅 포커싱 여부 업데이트
  void setIsChatFocusing(bool value) {
    setState(() {
      isChatFocusing = value;
    });
  }

  /// chatContent 업데이트
  void setChatContent(String value) {
    setState(() {
      chatContent = value;
    });
  }

  /// 채팅 비어있음 여부 업데이트
  void setIsChatEmpty(bool value) {
    setState(() {
      isChatEmpty = value;
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
      questArray = [value];
    });
  }

  // 질문모음 questionId 및 threadId Array
  void updateIdsArray(dynamic value) {
    setState(() {
      // 추후 개발 때는 length가 늘어나며 여러 질문/답변이 한 화면에 나타날 수 있어야 함.
      // 1차 개발에서는 한 화면에 한 질문/답변만
      // idsArray = [...idsArray, value];
      idsArray = [value];
    });
  }

  Widget _beforeChatting() {
    return BlocListener<SelfCubit, SelfState>(
        listener: (context, state) {},
        child: BlocBuilder<SelfCubit, SelfState>(builder: (_, state) {
          if (state is LoadedState) {
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
                                          text: '${state.userJson.name}님',
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
                      SizedBox(
                          width: 40,
                          height: 10,
                          child: Image.asset('assets/images/acebot_logo.png')),
                      Expanded(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                            const SizedBox(height: 20),

                            /**
                             * 포커싱될 시 캐로셀 hide
                             * 채팅 박스에 채팅 있을 시 캐로셀 hide
                             */
                            (!isChatFocusing)
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
                                            return PromptCarouselWrapper(
                                              groupIdx: idx,
                                              itemsData: [
                                                PromptItem(
                                                    type: 'beta',
                                                    content: '텍스트'),
                                                PromptItem(
                                                    type: 'beta',
                                                    content:
                                                        '텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트'),
                                                PromptItem(
                                                    type: 'beta',
                                                    content: '텍스트텍스트텍스트'),
                                                PromptItem(
                                                    type: 'prompt',
                                                    content: '텍스트텍스트텍스트'),
                                                PromptItem(
                                                    type: 'prompt',
                                                    content:
                                                        '텍스트텍스트텍스트텍스트텍스트텍스트')
                                              ],
                                              setPromptData: setPromptData,
                                            );
                                          });
                                        }))
                                : Container(),
                            const SizedBox(height: 24),
                            ChattingWrapper(
                              setIsChatFocusing: setIsChatFocusing,
                              setChatContent: setChatContent,
                              setIsChatEmpty: setIsChatEmpty,
                              updateQuestArray: updateQuestArray,
                              updateIdsArray: updateIdsArray,
                              questArrayLength: questArray.length,
                            )
                          ])),
                    ])));
          } else {
            return Container();
          }
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
                question: questArray[0],
                index: 0,
                idsArray: idsArray,
                setChatContent: setChatContent,
                answerListController: answerListController)
          ]),
      Container(
          padding:
              const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
          child: ChattingWrapper(
            setIsChatFocusing: setIsChatFocusing,
            setChatContent: setChatContent,
            setIsChatEmpty: setIsChatEmpty,
            updateQuestArray: updateQuestArray,
            updateIdsArray: updateIdsArray,
            questArrayLength: questArray.length,
          ))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: BaseAppBar(
        title: '',
        actions: [
          IconButton(
              onPressed: () {
                if (questArray.isNotEmpty) {
                  chatController.clear();
                  setState(() {
                    chatContent = '';
                    questArray = [];
                    idsArray = [];
                  });
                  BlocProvider.of<AnswerCubit>(context).clearCubit();
                }
              },
              icon: Image.asset('assets/icons/icon_newchat.png'),
              iconSize: 18,
              padding: const EdgeInsets.all(0),
              color: questArray.isNotEmpty
                  ? const Color(0xff000000)
                  : const Color(0xff5d5d5d)),
          IconButton(
            onPressed: () {},
            icon: Image.asset('assets/icons/icon_streamline.png'),
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
