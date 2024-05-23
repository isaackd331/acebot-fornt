/**
 * 홈 페이지
 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:acebot_front/presentation/widget/home/promptCarouselWrapper.dart';
import 'package:acebot_front/presentation/widget/common/baseAppBar.dart';
import 'package:acebot_front/presentation/widget/common/baseBody.dart';
import 'package:acebot_front/presentation/widget/common/noScrollbar.dart';

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

  Widget _bodyWidget() {
    return BlocListener<SelfCubit, SelfState>(
        listener: (context, state) {},
        child: BlocBuilder<SelfCubit, SelfState>(builder: (_, state) {
          if (state is LoadedState) {
            return Center(
                child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 70, 20, 40),
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
                            (!chatFocusNode.hasFocus &&
                                    chatController.text.isEmpty)
                                ? PromptCarouselWrapper(itemsData: [
                                    PromptItem(
                                        type: 'type1', content: 'content1'),
                                    PromptItem(
                                        type: 'type1', content: 'content1'),
                                    PromptItem(
                                        type: 'type1', content: 'content1'),
                                    PromptItem(
                                        type: 'type1', content: 'content1'),
                                    PromptItem(
                                        type: 'type1', content: 'content1')
                                  ])
                                : Container(),
                            const SizedBox(height: 36),
                            /**
                             * Chatting Wrapper
                             */
                            Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 5),
                                decoration: BoxDecoration(
                                    color: const Color(0xfff4f4f4),
                                    borderRadius: BorderRadius.circular(3)),
                                child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      IconButton(
                                          onPressed: () {},
                                          icon: Container(
                                            width: 24,
                                            height: 24,
                                            child: Image.asset(
                                                'assets/icons/icons_classified_docs.png'),
                                          ),
                                          color: Color(0xff999999),
                                          padding:
                                              const EdgeInsets.only(bottom: 3)),
                                      Expanded(
                                        child: NoScrollbarWrapper(
                                            child: TextFormField(
                                          keyboardType: TextInputType.multiline,
                                          focusNode: chatFocusNode,
                                          controller: chatController,
                                          onChanged: (value) {
                                            setState(() {
                                              chatContent = value;
                                            });
                                          },
                                          minLines: 1,
                                          maxLines: 6,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff000000)),
                                          decoration: InputDecoration(
                                            hintText: chatPlaceholder,
                                            hintStyle: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff999999)),
                                            border: InputBorder.none,
                                          ),
                                        )),
                                      ),
                                      IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.arrow_upward,
                                              color: Color(0xff999999)),
                                          padding:
                                              const EdgeInsets.only(bottom: 3))
                                    ]))
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
              icon: Image.asset('assets/icons/icons_newchat_disabled.png'),
              iconSize: 18,
              padding: const EdgeInsets.all(0)),
          IconButton(
              onPressed: () {},
              icon: Image.asset('assets/icons/icons_streamline.png'),
              iconSize: 16,
              padding: const EdgeInsets.all(0)),
        ],
        leading: IconButton(
            onPressed: () {},
            icon: Image.asset('assets/icons/icons_history.png'),
            iconSize: 8,
            padding: const EdgeInsets.all(0)),
      ),
      body: BaseBody(child: _bodyWidget()),
    ));
  }
}
