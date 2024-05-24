/**
 * 마이페이지 수정 후
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:acebot_front/presentation/widget/common/baseDropdown.dart';

import 'package:acebot_front/bloc/user/selfState.dart';
import 'package:acebot_front/bloc/user/selfCubit.dart';

class AfterEditting extends StatefulWidget {
  @override
  _AfterEdittingState createState() => _AfterEdittingState();
}

class _AfterEdittingState extends State<StatefulWidget> {
  FocusNode userNameFocusNode = FocusNode();
  String userNamePlaceholder = "이름";
  bool isUserNameEmpty = false;
  TextEditingController userNameController = TextEditingController();
  String? userName = "";
  String userJob = 'Marketing';
  List<String> userTasks = ["커뮤니케이션, 로드맵 작성, SWOT 분석, 경쟁사 분석"];

  void initState() {
    super.initState();

    userNameFocusNode.addListener(() {
      setState(() {
        userNamePlaceholder = userNameFocusNode.hasFocus ? "" : "이름";
      });
    });

    userNameController.addListener(() {
      setState(() {
        isUserNameEmpty = userNameController.text.isEmpty;
      });
    });

    /**
     * 사용할 Cubit 초기화
     */
    context.read<SelfCubit>();
  }

  final List<String> _dropdownItems = [
    'Marketing',
    'Sales',
    'Design',
    'Developer',
    'Production',
    'Researcher',
    'Engineer',
    'Test',
    'QA',
  ];

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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelfCubit, SelfState>(
      builder: (_, state) {
        if (state is LoadedState) {
          /**
           * 위젯이 완전히 빌드 된 후 setState 작동되도록
           */
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
              userName = state.userJson.name!;
            });
          });
        }

        return Column(children: [
          _listView(
              '이름',
              TextField(
                focusNode: userNameFocusNode,
                controller: userNameController,
                onChanged: (value) => {
                  setState(() {
                    userName = value;
                  })
                },
                style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff000000)),
                decoration: InputDecoration(
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
                  options: _dropdownItems,
                  selected: userJob))
        ]);
      },
    );
  }
}
