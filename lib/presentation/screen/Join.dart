/**
 * 회원가입 페이지
 * progress 별 단계
 * 1: 이메일 입력
 * 2: 비밀번호 입력
 * 3: 이름 입력
 * 4: 직군/업무 입력
 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'package:acebot_front/presentation/widget/common/BaseAppBar.dart';
import 'package:acebot_front/presentation/widget/join/firstProgress.dart';
import 'package:acebot_front/presentation/widget/join/secondProgress.dart';
import 'package:acebot_front/presentation/widget/common/BaseOutlineButton.dart';

class Join extends StatefulWidget {
  @override
  _JoinState createState() => _JoinState();
}

class _JoinState extends State<Join> {
  double progress = 1;
  bool ableToProgress = false;
  String userId = "";
  String userPassword = "";
  String userCheckPassword = "";
  String userName = "";
  String userJob = "";
  List<String> userTasks = [];

  @override
  void initState() {
    super.initState();
    progress = 1;
    ableToProgress = true;
    userId = "";
    userPassword = "";
    userCheckPassword = "";
    userName = "";
    userJob = "";
    userTasks = [];
  }

  // Progress 업데이트
  void setProgress(double value) {
    setState(() {
      progress = value;
    });
  }

  // ableToProgress 업데이트
  void setAbleToProgress(bool value) {
    setState(() {
      ableToProgress = value;
    });
  }

  // userId 업데이트
  void setUserId(String value) {
    setState(() {
      userId = value;
    });
  }

  // userPassword 업데이트
  void setUserPassword(String value) {
    setState(() {
      userPassword = value;
    });
  }

  // userCheckPassword 업데이트
  void setUserCheckPassword(String value) {
    setState(() {
      userCheckPassword = value;
    });
  }

  // userName 업데이트
  void setUserName(String value) {
    setState(() {
      userName = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: BaseAppBar(
                title: '회원가입',
                actions: [
                  IconButton(
                      onPressed: () {
                        context.pop();
                      },
                      icon: const Icon(Icons.clear),
                      padding: const EdgeInsets.all(0))
                ],
                leading: SizedBox()),
            body: Center(
                child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                    child: Column(
                      children: <Widget>[
                        LinearPercentIndicator(
                            progressColor: const Color(0xff595959),
                            backgroundColor: const Color(0xffebebeb),
                            lineHeight: 2.0,
                            percent: progress / 4),

                        /**
                             * Progress = 1 : 이메일 입력
                             * Progress = 2 : 비밀번호 입력
                             * Progress = 3 : 이름 입력
                             * Progress = 4 : 직군/업무 입력
                             * Progress = 5 : 완료 및 시작하기
                             */
                        progress == 1
                            ? FirstProgress(
                                setProgress: setProgress,
                                setAbleToProgress: setAbleToProgress,
                                setUserId: setUserId,
                                userId: userId)
                            : Container(),
                        progress == 2
                            ? SecondProgress(
                                setProgress: setProgress,
                                setAbleToProgress: setAbleToProgress,
                                setUserPassword: setUserPassword,
                                userPassword: userPassword,
                                setUserCheckPassword: setUserCheckPassword,
                                userCheckPassword: userCheckPassword)
                            : Container(),
                        Expanded(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                              Row(children: <Widget>[
                                BaseOutlineButton(
                                    onPressedFunc: () {
                                      ableToProgress
                                          ? setProgress(progress + 1)
                                          : null;
                                    },
                                    text: '다음',
                                    fontSize: 16.0,
                                    textColor: const Color(0xffffffff),
                                    backgroundColor: ableToProgress
                                        ? const Color(0xff000000)
                                        : const Color(0xffb3b3b3),
                                    borderColor: ableToProgress
                                        ? const Color(0xff000000)
                                        : const Color(0xffb3b3b3))
                              ])
                            ])),
                      ],
                    )))));
  }
}
