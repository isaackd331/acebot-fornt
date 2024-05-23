/**
 * 마이페이지 수정 전
 */

import 'package:flutter/material.dart';

import 'package:acebot_front/bloc/user/selfState.dart';
import 'package:acebot_front/bloc/user/selfCubit.dart';

class BeforeEditting extends StatefulWidget {
  final Function setIsEditting;

  const BeforeEditting({super.key, required this.setIsEditting});

  @override
  _BeforeEdittingState createState() => _BeforeEdittingState();
}

class _BeforeEdittingState extends State<BeforeEditting> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("내 정보",
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
          ])
    ]);
  }
}
