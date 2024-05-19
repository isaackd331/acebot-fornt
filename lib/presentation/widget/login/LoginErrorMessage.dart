/**
 * 로그인 실패 시 에러 메세지 출력
 */

import 'package:flutter/material.dart';

class LoginErrorMessage extends StatefulWidget {
  final String loginErrorStatus;

  const LoginErrorMessage({super.key, required this.loginErrorStatus});

  @override
  _LoginErrorMessageState createState() => _LoginErrorMessageState();
}

class _LoginErrorMessageState extends State<LoginErrorMessage> {
  late String errorMessage = "";

  @override
  void initState() {
    super.initState();

    updateErrorMessage();
  }

  void updateErrorMessage() {
    switch (widget.loginErrorStatus) {
      // 로그엔 에러 상태가 정의되지 않았을 시
      case "":
        errorMessage = "";
      // 로그인이나 비밀번호가 맞지 않았을 경우
      case "loginFailed":
        errorMessage = "아이디 또는 비밀번호를 잘못 입력했습니다.\n입력하신 내용을 다시 확인해 주세요.";
      // 로그인 시도 횟수가 5회를 넘었음에도 실패했을 경우
      case "loginExceeded":
        errorMessage =
            "로그인 시도가 5회 이상 실패하여 접속이 제한되었습니다.\n비밀번호 찾기를 통해 비밀번호를 재설정 해주세요.";
    }
  }

  @override
  void didUpdateWidget(covariant LoginErrorMessage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.loginErrorStatus != oldWidget.loginErrorStatus) {
      updateErrorMessage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.loginErrorStatus.isEmpty
        ? Container(height: 32.0)
        : Container(
            height: 32.0,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.clear, color: const Color(0xffE72929), size: 16.0),
                  SizedBox(width: 3.0),
                  Text(errorMessage,
                      style: TextStyle(
                          color: const Color(0xffe72929),
                          fontWeight: FontWeight.w400,
                          fontSize: 12.0))
                ]));
  }
}
