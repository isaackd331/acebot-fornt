/// screen/History.dart
/// Widget for threads in a project
library;

import 'package:flutter/material.dart';

import 'package:acebot_front/presentation/widget/history/projectsBottomsheet.dart';
import 'package:acebot_front/presentation/widget/common/baseDialog.dart';
import 'package:acebot_front/presentation/widget/common/baseToast.dart';
import 'package:acebot_front/presentation/widget/common/noScrollbar.dart';
import 'package:acebot_front/presentation/widget/history/threadQnaBottomsheet.dart';

import 'package:acebot_front/api/threadService.dart';
import 'package:acebot_front/api/projectService.dart';

class SubThreadWidget extends StatefulWidget {
  final int projectId;
  final Function resetProjectList;

  const SubThreadWidget(
      {super.key, required this.projectId, required this.resetProjectList});

  @override
  _SubThreadWidgetState createState() => _SubThreadWidgetState();
}

class _SubThreadWidgetState extends State<SubThreadWidget> {
  List<dynamic> threadList = [];
  int? isEditing;
  TextEditingController titleEditController = TextEditingController();
  ScrollController scrollController = ScrollController();
  int page = 2;
  late int maxPage;
  bool isPaging = false;

  @override
  void initState() {
    super.initState();

    scrollController.addListener(scrollListener);

    ProjectService().getThreadsInProject(1, widget.projectId).then((res) {
      setState(() {
        threadList = res.data['items'];
        maxPage = res.data['pages'];
      });
    });
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);

    super.dispose();
  }

  Future<void> scrollListener() async {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange &&
        !isPaging &&
        page <= maxPage) {
      setState(() {
        isPaging = true;
      });

      await ProjectService().getThreadsInProject(page, widget.projectId);

      setState(() {
        page += 1;
        isPaging = false;
      });
    }
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
                    ? GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (BuildContext context) {
                                return ThreadQnaBottomsheet(
                                    threadId: data["threadId"]);
                              });
                        },
                        child: Text(data['title'],
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: !otherIsEditing
                                    ? const Color(0xff1c1c1c)
                                    : const Color(0xff939393)),
                            overflow: TextOverflow.ellipsis))
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
                                        threadIds: [data["threadId"]],
                                        funcForMultiple:
                                            widget.resetProjectList,
                                      );
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
                                            Expanded(
                                                child: OutlinedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    style: OutlinedButton.styleFrom(
                                                        backgroundColor: const Color(
                                                            0xffffffff),
                                                        side: const BorderSide(
                                                            color: Color(
                                                                0xffe7e7e7),
                                                            width: 1.0),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    4.0)),
                                                        padding:
                                                            const EdgeInsets.symmetric(
                                                                vertical: 13)),
                                                    child: const Text("취소",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Color(
                                                                0xff000000))))),
                                            const SizedBox(width: 9),
                                            Expanded(
                                                child: OutlinedButton(
                                                    onPressed: () async {
                                                      if (mounted) {
                                                        try {
                                                          await ThreadService()
                                                              .deleteThreads([
                                                            data['threadId']
                                                          ]);

                                                          List<dynamic>
                                                              tempArr =
                                                              List.from(
                                                                  threadList);

                                                          tempArr.remove(
                                                              data['threadId']);

                                                          setState(() {
                                                            threadList =
                                                                tempArr;
                                                          });

                                                          BaseToast(
                                                                  content:
                                                                      '스레드가 삭제되었습니다.',
                                                                  context:
                                                                      context)
                                                              .showToast();
                                                        } catch (err) {
                                                          BaseToast(
                                                                  content:
                                                                      '일시적인 오류입니다.',
                                                                  context:
                                                                      context)
                                                              .showToast();
                                                        }

                                                        Navigator.pop(context);
                                                      }
                                                    },
                                                    style: OutlinedButton.styleFrom(
                                                        backgroundColor: const Color(
                                                            0xff000000),
                                                        side: const BorderSide(
                                                            color: Color(
                                                                0xff000000),
                                                            width: 1.0),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    4.0)),
                                                        padding:
                                                            const EdgeInsets.symmetric(
                                                                vertical: 13)),
                                                    child: const Text("확인",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Color(
                                                                0xffffffff))))),
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

                      dynamic theThread = threadList.firstWhere(
                          (value) => value["threadId"] == data['threadId'],
                          orElse: () => null);

                      if (theThread != null) {
                        theThread['title'] = theTitle;
                      }

                      setState(() {
                        isEditing = null;
                      });

                      await ThreadService()
                          .patchThread([data["threadId"]], theTitle, null);
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
    return Container(
        height: 140,
        padding: const EdgeInsets.only(left: 50),
        child: NoScrollbarWrapper(
            child: ListView.builder(
                controller: scrollController,
                itemCount: threadList.length,
                itemBuilder: (BuildContext context, int idx) {
                  return _threadRow(threadList[idx]);
                })));
  }
}
