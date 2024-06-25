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
  bool privateCollectAgreed = false;
  bool sensitiveAgreed = false;
  bool privateDealAgreed = false;
  bool isOverFourteen = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _checkRow(String title, bool state, String termComponent) {
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
                setState(() {
                  state = !state;
                });
              },
              child: Row(children: [
                SizedBox(
                    width: 24,
                    height: 24,
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
              icon: const SizedBox(
                  width: 16, height: 16, child: Icon(Icons.arrow_forward_ios)))
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
                    padding: const EdgeInsets.symmetric(horizontal: 20),
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
                        ])))));
  }
}
