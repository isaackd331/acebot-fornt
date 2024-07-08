import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'package:acebot_front/api/userService.dart';

class EmailVerification extends StatefulWidget {
  final Function setProgress;
  final Function setAbleToProgress;
  final Function setUserId;
  final String userId;

  const EmailVerification({
    super.key,
    required this.setProgress,
    required this.setAbleToProgress,
    required this.setUserId,
    required this.userId,
  });

  @override
  _EmailVerificationState createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  int _seconds = 300;
  TextEditingController idController = TextEditingController();
  String statusType = "";
  TextEditingController codeController = TextEditingController();
  FocusNode codeFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    idController.text = widget.userId;

    startTimer();

    // 이메일 보냄
    UserService().verify(widget.userId, null, 'send-activated');
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
      case 'wrong':
        return _errorState('인증번호가 일치하지 않습니다.');
      case 'success':
        return _successState('인증 번호가 일치합니다.');
      default:
        return Container();
    }
  }

  void startTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (_seconds > 0) {
        setState(() {
          _seconds--;
        });
        startTimer();
      }
    });
  }

  String get timerString {
    int minutes = _seconds ~/ 60;
    int seconds = _seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 30.0),
        child: Column(children: [
          const Row(children: [
            Expanded(
                child: Text("메일로 발송된\n인증 번호를 입력해 주세요.",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff000000))))
          ]),
          const SizedBox(height: 56.0),
          Column(children: [
            // 아이디 영역
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
                    enabled: false,
                    controller: idController,
                    onChanged: (value) => {widget.setUserId(value)},
                    style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff000000)),
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 11.5),
                        filled: true,
                        fillColor: Color(0xfff4f4f4),
                        border: InputBorder.none),
                  )),
              const SizedBox(width: 6),
              Expanded(
                  flex: 0,
                  child: SizedBox(
                      height: 46,
                      child: OutlinedButton(
                          onPressed: () async {},
                          style: OutlinedButton.styleFrom(
                              backgroundColor: const Color(0xff000000),
                              side: const BorderSide(
                                  color: Color(0xff000000), width: 1.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 31.5, vertical: 12)),
                          child: const Text("재전송",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xffffffff))))))
            ]),
            const SizedBox(height: 54),
            // 인증번호 영역
            const Row(children: [
              Expanded(
                  child: Text('인증 번호',
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
                    controller: codeController,
                    focusNode: codeFocusNode,
                    style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff000000)),
                    decoration: InputDecoration(
                        suffixIcon: codeController.text.isNotEmpty
                            ? IconButton(
                                onPressed: () {
                                  codeController.clear();

                                  setState(() {
                                    statusType = "";
                                  });
                                },
                                icon: const Icon(Icons.clear,
                                    color: Color(0xff000000)),
                                iconSize: 24.0,
                                padding: const EdgeInsets.all(0))
                            : null,
                        hintText: codeFocusNode.hasFocus ? '' : "인증 번호",
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
                            if (codeController.text.length == 6) {}
                          },
                          style: OutlinedButton.styleFrom(
                              backgroundColor: codeController.text.length == 6
                                  ? const Color(0xff000000)
                                  : const Color(0xffb3b3b3),
                              side: BorderSide(
                                  color: codeController.text.length == 6
                                      ? const Color(0xff000000)
                                      : const Color(0xffb3b3b3),
                                  width: 1.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0)),
                              padding: const EdgeInsets.all(12)),
                          child: const Text("인증번호 확인",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xffffffff))))))
            ]),
            const SizedBox(height: 8),
            Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                      width: 16,
                      height: 16,
                      child: Image.asset('assets/icons/icon_time.png')),
                  const SizedBox(width: 2),
                  Text(timerString,
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff1b1b1b)))
                ])
          ])
        ]));
  }
}
