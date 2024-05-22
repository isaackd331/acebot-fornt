/**
 * 로그인 페이지
 */

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:acebot_front/presentation/widget/login/LoginForm.dart';
import 'package:acebot_front/presentation/widget/login/LoginErrorMessage.dart';
import 'package:acebot_front/presentation/widget/common/BaseOutlineButton.dart';

import 'package:acebot_front/bloc/auth/authState.dart';
import 'package:acebot_front/bloc/auth/authCubit.dart';
import 'package:acebot_front/bloc/user/selfCubit.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String userId = "";
  String userPassword = "";
  late String loginErrorStatus = "";
  int loginFailedCount = 0;
  bool ableToLogin = false;

  @override
  void initState() {
    super.initState();
    userId = "";
    userPassword = "";
    loginErrorStatus = "";
    ableToLogin = false;

    /**
     * 사용할 Cubit 초기화
     */
    context.read<AuthCubit>();
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
    return SafeArea(
        child: Scaffold(
            /**
           * AuthState의 상태에 따라 처리
           * LoadedState: /home으로 이동
           * ErrorState: 에러 핸들링
           */
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: BlocListener<AuthCubit, AuthState>(
                    listener: (context, state) {
                  if (state is LoadedState) {
                    BlocProvider.of<SelfCubit>(context).getSelfData(userId);

                    context.go('/home');
                  } else if (state is ErrorState) {
                    if (state.statusCode == 404) {
                      setState(() {
                        loginErrorStatus = 'loginFailed';
                      });
                    } else if (state.statusCode == 403) {
                      setState(() {
                        loginErrorStatus = 'loginExceeded';
                      });
                    }
                  }
                },
                    /**
       * Screen Widget
       */
                    child:
                        BlocBuilder<AuthCubit, AuthState>(builder: (_, state) {
                  return Center(
                      child: Container(
                          padding: const EdgeInsets.fromLTRB(20, 100, 20, 0),
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
                                              fontSize: 22.0,
                                              color: const Color(0xff000000)),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: 'Universe',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 22.0,
                                                    color: const Color(
                                                        0xff000000)))
                                          ]))),
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
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14.0,
                                                  color:
                                                      const Color(0xff000000)),
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: '회원가입',
                                                    recognizer:
                                                        TapGestureRecognizer()
                                                          ..onTap = () =>
                                                              context.push(
                                                                  '/join'),
                                                    style: const TextStyle(
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14.0,
                                                        color: const Color(
                                                            0xff000000)))
                                              ])))
                                ])),

                            // LoginForm
                            LoginForm(
                              setUserId: setUserId,
                              setUserPassword: setUserPassword,
                            ),

                            const SizedBox(height: 9.0),

                            // ErrorMessage
                            LoginErrorMessage(
                              loginErrorStatus: loginErrorStatus,
                            ),

                            const SizedBox(height: 40.0),

                            Row(children: <Widget>[
                              BaseOutlineButton(
                                  onPressedFunc: () {
                                    if (ableToLogin) {
                                      BlocProvider.of<AuthCubit>(context)
                                          .pushLoginButtonEvent(
                                              userId, userPassword);
                                    }
                                  },
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
                            const SizedBox(height: 16.0),
                            RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    text: '비밀번호를 잊어버리셨나요?',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => {},
                                    style: const TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.0,
                                    )))
                          ])));
                })))));
  }
}
