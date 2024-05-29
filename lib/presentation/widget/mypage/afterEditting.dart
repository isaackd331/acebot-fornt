/// 마이페이지 수정 후
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:acebot_front/presentation/widget/common/baseDropdown.dart';
import 'package:acebot_front/presentation/widget/common/baseOutlineButton.dart';

import 'package:acebot_front/bloc/user/selfState.dart';
import 'package:acebot_front/bloc/user/selfCubit.dart';

class AfterEditting extends StatefulWidget {
  const AfterEditting({super.key});

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
  List<String> userTasks = ['커뮤니케이션', '로드맵 작성', 'SWOT 분석', '경쟁사 분석'];

  /// 수정 여부 파악
  bool isEditted = false;
  late String initialUserName;
  late String initialUserJob;
  late List<String> initialUserTasks;

  @override
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

    /**
     * isEditted 초기값 설정
     */
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(mounted) {
        setState(() {
          initialUserName = userNameController.text;
          initialUserJob = userJob;
          initialUserTasks = List.from(userTasks);
        });
      }
    });
  }

  /// 직군 드롭다운 아이템 설정
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

  /// 업무 체크박스 아이템 설정
  final List<String> _tasksItems = [
    '시장 조사',
    '커뮤니케이션',
    '예산 집행',
    '재무 데이터 분석',
    '리포트 작성',
    '로드맵 작성',
    '계약서 작성',
    '사용자 조사',
    '홍보 전략 수집',
    '연구',
    '재무 데이터 분석',
    '리포트 작성',
    '로드맵 작성',
    'SWOT 분석',
    '홍보 전략 수립',
    '분석',
    '경쟁사 분석',
    '로드맵 작성',
    '마케팅 문구 작성',
    '경쟁사 분석'
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
    return BlocBuilder<SelfCubit, SelfState>(
      builder: (_, state) {
        if (state is LoadedState) {
          /**
           * 위젯이 완전히 빌드 된 후 setState 작동되도록
           */
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if(mounted) {
              setState(() {
                /**
                 * TODO
                 * UserJson 데이터 추가 시 수정 필요
                 * userJon userTasks(현재 로컬 데이터로 사용 중)
                 */
                userName = state.userJson.name!;
                initialUserName = state.userJson.name!;

                if (userName != initialUserName ||
                    userJob != initialUserJob ||
                    !listEquals(userTasks, initialUserTasks)) {
                  isEditted = true;
                } else {
                  isEditted = false;
                }
              });
            }
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
                    isEditted = true;
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
                  selected: userJob)),
          const SizedBox(height: 28),
          _listView(
              '업무',
              Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.start,
                  children: _tasksItems
                      .where((task) => task != null)
                      .map((task) => _taskCheckbox(task))
                      .toList())),
          const SizedBox(height: 20),
          Row(children: [
            BaseOutlineButton(
                onPressedFunc: () {
                  if (isEditted) {
                    /**
                     * TODO
                     * Toast Message + Edit Function
                     */
                  }
                },
                text: '저장',
                fontSize: 16.0,
                textColor: const Color(0xffffffff),
                backgroundColor: isEditted
                    ? const Color(0xff000000)
                    : const Color(0xffb3b3b3),
                borderColor: isEditted
                    ? const Color(0xff000000)
                    : const Color(0xffb3b3b3))
          ])
        ]);
      },
    );
  }
}
