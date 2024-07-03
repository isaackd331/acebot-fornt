/// screen/History.dart
/// Widget for when tabMode == 'thread'
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:acebot_front/presentation/widget/common/baseOutlineButton.dart';
import 'package:acebot_front/presentation/widget/history/projectsBottomsheet.dart';
import 'package:acebot_front/presentation/widget/common/baseDialog.dart';
import 'package:acebot_front/presentation/widget/common/baseToast.dart';

import 'package:acebot_front/api/threadService.dart';

import 'package:acebot_front/bloc/thread/threadState.dart';
import 'package:acebot_front/bloc/thread/threadCubit.dart';

class ThreadWidget extends StatefulWidget {
  const ThreadWidget({super.key});

  @override
  _ThreadWidgetState createState() => _ThreadWidgetState();
}

class _ThreadWidgetState extends State<ThreadWidget> {
  Map<String, dynamic> threadList = {};
  int? isEditing;
  TextEditingController titleEditController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  static String groupByString(String source) {
    final sourceDateTime = DateTime.tryParse(source);
    return groupByDateTime(sourceDateTime!);
  }

  static String groupByDateTime(DateTime source) {
    final dateTime = DateTime(source.year, source.month, source.day);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final diff = today.difference(dateTime).inDays;
    if (diff == 0) {
      return 'Today';
    } else if (diff == 1) {
      return 'Yesterday';
    } else if (diff > 1 && diff < 7) {
      return '$diff days ago';
    } else if (diff >= 7 && diff < 14) {
      return 'Last week';
    } else if (diff >= 14 && diff < 28) {
      return '${diff ~/ 7} weeks ago';
    } else if (diff >= 28 && diff < 60) {
      return 'Last month';
    } else {
      return '${diff ~/ 30} month ago';
    }
  }

