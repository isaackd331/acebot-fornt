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
  FocusNode idFocusNode = FocusNode();
  String idPlaceholder = "아이디";
  bool isIdEmpty = true;
  TextEditingController idController = TextEditingController();
  FocusNode passwordFocusNode = FocusNode();
  String passwordPlaceholder = "비밀번호";
  bool isPasswordEmpty = true;
  bool passwordInvisible = true;
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    idFocusNode.addListener(() {
      idFocusNode.hasFocus
          ? setState(() {
              idPlaceholder = "";
            })
          : setState(() {
              idPlaceholder = "아이디";
            });
    });

    idController.addListener(() {
      setState(() {
        isIdEmpty = idController.text.isEmpty;
      });
    });

    passwordFocusNode.addListener(() {
      passwordFocusNode.hasFocus
          ? setState(() {
              passwordPlaceholder = "";
            })
          : setState(() {
              passwordPlaceholder = "비밀번호";
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
              focusNode: idFocusNode,
              controller: idController,
              onChanged: (value) => {widget.setUserId(value)},
              style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff000000)),
              decoration: InputDecoration(
                  suffixIcon: !isIdEmpty
                      ? IconButton(
                          icon: Icon(Icons.clear,
                              color: const Color(0xff000000), size: 24.0),
                          onPressed: () {
                            setState(() {
                              idController.clear();
                              widget.setUserId("");
                            });
                          },
                        )
                      : null,
                  hintText: idPlaceholder,
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
              focusNode: passwordFocusNode,
              controller: passwordController,
              onChanged: (value) => {widget.setUserPassword(value)},
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
                                    color: const Color(0xff000000), size: 24.0),
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
                                    color: const Color(0xff000000),
                                    size: 24.0),
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
                              color: const Color(0xff000000),
                              size: 24.0),
                          onPressed: () {
                            setState(() {
                              passwordInvisible = !passwordInvisible;
                            });
                          },
                        ),
                  hintText: passwordPlaceholder,
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
