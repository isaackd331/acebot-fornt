/**
 * 로그인 페이지
 */

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:acebot_front/presentation/widget/common/BaseAppBar.dart';
import 'package:acebot_front/presentation/widget/login/LoginForm.dart';
import 'package:acebot_front/presentation/widget/login/LoginErrorMessage.dart';
import 'package:acebot_front/presentation/widget/common/BaseOutlineButton.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String userId = "";
  String userPassword = "";
  late String loginErrorStatus;
  bool ableToLogin = false;

  @override
  void initState() {
    super.initState();
    userId = "";
    userPassword = "";
    loginErrorStatus = "";
    ableToLogin = false;
  }

  // 아이디 change Func
  void setUserId(String value) {
    setState(() {
      userId = value;
      ableToLogin = (userId.isNotEmpty && userPassword.isNotEmpty);
    });
  }

  // 비밀번호 change Func
  void setUserPassword(String value) {
    setState(() {
      userPassword = value;
      ableToLogin = (userId.isNotEmpty && userPassword.isNotEmpty);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const BaseAppBar(title: '', actions: [], leading: SizedBox()),
        body: SafeArea(
          child: Center(
              child: Container(
                  padding: const EdgeInsets.fromLTRB(20.0, 116.0, 20.0, 133.0),
                  child: Column(children: <Widget>[
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
                                      text: '아직 회원이 아니신가요? ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14.0),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: '회원가입',
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () => {},
                                            style: TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14.0,
                                            ))
                                      ])))
                        ])),

                    // LoginForm
                    LoginForm(
                      setUserId: setUserId,
                      setUserPassword: setUserPassword,
                    ),

                    SizedBox(height: 9.0),

                    // ErrorMessage
                    LoginErrorMessage(
                      loginErrorStatus: loginErrorStatus,
                    ),

                    SizedBox(height: 40.0),

                    Row(children: <Widget>[
                      BaseOutlineButton(
                          onPressedFunc: () {},
                          text: '로그인',
                          fontSize: 16.0,
                          textColor: const Color(0xffffffff),
                          backgroundColor: ableToLogin
                              ? const Color(0xff000000)
                              : const Color(0xffb3b3b3),
                          borderColor: ableToLogin
                              ? const Color(0xff000000)
                              : const Color(0xffb3b3b3))
                    ]),

                    SizedBox(height: 16.0),

                    RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: '비밀번호를 잊어버리셨나요?',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => {},
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0,
                            )))
                  ]))),
        ));
  }
}