  Widget _loadedButEmpty() {
    return Expanded(
        child: Column(children: [
      Flexible(
        flex: 4,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
              width: 68,
              height: 68,
              child: Image.asset('assets/icons/icon_thread_empty.png')),
          const SizedBox(height: 12),
          const Text('스레드가 없습니다.',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff1c1c1c)))
        ]),
      ),
      Flexible(
          flex: 1,
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
              BaseOutlineButton(
                  onPressedFunc: () {
                    context.go('/home');
                  },
                  text: '스레드 추가하기',
                  fontSize: 16,
                  textColor: const Color(0xffffffff),
                  backgroundColor: const Color(0xff000000),
                  borderColor: const Color(0xff000000))
            ]),
            const SizedBox(height: 24)
          ]))
    ]));
  }

  Widget _threadRow(dynamic data) {
    bool otherIsEditing = isEditing != null && isEditing != data['threadId'];
    bool selfIsEditing = isEditing != null && isEditing == data['threadId'];

    return Container(
        padding: const EdgeInsets.symmetric(vertical: 14.5),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/icons/icon_thread.png',
                scale: 4,
                color: !otherIsEditing
                    ? const Color(0xff1c1c1c)
                    : const Color(0xff939393)),
            const SizedBox(width: 6),
            Expanded(
                child: !selfIsEditing
                    ? Text(data['title'],
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: !otherIsEditing
                                ? const Color(0xff1c1c1c)
                                : const Color(0xff939393)))
                    : Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: Color(0xff000000),
                          width: 1,
                        ))),
                        child: TextField(
                            controller: titleEditController
                              ..text = data["title"],
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff1c1c1c)),
                            decoration: const InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.only(bottom: 5),
                                border: InputBorder.none)))),
            const SizedBox(width: 6),
            !selfIsEditing
                ? Theme(
                    data: Theme.of(context).copyWith(
                        splashColor: Colors.transparent,
                        tooltipTheme: const TooltipThemeData(
                            decoration:
                                BoxDecoration(color: Colors.transparent))),
                    child: PopupMenuButton(
                      enabled: !otherIsEditing,
                      padding: EdgeInsets.zero,
                      color: const Color(0xff323232),
                      tooltip: "",
                      offset: const Offset(-10, 40),
                      itemBuilder: (BuildContext context) {
                        return [
                          PopupMenuItem(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (BuildContext context) {
                                      return ProjectsBottomsheet(
                                          threadId: data["threadId"]);
                                    });
                              },
                              height: 0,
                              padding: EdgeInsets.zero,
                              child: Container(
                                  height: 40,
                                  padding:
                                      const EdgeInsets.fromLTRB(14, 8, 0, 8),
                                  decoration: const BoxDecoration(
                                      color: Color(0xff323232)),
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: Image.asset(
                                              'assets/icons/icon_thread-popup-move.png'),
                                        ),
                                        const SizedBox(width: 8),
                                        const Text('프로젝트 이동',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xffffffff)))
                                      ]))),
                          PopupMenuItem(
                              onTap: () {
                                setState(() {
                                  isEditing = data['threadId'];
                                });
                              },
                              height: 0,
                              padding: EdgeInsets.zero,
                              child: Container(
                                  height: 50,
                                  padding:
                                      const EdgeInsets.fromLTRB(14, 8, 0, 8),
                                  decoration: const BoxDecoration(
                                      color: Color(0xff171717)),
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: Image.asset(
                                              'assets/icons/icon_thread-popup-edit-name.png'),
                                        ),
                                        const SizedBox(width: 8),
                                        const Text('이름 변경',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xffffffff)))
                                      ]))),
                          PopupMenuItem(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return BaseDialog(
                                          title: "스레드를 삭제하시겠어요?",
                                          content: "삭제한 스레드는 복구할 수 없습니다.",
                                          buttonsList: [
                                            OutlinedButton(
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
                                                        horizontal: 57.5,
                                                        vertical: 13)),
                                                child: const Text("취소",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            Color(0xff000000)))),
                                            const SizedBox(width: 9),
                                            OutlinedButton(
                                                onPressed: () async {
                                                  if (mounted) {
                                                    ThreadCubit threadCubit =
                                                        BlocProvider.of<
                                                                ThreadCubit>(
                                                            context);

                                                    await threadCubit.delete(
                                                        [data['threadId']]);

                                                    BaseToast(
                                                            content:
                                                                '스레드가 삭제되었습니다.',
                                                            context: context)
                                                        .showToast();

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
                                                        horizontal: 57.5,
                                                        vertical: 13)),
                                                child: const Text("확인",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            Color(0xffffffff)))),
                                          ]);
                                    });
                              },
                              height: 0,
                              padding: EdgeInsets.zero,
                              child: Container(
                                  height: 40,
                                  padding:
                                      const EdgeInsets.fromLTRB(14, 8, 0, 8),
                                  decoration: const BoxDecoration(
                                      color: Color(0xff323232)),
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: Image.asset(
                                              'assets/icons/icon_thread-popup-delete.png'),
                                        ),
                                        const SizedBox(width: 8),
                                        const Text('삭제',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xffffffff)))
                                      ]))),
                        ];
                      },
                    ))
                : OutlinedButton(
                    onPressed: () async {
                      String theTitle = titleEditController.text;

                      dynamic theThread = threadList.values
                          .expand((value) => value)
                          .firstWhere(
                              (value) => value["threadId"] == data['threadId'],
                              orElse: () => null);

                      if (theThread != null) {
                        theThread['title'] = theTitle;
                      }

                      setState(() {
                        isEditing = null;
                      });

                      await ThreadService()
                          .patchThread(data["threadId"], theTitle, null);
                    },
                    style: OutlinedButton.styleFrom(
                        backgroundColor: const Color(0xff000000),
                        side: const BorderSide(
                            color: Color(0xff000000), width: 1.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6)),
                    child: const Text("완료",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xffffffff))))
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ThreadCubit, ThreadState>(listener: (context, state) {
      if (state is LoadedState) {
        setState(() {
          threadList = {};
        });

        state.threadJson.items.asMap().forEach((_, item) {
          final when = groupByString(item['createdAt']);

          setState(() {
            if (threadList[when] != null) {
              threadList[when] = [...threadList[when], item];
            } else {
              threadList[when] = [item];
            }
          });
        });
      }
    }, child: BlocBuilder<ThreadCubit, ThreadState>(builder: (_, state) {
      if (state is! LoadedState) {
        return Container();
      } else {
        if (state.threadJson.items.isEmpty) {
          return _loadedButEmpty();
        } else {
          return Column(children: [
            const SizedBox(height: 24),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              GestureDetector(
                  onTap: () {},
                  child: const Text('편집',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff666666))))
            ]),
            const SizedBox(height: 23),
            threadList.isNotEmpty
                ? Column(
                    mainAxisSize: MainAxisSize.max,
                    children: threadList.entries.map((entry) {
                      return Column(children: [
                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(children: [
                              Text(
                                entry.key,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff1c1c1c)),
                              )
                            ])),
                        const SizedBox(height: 12),
                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                                children: entry.value.map<Widget>((thread) {
                              return _threadRow(thread);
                            }).toList())),
                        Container(
                            height: 1,
                            margin: const EdgeInsets.symmetric(vertical: 24),
                            decoration:
                                const BoxDecoration(color: Color(0xfff4f4f5)))
                      ]);
                    }).toList())
                : Container()
          ]);
        }
      }
    }));
  }
}
