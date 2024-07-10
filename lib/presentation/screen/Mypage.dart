/// 마이페이지
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:acebot_front/presentation/widget/common/baseAppBar.dart';
import 'package:acebot_front/presentation/widget/common/baseBody.dart';
import 'package:acebot_front/presentation/widget/mypage/beforeEditing.dart';
import 'package:acebot_front/presentation/widget/mypage/afterEditing.dart';
import 'package:acebot_front/presentation/widget/common/baseDialog.dart';

import 'package:acebot_front/bloc/user/selfState.dart';
import 'package:acebot_front/bloc/user/selfCubit.dart';

class Mypage extends StatefulWidget {
  const Mypage({super.key});

  @override
  _MypageState createState() => _MypageState();
}

class _MypageState extends State<Mypage> {
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
  }

  /// 수정 여부 업데이트
  void setIsEditing(bool value) {
    setState(() {
      isEditing = value;
    });
  }

  Widget _bodyWidget() {
    return BlocBuilder<SelfCubit, SelfState>(builder: (_, state) {
      if (state is LoadedState) {
        return Center(
            child: Container(
                padding: const EdgeInsets.all(20),
                child: !isEditing
                    ? BeforeEditing(
                        setIsEditing: setIsEditing,
                      )
                    : AfterEditing(
                        setIsEditing: setIsEditing,
                      )));
      } else {
        return Container();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: BaseAppBar(
                title:
                    !isEditing ? const Text('마이페이지') : const Text('개인 정보 수정'),
                actions: [
                  !isEditing
                      ? IconButton(
                          onPressed: () {
                            context.go('/history');
                          },
                          icon: const Icon(Icons.clear),
                          iconSize: 12,
                          padding: const EdgeInsets.all(0))
                      : IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return BaseDialog(
                                      title: "수정한 내용이 저장되지 않습니다.",
                                      content:
                                          "변경된 내용을 저장하지 않고 화면을\n이탈하는 경우, 변경 값이 저장되지 않습니다.",
                                      buttonsList: [
                                        Expanded(
                                            child: OutlinedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                style: OutlinedButton.styleFrom(
                                                    backgroundColor:
                                                        const Color(0xffffffff),
                                                    side: const BorderSide(
                                                        color:
                                                            Color(0xffe7e7e7),
                                                        width: 1.0),
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4.0)),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 13)),
                                                child: const Text("닫기",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            Color(0xff000000))))),
                                        const SizedBox(width: 9),
                                        Expanded(
                                            child: OutlinedButton(
                                                onPressed: () async {
                                                  if (mounted) {
                                                    setIsEditing(false);

                                                    Navigator.pop(context);
                                                  }
                                                },
                                                style: OutlinedButton.styleFrom(
                                                    backgroundColor:
                                                        const Color(0xff000000),
                                                    side: const BorderSide(
                                                        color:
                                                            Color(0xff000000),
                                                        width: 1.0),
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4.0)),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 13)),
                                                child: const Text("확인",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            Color(0xffffffff))))),
                                      ]);
                                });
                          },
                          icon: const Icon(Icons.clear),
                          iconSize: 12,
                          padding: const EdgeInsets.all(0))
                ],
                leading: !isEditing
                    ? IconButton(
                        onPressed: () {
                          context.go('/history');
                        },
                        icon: const Icon(Icons.arrow_back_ios_new),
                        iconSize: 15,
                        padding: const EdgeInsets.all(0))
                    : Container()),
            body: BaseBody(child: _bodyWidget())));
  }
}
