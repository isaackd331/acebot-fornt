import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'package:acebot_front/api/userService.dart';

class FirstProgress extends StatefulWidget {
  final Function setProgress;
  final Function setAbleToProgress;
  final Function setUserId;
  final String userId;

  const FirstProgress({
    super.key,
    required this.setProgress,
    required this.setAbleToProgress,
    required this.setUserId,
    required this.userId,
  });

  @override
  _FirstProgressState createState() => _FirstProgressState();
}

class _FirstProgressState extends State<FirstProgress> {
  FocusNode idFocusNode = FocusNode();
  String idPlaceholder = "아이디";
  bool? isIdInvalid;
  String statusType = "";
  TextEditingController idController = TextEditingController();

  @override
  void initState() {
    super.initState();

    idController.text = widget.userId;

    idFocusNode.addListener(() {
      if (idFocusNode.hasFocus) {
        setState(() {
          idPlaceholder = "";
          statusType = "";
          isIdInvalid = null;
        });
      } else {
        setState(() {
          idPlaceholder = "아이디";
        });

        String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
        RegExp regExp = RegExp(emailPattern);

        if (!regExp.hasMatch(idController.text)) {
          setState(() {
            statusType = "notEmail";
            isIdInvalid = true;
          });
        } else {
          setState(() {
            statusType = "";
            isIdInvalid = false;
          });
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

  Widget stateRenderer() {
    switch (statusType) {
      case 'notEmail':
        return _errorState('유효한 이메일 주소가 아닙니다.');
      case 'duplicated':
        return _errorState('중복된 이메일 주소입니다.');
      case 'success':
        return _successState('사용할 수 있는 이메일 주소입니다.');
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 30.0),
        child: Column(children: [
          const Row(children: [
            Expanded(
                child: Text("이메일을\n입력해 주세요.",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff000000))))
          ]),
          const SizedBox(height: 56.0),
          Column(children: [
            const Row(children: [
              Expanded(
                  child: Text('아이디',
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff444444))))
            ]),
            const SizedBox(height: 12),
            Row(children: [
              Expanded(
                  flex: 1,
                  child: TextField(
                    focusNode: idFocusNode,
                    controller: idController,
                    onChanged: (value) => {widget.setUserId(value)},
                    style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff000000)),
                    decoration: InputDecoration(
                        suffixIcon: idController.text.isNotEmpty
                            ? IconButton(
                                onPressed: () {
                                  idController.clear();

                                  setState(() {
                                    widget.setUserId("");
                                    statusType = "";
                                    isIdInvalid = false;
                                  });
                                },
                                icon: Image.asset('assets/icons/icon_clear.png',
                                    scale: 4),
                                iconSize: 24.0,
                                padding: const EdgeInsets.all(0))
                            : null,
                        hintText: idPlaceholder,
                        hintStyle: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff939393)),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 11.5),
                        filled: true,
                        fillColor: const Color(0xfff4f4f4),
                        border: InputBorder.none),
                  )),
              const SizedBox(width: 6),
              Expanded(
                  flex: 0,
                  child: SizedBox(
                      height: 46,
                      child: OutlinedButton(
                          onPressed: () async {
                            if ((idController.text.isNotEmpty &&
                                isIdInvalid != null &&
                                statusType != "notEmail")) {
                              try {
                                await UserService()
                                    .verify(idController.text, null, 'email');

                                setState(() {
                                  statusType = "success";
                                  isIdInvalid = false;
                                });

                                widget.setAbleToProgress(true);
                              } on DioException catch (err) {
                                int? status = err.response?.statusCode;

                                if (status == 409) {
                                  setState(() {
                                    statusType = "duplicated";
                                    isIdInvalid = true;
                                  });
                                }
                              }
                            }
                          },
                          style: OutlinedButton.styleFrom(
                              backgroundColor: (idController.text.isNotEmpty &&
                                      isIdInvalid != null &&
                                      statusType != "notEmail")
                                  ? const Color(0xff000000)
                                  : const Color(0xffb3b3b3),
                              side: BorderSide(
                                  color: (idController.text.isNotEmpty &&
                                          isIdInvalid != null &&
                                          !isIdInvalid!)
                                      ? const Color(0xff000000)
                                      : const Color(0xffb3b3b3),
                                  width: 1.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12)),
                          child: const Text("중복 확인",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xffffffff))))))
            ]),
            const SizedBox(height: 8),
            stateRenderer()
          ])
        ]));
  }
}
