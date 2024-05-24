/**
 * 마이페이지 수정 전
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:acebot_front/bloc/user/selfState.dart';
import 'package:acebot_front/bloc/user/selfCubit.dart';

class BeforeEditting extends StatefulWidget {
  final Function setIsEditting;

  const BeforeEditting({
    super.key,
    required this.setIsEditting,
  });

  @override
  _BeforeEdittingState createState() => _BeforeEdittingState();
}

class _BeforeEdittingState extends State<BeforeEditting> {
  @override
  void initState() {
    super.initState();
  }

  Widget _listView(String title, List<Widget> child) {
    return Column(children: [
      Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(title,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff828282)))
          ]),
      const SizedBox(height: 8),
      Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: child),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelfCubit, SelfState>(builder: (_, state) {
      if (state is LoadedState) {
        return Column(children: [
          Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("내 정보",
                    style: TextStyle(
                        color: Color(0xff000000),
                        fontSize: 20,
                        fontWeight: FontWeight.w700)),
                SizedBox(
                    width: 35,
                    height: 35,
                    child: IconButton(
                        onPressed: () {
                          widget.setIsEditting(true);
                        },
                        icon: Image.asset('assets/icons/icon_edit.png'),
                        iconSize: 24))
              ]),
          const SizedBox(height: 30),
          _listView('이름/메일', [
            Text("${state.userJson.name}",
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff000000))),
            const SizedBox(width: 8),
            Container(
              width: 1,
              height: 10,
              decoration: const BoxDecoration(color: Color(0xffd9d9d9)),
            ),
            const SizedBox(width: 8),
            Text("${state.userJson.email}",
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff828282))),
          ]),
          const SizedBox(height: 28),
          _listView('직군', [
            Text("Marketing",
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff000000))),
          ]),
          const SizedBox(height: 28),
          _listView('업무', [
            Flexible(
                child: Text(
                    "커뮤니케이션, 로드맵 작성, SWOT 분석, 경쟁사 분석, 텍스트 분석, 텍스트 분석, 텍스트 분석",
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff000000)))),
          ]),
          const SizedBox(height: 72),
          const Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("설정",
                    style: TextStyle(
                        color: Color(0xff000000),
                        fontSize: 20,
                        fontWeight: FontWeight.w700)),
              ]),
          const SizedBox(height: 36),
          const Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("비밀번호 변경",
                    style: TextStyle(
                        color: Color(0xff000000),
                        fontSize: 16,
                        fontWeight: FontWeight.w500)),
                Icon(Icons.arrow_forward_ios)
              ]),
          const SizedBox(height: 33),
          const Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("회원탈퇴",
                    style: TextStyle(
                        color: Color(0xff000000),
                        fontSize: 16,
                        fontWeight: FontWeight.w500)),
                Icon(Icons.arrow_forward_ios)
              ]),
        ]);
      } else {
        return Container();
      }
    });
  }
}
