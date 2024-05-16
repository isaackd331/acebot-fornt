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
  late String errorMessage;

  @override
  Widget build(BuildContext context) {
    return widget.loginErrorStatus.length == 0
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
