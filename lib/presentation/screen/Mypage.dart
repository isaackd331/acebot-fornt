/// 마이페이지
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:acebot_front/presentation/widget/common/baseAppBar.dart';
import 'package:acebot_front/presentation/widget/common/baseBody.dart';
import 'package:acebot_front/presentation/widget/mypage/beforeEditing.dart';
import 'package:acebot_front/presentation/widget/mypage/afterEditing.dart';

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
                    : const AfterEditing()));
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
                title: !isEditing ? '마이페이지' : '개인 정보 수정',
                actions: [
                  !isEditing
                      ? IconButton(
                          onPressed: () {
                            setIsEditing(true);
                          },
                          icon: const Icon(Icons.clear),
                          iconSize: 12,
                          padding: const EdgeInsets.all(0))
                      : IconButton(
                          onPressed: () {
                            setIsEditing(false);
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
