/// 마이페이지 수정 후
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart';

import 'package:acebot_front/presentation/widget/common/baseDropdown.dart';
import 'package:acebot_front/presentation/widget/common/baseOutlineButton.dart';
import 'package:acebot_front/presentation/widget/common/baseToast.dart';

import 'package:acebot_front/api/utilService.dart';
import 'package:acebot_front/api/userService.dart';

import 'package:acebot_front/bloc/user/selfState.dart';
import 'package:acebot_front/bloc/user/selfCubit.dart';

class AfterEditing extends StatefulWidget {
  final Function setIsEditing;

  const AfterEditing({super.key, required this.setIsEditing});

  @override
  _AfterEditingState createState() => _AfterEditingState();
}

class _AfterEditingState extends State<AfterEditing> {
  FocusNode userNameFocusNode = FocusNode();
  String userNamePlaceholder = "이름";
  TextEditingController userNameController = TextEditingController();
  String? userName = "";
  dynamic userJob = '';
  List<dynamic> userTasks = [];

  /// 수정 여부 파악
  bool isEditted = false;
  String initialUserName = "";
  dynamic initialUserJob = "";
  List<dynamic> initialUserTasks = [];

  // 폼 유효성 여부 파악
  bool isValidForm = true;

  // 직군 드롭다운 아이템
  List<dynamic> jobList = [];
  // 업무 체크박스 아이템
  List<dynamic> tasksList = [];

  @override
  void initState() {
    super.initState();

    userNameFocusNode.addListener(() {
      setState(() {
        userNamePlaceholder = userNameFocusNode.hasFocus ? "" : "이름";
      });
    });

    /**
     * isEditted 초기값 설정
     */
    final selfCubit = context.read<SelfCubit>();
    SelfState theState = selfCubit.state;
    if (theState is LoadedState) {
      setState(() {
        userName = theState.userJson.name;
        initialUserName = theState.userJson.name;
        userNameController.text = theState.userJson.name;

        userJob = theState.userJson.role;
        initialUserJob = theState.userJson.role;

        userTasks = theState.userJson.work;
        initialUserTasks = theState.userJson.work;
      });
    }

    UtilService().getWorksRolesList().then((res) => {
          setState(() {
            jobList = res.data["role"];
            tasksList = res.data["work"];
          })
        });
  }

  Widget _listView(String title, Widget child) {
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
      Row(children: [Expanded(child: child)])
    ]);
  }

  Widget _taskCheckbox(String value) {
    return GestureDetector(
        onTap: () {
          setState(() {
            userTasks.contains(value)
                ? userTasks.remove(value)
                : userTasks.add(value);

            isEditted = true;
          });
        },
        child: Container(
            height: 32,
            padding: const EdgeInsets.fromLTRB(6, 6, 12, 6),
            decoration: BoxDecoration(
              color: const Color(0xffffffff),
              border: Border.all(
                  color: userTasks.contains(value)
                      ? const Color(0xff000000)
                      : const Color(0xffebebeb)),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 16,
                      height: 16,
                      child: Image.asset('assets/icons/icon_check.png',
                          color: userTasks.contains(value)
                              ? const Color(0xff000000)
                              : const Color(0xffebebeb))),
                  const SizedBox(width: 7),
                  Text(value,
                      style: TextStyle(
                          fontSize: 14,
                          color: const Color(0xff1a1a1a),
                          fontWeight: userTasks.contains(value)
                              ? FontWeight.w700
                              : FontWeight.w500))
                ])));
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (userName!.isNotEmpty && userJob.isNotEmpty && userTasks.isNotEmpty) {
        setState(() {
          isValidForm = true;
        });
      } else {
        setState(() {
          isValidForm = false;
        });
      }
    });

    return BlocBuilder<SelfCubit, SelfState>(
      builder: (_, state) {
        if (state is LoadedState &&
            jobList.isNotEmpty &&
            tasksList.isNotEmpty) {
          return Column(children: [
            _listView(
                '이름',
                TextField(
                  focusNode: userNameFocusNode,
                  controller: userNameController,
                  onChanged: (value) => {
                    setState(() {
                      userName = value;
                      isEditted = true;
                    })
                  },
                  style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff000000)),
                  decoration: InputDecoration(
                      suffixIcon: userNameController.text.isNotEmpty
                          ? IconButton(
                              onPressed: () {
                                userNameController.clear();
                              },
                              icon: const Icon(Icons.clear,
                                  color: Color(0xff000000)),
                              iconSize: 24.0,
                              padding: const EdgeInsets.all(0))
                          : null,
                      hintText: userNamePlaceholder,
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
            const SizedBox(height: 38),
            _listView(
                '직군',
                BaseDropdown(
                    onChanged: (value) {
                      setState(() {
                        userJob = value;
                      });
                    },
                    options: jobList,
                    selected: userJob)),
            const SizedBox(height: 28),
            _listView(
                '업무',
                Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.start,
                    children: tasksList
                        .where((task) => task != null)
                        .map((task) => _taskCheckbox(task))
                        .toList())),
            const SizedBox(height: 20),
            Row(children: [
              BaseOutlineButton(
                  onPressedFunc: () async {
                    if (isEditted && isValidForm) {
                      final selfCubit = context.read<SelfCubit>();
                      try {
                        await selfCubit.patchSelfData({
                          "name": userName,
                          "role": userJob,
                          "work": userTasks
                        });

                        if (mounted) {
                          BaseToast(content: '수정 완료되었습니다.', context: context)
                              .showToast();
                        }

                        widget.setIsEditing(false);
                      } on DioException catch (err) {}
                    }
                  },
                  text: '저장',
                  fontSize: 16.0,
                  textColor: const Color(0xffffffff),
                  backgroundColor: (isEditted && isValidForm)
                      ? const Color(0xff000000)
                      : const Color(0xffb3b3b3),
                  borderColor: (isEditted && isValidForm)
                      ? const Color(0xff000000)
                      : const Color(0xffb3b3b3))
            ])
          ]);
        } else {
          return Container();
        }
      },
    );
  }
}
