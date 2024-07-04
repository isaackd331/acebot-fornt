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
  bool? isPasswordInvalid;
  String passwordStatusType = "";
  bool? isCheckPasswordInvalid;
  String checkPasswordStatusType = "";
  bool passwordInvisible = true;
  bool checkPasswordInvisible = true;
  TextEditingController passwordController = TextEditingController();
  TextEditingController checkPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    passwordFocusNode.addListener(() {
      if (passwordFocusNode.hasFocus) {
        setState(() {
          passwordPlaceholder = "";
          passwordStatusType = "";
          isPasswordInvalid = null;
        });
      } else {
        setState(() {
          passwordPlaceholder = "새 비밀번호";
        });

        String passwordPattern =
            r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,30}$';
        RegExp regExp = RegExp(passwordPattern);

        if (!regExp.hasMatch(passwordController.text)) {
          //
        } else {
          //
        }
      }
    });

    checkPasswordFocusNode.addListener(() {
      if (checkPasswordFocusNode.hasFocus) {
        setState(() {
          checkPasswordPlaceholder = "";
          checkPasswordStatusType = "";
          isCheckPasswordInvalid = null;
        });
      } else {
        setState(() {
          checkPasswordPlaceholder = "새 비밀번호 확인";
        });

        if (passwordController.text != checkPasswordController.text) {
          //
        } else {
          //
        }
      }
    });
  }

  Widget _errorState(String str) {
    return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.clear, color: Color(0xffe72929), size: 16),
          const SizedBox(width: 2),
          Text(str,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xffe72929)))
        ]);
  }

  Widget _successState(String str) {
    return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(str,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff17c452)))
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 30.0),
        child: Column(children: [
          const Row(children: [
            Expanded(
                child: Text("비밀번호를 입력해 주세요.",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff000000))))
          ]),

          const SizedBox(height: 16.0),

          const Row(children: [
            Expanded(
                child: Text("비밀번호는 영문/숫자/특수문자를\n모두 포함하여 8-30자로 설정해 주세요.",
                    style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff737373))))
          ]),

          const SizedBox(height: 30.0),

          // 비밀번호
          Column(children: [
            const Row(children: [
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
                  suffixIcon: passwordController.text.isNotEmpty
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
                  hintStyle: const TextStyle(
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

          const SizedBox(height: 52.0),

          // 비밀번호 확인
          Column(children: [
            const Row(children: [
              Expanded(
                  child: Text('비밀번호 확인',
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff444444))))
            ]),
            const SizedBox(height: 12),
            TextField(
              focusNode: checkPasswordFocusNode,
              controller: checkPasswordController,
              onChanged: (value) => {widget.setUserCheckPassword(value)},
              obscureText: checkPasswordInvisible,
              enableSuggestions: false,
              autocorrect: false,
              style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff000000)),
              decoration: InputDecoration(
                  suffixIcon: checkPasswordController.text.isNotEmpty
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
                                  icon: const Icon(Icons.clear,
                                      color: Color(0xff000000)),
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
                  hintStyle: const TextStyle(
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
        ]));
  }
}
