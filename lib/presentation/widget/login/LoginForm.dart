/**
 * 로그인 페이지 로그인 폼
 */

import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  final Function setUserId;
  final Function setUserPassword;

  const LoginForm(
      {super.key, required this.setUserId, required this.setUserPassword});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool passwordInvisible = true;
  bool isIdEmpty = true;
  bool isPasswordEmpty = true;
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    idController.addListener(() {
      setState(() {
        isIdEmpty = idController.text.isEmpty;
      });
    });

    passwordController.addListener(() {
      setState(() {
        isPasswordEmpty = passwordController.text.isEmpty;
      });
    });

    passwordInvisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 90.0),
        child: Column(children: <Widget>[
          // 아이디 Input 영역
          Column(children: <Widget>[
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
              controller: idController,
              onChanged: (value) => {widget.setUserId(value)},
              style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff000000)),
              decoration: InputDecoration(
                  suffixIcon: !isIdEmpty
                      ? IconButton(
                          icon:
                              Icon(Icons.clear, color: const Color(0xff000000)),
                          onPressed: () {
                            setState(() {
                              idController.clear();
                              widget.setUserId("");
                            });
                          },
                        )
                      : null,
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
          SizedBox(height: 28.0),
          // 비밀번호 Input 영역
          Column(children: <Widget>[
            Row(children: <Widget>[
              Expanded(
                  child: Text('비밀번호',
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff444444))))
            ]),
            SizedBox(height: 12),
            TextField(
              controller: passwordController,
              onChanged: (value) => {widget.setUserId(value)},
              obscureText: passwordInvisible,
              enableSuggestions: false,
              autocorrect: false,
              style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff000000)),
              decoration: InputDecoration(
                  suffixIcon: !isPasswordEmpty
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.clear,
                                    color: const Color(0xff000000)),
                                onPressed: () {
                                  setState(() {
                                    passwordController.clear();
                                    widget.setUserPassword("");
                                  });
                                },
                              ),
                              IconButton(
                                icon: Icon(
                                    passwordInvisible
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: const Color(0xff000000)),
                                onPressed: () {
                                  setState(() {
                                    passwordInvisible = !passwordInvisible;
                                  });
                                },
                              )
                            ])
                      : IconButton(
                          icon: Icon(
                              passwordInvisible
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: const Color(0xff000000)),
                          onPressed: () {
                            setState(() {
                              passwordInvisible = !passwordInvisible;
                            });
                          },
                        ),
                  hintText: "비밀번호",
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
        ]));
  }
}
