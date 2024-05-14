/**
 * 로그인 페이지
 */

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:acebot_front/presentation/widget/common/BaseAppBar.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const BaseAppBar(title: '', actions: [], leading: SizedBox()),
        body: SafeArea(
          child: Center(
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // ACEBOT Title
                        Row(children: <Widget>[
                          Expanded(
                              child: RichText(
                                  textAlign: TextAlign.center,
                                  text: const TextSpan(
                                      text: 'ACEBOT ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 22.0),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: 'Universe',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w300,
                                                fontSize: 22.0))
                                      ])))
                        ]),

                        // Guide Sign up
                        Container(
                            padding: const EdgeInsets.only(top: 40.0),
                            child: Row(children: <Widget>[
                              Expanded(
                                  child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                          text: '아직도 회원이 없으신가요? ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14.0),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: '회원가입',
                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () => {},
                                                style: TextStyle(
                                                  decoration:
                                                      TextDecoration.underline,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14.0,
                                                ))
                                          ])))
                            ]))
                      ]))),
        ));
  }
}
