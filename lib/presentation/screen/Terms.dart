/// 약관 페이지
library;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:acebot_front/presentation/widget/common/baseOutlineButton.dart';
import 'package:acebot_front/presentation/widget/common/baseAppBar.dart';
import 'package:acebot_front/presentation/widget/common/baseBody.dart';

class Terms extends StatefulWidget {
  const Terms({super.key});

  @override
  _TermsState createState() => _TermsState();
}

class _TermsState extends State<Terms> {
  bool serviceAgreed = false;
  bool privateAgreed = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _checkRow(
      String title, bool state, String termComponent, Function tapFunc) {
    Widget termsBottomsheet() {
      switch (termComponent) {
        default:
          return Container();
      }
    }

    return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
              onTap: () {
                tapFunc();
              },
              child: Row(children: [
                SizedBox(
                    width: 16,
                    height: 16,
                    child: Image.asset('assets/icons/icon_check.png',
                        color: state
                            ? const Color(0xff000000)
                            : const Color(0xffb3b3b3))),
                const SizedBox(width: 8),
                Text(title,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff181818)))
              ])),
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return termsBottomsheet();
                    });
              },
              icon: const Icon(Icons.arrow_forward_ios),
              iconSize: 16)
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: BaseAppBar(
                title: '서비스 이용 약관',
                actions: [
                  IconButton(
                      onPressed: () {
                        context.go('/login');
                      },
                      icon: const Icon(Icons.clear),
                      iconSize: 24,
                      padding: const EdgeInsets.all(0),
                      color: const Color(0xff000000))
                ],
                leading: Container()),
            body: BaseBody(
                child: Container(
                    margin: const EdgeInsets.only(top: 40),
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                              text: const TextSpan(
                                  text: 'ACEBOT ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                      color: Color(0xff000000)),
                                  children: <TextSpan>[
                                TextSpan(
                                    text: 'Universe',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 20,
                                        color: Color(0xff000000)))
                              ])),
                          const Text('서비스 이용 약관에 동의해주세요.',
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 20,
                                  color: Color(0xff000000))),
                          const SizedBox(height: 60),
                          Row(mainAxisSize: MainAxisSize.max, children: [
                            GestureDetector(
                                onTap: () {
                                  if (!serviceAgreed || !privateAgreed) {
                                    setState(() {
                                      serviceAgreed = true;
                                      privateAgreed = true;
                                    });
                                  } else {
                                    setState(() {
                                      serviceAgreed = false;
                                      privateAgreed = false;
                                    });
                                  }
                                },
                                child: Row(children: [
                                  SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: Image.asset(
                                          'assets/icons/icon_all-check.png',
                                          color:
                                              (serviceAgreed && privateAgreed)
                                                  ? const Color(0xff000000)
                                                  : const Color(0xffb3b3b3))),
                                  const SizedBox(width: 8),
                                  const Text("약관 전체 동의",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff181818)))
                                ])),
                          ]),
                          const SizedBox(height: 20),
                          Row(children: [
                            Expanded(
                                child: Container(
                              height: 1,
                              decoration:
                                  const BoxDecoration(color: Color(0xff979797)),
                            ))
                          ]),
                          const SizedBox(height: 20),
                          _checkRow("[필수] 서비스 이용 약관", serviceAgreed, 'test',
                              () {
                            setState(() {
                              serviceAgreed = !serviceAgreed;
                            });
                          }),
                          _checkRow(
                              "[필수] 개인 정보 수집 및 이용동의", privateAgreed, 'test',
                              () {
                            setState(() {
                              privateAgreed = !privateAgreed;
                            });
                          }),
                          Expanded(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                /**
                           * 네이티브 키보드 출현 시 컨텐츠와 버튼이 너무 붙는
                           * 문제를 해결하기 위해 삽입
                           */
                                const SizedBox(height: 20),
                                Row(children: [
                                  BaseOutlineButton(
                                    onPressedFunc: () {
                                      if (serviceAgreed && privateAgreed) {
                                        context.go('/join');
                                      }
                                    },
                                    text: "동의하고 회원가입하기",
                                    fontSize: 16,
                                    textColor: const Color(0xffffffff),
                                    backgroundColor:
                                        !(serviceAgreed && privateAgreed)
                                            ? const Color(0xffb3b3b3)
                                            : const Color(0xff000000),
                                    borderColor:
                                        !(serviceAgreed && privateAgreed)
                                            ? const Color(0xffb3b3b3)
                                            : const Color(0xff000000),
                                  )
                                ])
                              ])),
                        ])))));
  }
}
