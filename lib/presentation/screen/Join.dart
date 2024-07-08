/// 회원가입 페이지
/// progress 별 단계
/// 1: 이메일 입력
/// 2: 비밀번호 입력
/// 3: 이름 입력
/// 4: 직군/업무 입력
/// 5: 이메일 인증
/// 6: 가입완료 화면
library;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'package:acebot_front/presentation/widget/join/firstProgress.dart';
import 'package:acebot_front/presentation/widget/join/secondProgress.dart';
import 'package:acebot_front/presentation/widget/join/thirdProgress.dart';
import 'package:acebot_front/presentation/widget/join/fourthProgress.dart';
import 'package:acebot_front/presentation/widget/join/emailVerification.dart';
import 'package:acebot_front/presentation/widget/join/joinSuccess.dart';
import 'package:acebot_front/presentation/widget/common/baseAppBar.dart';
import 'package:acebot_front/presentation/widget/common/baseOutlineButton.dart';
import 'package:acebot_front/presentation/widget/common/baseBody.dart';

class Join extends StatefulWidget {
  const Join({super.key});

  @override
  _JoinState createState() => _JoinState();
}

class _JoinState extends State<Join> {
  double progress = 6;
  bool ableToProgress = false;
  String userId = "";
  String userPassword = "";
  String userCheckPassword = "";
  String userName = "";
  dynamic userJob = "직군을 선택해 주세요";
  List<dynamic> userTasks = [];

  @override
  void initState() {
    super.initState();
    progress = 6;
    ableToProgress = false;
    userId = "";
    userPassword = "";
    userCheckPassword = "";
    userName = "";
    userJob = "";
    userTasks = [];
  }

  @override
  void dispose() {
    progress = 1;
    ableToProgress = false;
    userId = "";
    userPassword = "";
    userCheckPassword = "";
    userName = "";
    userJob = "";
    userTasks = [];

    super.dispose();
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

  // userJob 업데이트
  void setUserJob(dynamic value) {
    setState(() {
      userJob = value;
    });
  }

  // userTasks 업데이트
  void setUserTasks(dynamic value) {
    if (userTasks.contains(value)) {
      List<dynamic> copiedList = userTasks;
      copiedList.remove(value);

      setState(() {
        userTasks = copiedList;
      });
    } else {
      setState(() {
        userTasks = [...userTasks, value];
      });
    }
  }

  Widget _bodyWidget() {
    Widget progressWidget() {
      switch (progress) {
        case 1:
          return FirstProgress(
              setProgress: setProgress,
              setAbleToProgress: setAbleToProgress,
              setUserId: setUserId,
              userId: userId);
        case 2:
          return SecondProgress(
              setProgress: setProgress,
              setAbleToProgress: setAbleToProgress,
              setUserPassword: setUserPassword,
              userPassword: userPassword,
              setUserCheckPassword: setUserCheckPassword,
              userCheckPassword: userCheckPassword);
        case 3:
          return ThirdProgress(
              setProgress: setProgress,
              setAbleToProgress: setAbleToProgress,
              setUserName: setUserName,
              userName: userName);
        case 4:
          return FourthProgress(
              setProgress: setProgress,
              setAbleToProgress: setAbleToProgress,
              setUserJob: setUserJob,
              setUserTasks: setUserTasks,
              userJob: userJob,
              userTasks: userTasks);
        case 5:
          return EmailVerification(
              setProgress: setProgress,
              setAbleToProgress: setAbleToProgress,
              setUserId: setUserId,
              userId: userId);

        default:
          return Container();
      }
    }

    return Center(
        child: Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            child: Column(
              children: [
                progress <= 5
                    ? LinearPercentIndicator(
                        progressColor: const Color(0xff595959),
                        backgroundColor: const Color(0xffebebeb),
                        lineHeight: 2.0,
                        percent: progress / 5)
                    : Container(),

                /**
                  * Progress = 1 : 이메일 입력
                  * Progress = 2 : 비밀번호 입력
                  * Progress = 3 : 이름 입력
                  * Progress = 4 : 직군/업무 입력
                  * Progress = 5 : 이메일 인증
                  */
                progressWidget(),
                progress <= 5
                    ? Expanded(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                            /**
                           * 네이티브 키보드 출현 시 컨텐츠와 버튼이 너무 붙는
                           * 문제를 해결하기 위해 삽입
                           */
                            const SizedBox(height: 20),
                            Row(children: [
                              BaseOutlineButton(
                                  onPressedFunc: () {
                                    if (progress < 5) {
                                      if (ableToProgress) {
                                        setProgress(progress + 1);

                                        setAbleToProgress(false);
                                      }
                                    } else if (progress == 5) {
                                      if (ableToProgress) {
                                        setProgress(progress + 1);

                                        setAbleToProgress(true);
                                      }
                                    }
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
                          ]))
                    : Container()
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: progress <= 5
          ? BaseAppBar(
              title: progress < 5 ? '회원가입' : "이메일 인증",
              actions: [
                IconButton(
                    onPressed: () {
                      context.go('/login');
                    },
                    icon: const Icon(Icons.clear),
                    padding: const EdgeInsets.all(0))
              ],
              leading: progress != 1
                  ? IconButton(
                      onPressed: () {
                        setProgress(progress - 1);

                        setAbleToProgress(false);
                      },
                      icon: const Icon(Icons.arrow_back_ios_new_outlined),
                      iconSize: 16,
                      padding: const EdgeInsets.all(0))
                  : Container())
          : AppBar(
              backgroundColor: const Color(0xffffffff),
            ),
      body:
          progress <= 5 ? BaseBody(child: _bodyWidget()) : const JoinSuccess(),
    ));
  }
}
