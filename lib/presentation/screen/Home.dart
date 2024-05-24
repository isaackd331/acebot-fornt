/**
 * 홈 페이지
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:acebot_front/presentation/widget/home/promptCarouselWrapper.dart';
import 'package:acebot_front/presentation/widget/home/chattingWrapper.dart';
import 'package:acebot_front/presentation/widget/common/baseAppBar.dart';
import 'package:acebot_front/presentation/widget/common/baseBody.dart';

import 'package:acebot_front/bloc/user/selfState.dart';
import 'package:acebot_front/bloc/user/selfCubit.dart';

class Home extends StatefulWidget {
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

  /**
   * 채팅 포커싱 여부 업데이트
   */
  void setIsChatFocusing(bool value) {
    setState(() {
      isChatFocusing = value;
    });
  }

  /**
   * chatContent 업데이트
   */
  void setChatContent(String value) {
    setState(() {
      chatContent = value;
    });
  }

  /**
   * 채팅 비어있음 여부 업데이트
   */
  void setIsChatEmpty(bool value) {
    setState(() {
      isChatEmpty = value;
    });
  }

  /**
   * 프롬프트 데이터 업데이트
   */
  void setPromptData(int idx, int value) {
    setState(() {
      promptData[idx] = value;
    });
  }

  Widget _bodyWidget() {
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
                            (!isChatFocusing && chatContent.isEmpty)
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
                                setIsChatEmpty: setIsChatEmpty)
                          ])),
                    ])));
          } else {
            return Container();
          }
        }));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: BaseAppBar(
        title: '',
        actions: [
          IconButton(
              onPressed: () {},
              icon: Image.asset('assets/icons/icon_newchat_disabled.png'),
              iconSize: 18,
              padding: const EdgeInsets.all(0)),
          IconButton(
              onPressed: () {},
              icon: Image.asset('assets/icons/icon_streamline.png'),
              iconSize: 16,
              padding: const EdgeInsets.all(0)),
        ],
        leading: IconButton(
            onPressed: () {
              /**
               * TEST
               * go to mypage
               */
              context.go('/mypage');
            },
            icon: Image.asset('assets/icons/icon_history.png'),
            iconSize: 8,
            padding: const EdgeInsets.all(0)),
      ),
      body: BaseBody(child: _bodyWidget()),
    ));
  }
}
