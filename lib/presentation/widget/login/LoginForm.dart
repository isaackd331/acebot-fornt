/**
 * 로그인 페이지 로그인 폼
 */

import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 90.0),
        child: const Column(children: <Widget>[
          Column(children: <Widget>[
            // 아이디 Input 영역
            Row(children: <Widget>[
              Expanded(
                  child: Text('아이디',
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff444444))))
            ]),
            SizedBox(height: 12),
            TextField(
              style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff000000)),
              decoration: InputDecoration(
                  hintText: "아이디",
                  hintStyle: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff939393)),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 8.0, vertical: 11.5),
                  filled: true,
                  fillColor: Color(0xfff4f4f4),
                  border: InputBorder.none),
            )
          ]),
          // 비밀번호 Input 영역
        ]));
  }
}
