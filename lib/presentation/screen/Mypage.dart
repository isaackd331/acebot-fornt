/**
 * 마이페이지
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:acebot_front/presentation/widget/common/baseAppBar.dart';
import 'package:acebot_front/presentation/widget/common/baseBody.dart';
import 'package:acebot_front/presentation/widget/mypage/beforeEditting.dart';

import 'package:acebot_front/bloc/user/selfState.dart';
import 'package:acebot_front/bloc/user/selfCubit.dart';

class Mypage extends StatefulWidget {
  @override
  _MypageState createState() => _MypageState();
}

class _MypageState extends State<Mypage> {
  bool isEditting = false;

  void initState() {
    super.initState();

    /**
     * 사용할 Cubit 초기화
     */
    context.read<SelfCubit>();
  }

  /**
   * 수정 여부 업데이트
   */
  void setIsEditting(bool value) {
    setState(() {
      isEditting = value;
    });
  }

  Widget _bodyWidget() {
    return BlocListener<SelfCubit, SelfState>(
        listener: (context, state) {},
        child: BlocBuilder<SelfCubit, SelfState>(builder: (_, state) {
          /**
           * TODO
           * 퍼블리싱 끝난 후 state is LoadedState로 변경
           */
          if (state is! LoadedState) {
            return Center(
                child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: !isEditting
                        ? BeforeEditting(setIsEditting: setIsEditting)
                        : Container()));
          } else {
            return Container();
          }
        }));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: BaseAppBar(
                title: !isEditting ? '내 정보 관리' : '내 정보 수정',
                actions: [
                  !isEditting
                      ? IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.clear),
                          iconSize: 12,
                          padding: const EdgeInsets.all(0))
                      : IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.clear),
                          iconSize: 12,
                          padding: const EdgeInsets.all(0))
                ],
                leading: !isEditting
                    ? IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.arrow_back_ios_new),
                        iconSize: 15,
                        padding: const EdgeInsets.all(0))
                    : Container()),
            body: BaseBody(child: _bodyWidget())));
  }
}
