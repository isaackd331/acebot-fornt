import 'package:flutter/material.dart';

class SecondProgress extends StatefulWidget {
  final Function setProgress;
  final Function setAbleToProgress;
  final Function setUserPassword;
  final String userPassword;
  final Function setUserCheckPassword;
  final String userCheckPassword;

  const SecondProgress({
    super.key,
    required this.setProgress,
    required this.setAbleToProgress,
    required this.setUserPassword,
    required this.userPassword,
    required this.setUserCheckPassword,
    required this.userCheckPassword,
  });

  @override
  _SecondProgressState createState() => _SecondProgressState();
}

class _SecondProgressState extends State<SecondProgress> {
  FocusNode passwordFocusNode = FocusNode();
  String passwordPlaceholder = "새 비밀번호";
  FocusNode checkPasswordFocusNode = FocusNode();
  String checkPasswordPlaceholder = "새 비밀번호 확인";
  bool isPasswordInvalid = false;
  String passwordInvalidType = "";
  bool passwordInvisible = true;
  bool checkPasswordInvisible = true;
  bool isPasswordEmpty = true;
  TextEditingController passwordController = TextEditingController();
  bool isCheckPasswordEmpty = true;
  TextEditingController checkPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    passwordFocusNode.addListener(() {
      passwordFocusNode.hasFocus
          ? setState(() {
              passwordPlaceholder = "";
            })
          : setState(() {
              passwordPlaceholder = "새 비밀번호";
            });
    });

    checkPasswordFocusNode.addListener(() {
      checkPasswordFocusNode.hasFocus
          ? setState(() {
              checkPasswordPlaceholder = "";
            })
          : setState(() {
              checkPasswordPlaceholder = "새 비밀번호";
            });
    });

    passwordController.addListener(() {
      setState(() {
        isPasswordEmpty = passwordController.text.isEmpty;

        if (isPasswordEmpty) {
          passwordInvalidType = "";
        } else {
          String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
          RegExp regExp = new RegExp(emailPattern);

          if (!regExp.hasMatch(passwordController.text)) {
            passwordInvalidType = "invalidForm";
          } else {
            //
          }
        }
      });
    });

    isPasswordInvalid = false;
    passwordInvalidType = "";
    passwordInvisible = true;
    checkPasswordInvisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 30.0),
        child: Column(children: [
          Row(children: [
            Expanded(
                child: Text("비밀번호를 입력해 주세요.",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xff000000))))
          ]),

          const SizedBox(height: 16.0),

          Row(children: [
            Expanded(
                child: Text("비밀번호는 영문/숫자/특수문자를\n모두 포함하여 8-30자로 설정해 주세요.",
                    style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff737373))))
          ]),

          const SizedBox(height: 30.0),

          // 비밀번호
          Column(children: [
            Row(children: [
              Expanded(
                  child: Text('비밀번호',
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff444444))))
            ]),
            const SizedBox(height: 12),
            TextField(
              focusNode: passwordFocusNode,
              controller: passwordController,
              onChanged: (value) => {widget.setUserPassword(value)},
              obscureText: passwordInvisible,
              enableSuggestions: false,
              autocorrect: false,
              style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff000000)),
              decoration: InputDecoration(
                  suffixIcon: !isPasswordEmpty
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      passwordController.clear();
                                      widget.setUserPassword("");
                                    });
                                  },
                                  icon: const Icon(Icons.clear,
                                      color: Color(0xff000000)),
                                  iconSize: 24.0,
                                  padding: const EdgeInsets.all(0)),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      passwordInvisible = !passwordInvisible;
                                    });
                                  },
                                  icon: Icon(
                                      passwordInvisible
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: const Color(0xff000000)),
                                  iconSize: 24.0,
                                  padding: const EdgeInsets.all(0))
                            ])
                      : IconButton(
                          onPressed: () {
                            setState(() {
                              passwordInvisible = !passwordInvisible;
                            });
                          },
                          icon: Icon(
                            passwordInvisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: const Color(0xff000000),
                          ),
                          iconSize: 24.0,
                          padding: const EdgeInsets.all(0)),
                  hintText: passwordPlaceholder,
                  hintStyle: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff939393)),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 11.5),
                  filled: true,
                  fillColor: const Color(0xfff4f4f4),
                  border: InputBorder.none),
            ),
          ]),

          SizedBox(height: 52.0),

          // 비밀번호 확인
          Column(children: [
            Row(children: [
              Expanded(
                  child: Text('비밀번호 확인',
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff444444))))
            ]),
            SizedBox(height: 12),
            TextField(
              focusNode: checkPasswordFocusNode,
              controller: checkPasswordController,
              onChanged: (value) => {widget.setUserCheckPassword(value)},
              obscureText: checkPasswordInvisible,
              enableSuggestions: false,
              autocorrect: false,
              style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff000000)),
              decoration: InputDecoration(
                  suffixIcon: !isCheckPasswordEmpty
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      checkPasswordController.clear();
                                      widget.setUserCheckPassword("");
                                    });
                                  },
                                  icon: Icon(Icons.clear,
                                      color: const Color(0xff000000)),
                                  iconSize: 24.0,
                                  padding: const EdgeInsets.all(0)),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      checkPasswordInvisible =
                                          !checkPasswordInvisible;
                                    });
                                  },
                                  icon: Icon(
                                      checkPasswordInvisible
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: const Color(0xff000000)),
                                  iconSize: 24.0,
                                  padding: const EdgeInsets.all(0))
                            ])
                      : IconButton(
                          onPressed: () {
                            setState(() {
                              checkPasswordInvisible = !checkPasswordInvisible;
                            });
                          },
                          icon: Icon(
                              checkPasswordInvisible
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: const Color(0xff000000)),
                          iconSize: 24.0,
                          padding: const EdgeInsets.all(0)),
                  hintText: checkPasswordPlaceholder,
                  hintStyle: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff939393)),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 8.0, vertical: 11.5),
                  filled: true,
                  fillColor: Color(0xfff4f4f4),
                  border: InputBorder.none),
            ),
          ]),
        ]));
  }
}
