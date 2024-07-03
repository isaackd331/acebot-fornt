/// screen/History.dart
/// Widget for when tabMode == 'project'
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:acebot_front/presentation/widget/common/baseDialog.dart';
import 'package:acebot_front/presentation/widget/common/baseToast.dart';
import 'package:acebot_front/presentation/widget/common/noScrollbar.dart';
import 'package:acebot_front/presentation/widget/history/threadQnaBottomsheet.dart';

import 'package:acebot_front/api/projectService.dart';

import 'package:acebot_front/bloc/project/projectState.dart';
import 'package:acebot_front/bloc/project/projectCubit.dart';

class ProjectWidget extends StatefulWidget {
  const ProjectWidget({super.key});

  @override
  _ProjectWidgetState createState() => _ProjectWidgetState();
}

class _ProjectWidgetState extends State<ProjectWidget> {
  List<dynamic> projectList = [];
  int? isEditing;
  TextEditingController titleEditController = TextEditingController();
  bool isMultipleMode = false;
  List<dynamic> multipleIds = [];
  List<dynamic> openedList = [];
  ScrollController scrollController = ScrollController();
  int page = 2;
  late int maxPage;
  bool isPaging = false;
  TextEditingController searchController = TextEditingController();
  String keyword = '';
  bool isAdding = false;

  @override
  void initState() {
    super.initState();

    scrollController.addListener(scrollListener);

    final projectCubit = context.read<ProjectCubit>();
    final theState = projectCubit.state;
    if (theState is LoadedState) {
      print(theState.projectJson.items);
      setState(() {
        projectList = theState.projectJson.items;
        maxPage = theState.projectJson.pages!;
      });
    }
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
      final projectCubit = context.read<ProjectCubit>();

      setState(() {
        isPaging = true;
      });

      await projectCubit.paging(page, keyword);

      setState(() {
        page += 1;
        isPaging = false;
      });
    }
  }

  Widget _loadedButEmpty() {
    return Expanded(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                width: 68,
                height: 68,
                child: Image.asset('assets/icons/icon_projects-empty.png')),
            const SizedBox(height: 12),
            const Text('프로젝트가 없습니다.',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff1c1c1c)))
          ]),
    );
  }

  Widget _projectRow(dynamic data) {
    bool otherIsEditing = isEditing != null && isEditing != data['projectId'];
    bool selfIsEditing = isEditing != null && isEditing == data['projectId'];

    return Container(
        padding: const EdgeInsets.symmetric(vertical: 14.5),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            !isMultipleMode
                ? IconButton(
                    onPressed: () {
                      if (!isAdding) {
                        if (openedList.contains(data['projectId'])) {
                          List<dynamic> tempArr = List.from(openedList);
                          tempArr.remove(data['projectId']);

                          setState(() {
                            openedList = [...tempArr];
                          });
                        } else {
                          setState(() {
                            openedList = [...openedList, data['projectId']];
                          });
                        }
                      }
                    },
                    icon: !openedList.contains(data['projectId'])
                        ? Image.asset('assets/icons/icon_arrow-downward.png',
                            scale: 4)
                        : Image.asset('assets/icons/icon_arrow-upward.png',
                            scale: 4))
                : GestureDetector(
                    onTap: () {
                      if (multipleIds.contains(data['projectId'])) {
                        List<dynamic> tempArr = List.from(multipleIds);
                        tempArr.remove(data['projectId']);

                        setState(() {
                          multipleIds = [...tempArr];
                        });
                      } else {
                        setState(() {
                          multipleIds = [...multipleIds, data['projectId']];
                        });
                      }
                    },
                    child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                            color: !multipleIds.contains(data['projectId'])
                                ? const Color(0xffececec)
                                : const Color(0xff000000),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(2))),
                        child: const Center(
                            child: Icon(Icons.check,
                                size: 15, color: Color(0xffffffff))))),
            const SizedBox(width: 6),
            Expanded(
                child: !selfIsEditing
                    ? GestureDetector(
                        onTap: () {},
                        child: Text(data['title'],
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: (!otherIsEditing && !isAdding)
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
                      enabled: (!otherIsEditing && !isAdding),
                      padding: EdgeInsets.zero,
                      color: const Color(0xff323232),
                      tooltip: "",
                      offset: const Offset(-10, 40),
                      itemBuilder: (BuildContext context) {
                        return [
                          PopupMenuItem(
                              onTap: () {
                                setState(() {
                                  isEditing = data['projectId'];
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
                                          title: "프로젝트를 삭제하시겠어요?",
                                          content: "삭제한 프로젝트는 복구할 수 없습니다.",
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
                                                        ProjectCubit
                                                            projectCubit =
                                                            context.read<
                                                                ProjectCubit>();

                                                        await projectCubit
                                                            .delete([
                                                          data['projectId']
                                                        ], () {
                                                          setState(() {
                                                            projectList = [];
                                                          });
                                                        });

                                                        BaseToast(
                                                                content:
                                                                    '프로젝트가 삭제되었습니다.',
                                                                context:
                                                                    context)
                                                            .showToast();

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

                      dynamic theProject = projectList.firstWhere(
                          (value) => value["projectId"] == data['projectId'],
                          orElse: () => null);

                      if (theProject != null) {
                        theProject['title'] = theTitle;
                      }

                      setState(() {
                        isEditing = null;
                      });

                      await ProjectService()
                          .patchProject(data["projectId"], theTitle);
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

  Widget _addRow() {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 14.5),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {},
                icon: Image.asset('assets/icons/icon_arrow-downward.png',
                    scale: 4)),
            const SizedBox(width: 6),
            Expanded(
                child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      color: Color(0xff000000),
                      width: 1,
                    ))),
                    child: TextField(
                        controller: titleEditController,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff1c1c1c)),
                        decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.only(bottom: 5),
                            border: InputBorder.none)))),
            const SizedBox(width: 6),
            OutlinedButton(
                onPressed: () async {
                  String theTitle = titleEditController.text;
                  final projectCubit = context.read<ProjectCubit>();

                  await projectCubit.create(theTitle, () {
                    setState(() {
                      projectList = [];
                      isAdding = false;
                    });
                    titleEditController.clear();
                  });

                  if (mounted) {
                    BaseToast(content: '새로운 프로젝트가 생성되었어요.', context: context)
                        .showToast();
                  }
                },
                style: OutlinedButton.styleFrom(
                    backgroundColor: const Color(0xff000000),
                    side:
                        const BorderSide(color: Color(0xff000000), width: 1.0),
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
    return BlocListener<ProjectCubit, ProjectState>(listener: (context, state) {
      if (state is LoadedState) {
        setState(() {
          maxPage = state.projectJson.pages!;
          projectList = [...projectList, ...state.projectJson.items];
        });
      }
    }, child: BlocBuilder<ProjectCubit, ProjectState>(builder: (_, state) {
      if (state is! LoadedState) {
        return Container();
      } else {
        if (state.projectJson.items.isEmpty) {
          return _loadedButEmpty();
        } else {
          return Expanded(
              child: NoScrollbarWrapper(
                  child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(children: [
                        TextField(
                            controller: searchController,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff000000)),
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () async {
                                      final projectCubit =
                                          context.read<ProjectCubit>();

                                      projectCubit.clearCubit();

                                      setState(() {
                                        keyword = searchController.text;
                                        page = 2;
                                      });

                                      projectCubit.paging(1, keyword);
                                    },
                                    icon: SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: Image.asset(
                                            'assets/icons/icon_search.png')),
                                    padding: const EdgeInsets.all(0)),
                                hintText: "검색어를 입력해 주세요",
                                hintStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff939393)),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 11.5, horizontal: 8),
                                filled: true,
                                fillColor: const Color(0xfff4f4f4),
                                border: InputBorder.none)),
                        const SizedBox(height: 24),
                        !isMultipleMode
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                    IconButton(
                                        onPressed: () {
                                          if (!isAdding) {
                                            setState(() {
                                              isAdding = true;
                                            });
                                          }
                                        },
                                        icon: Image.asset(
                                            'assets/icons/icon_project-add.png',
                                            scale: 4,
                                            color: isAdding
                                                ? const Color(0xffececec)
                                                : const Color(0xff000000))),
                                    GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isMultipleMode = true;
                                          });
                                        },
                                        child: const Text('편집',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff666666))))
                                  ])
                            : Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                    GestureDetector(
                                        onTap: () {
                                          if (projectList.length !=
                                              multipleIds.length) {
                                            setState(() {
                                              multipleIds = projectList
                                                  .map((project) =>
                                                      project['projectId'])
                                                  .toList();
                                            });
                                          } else {
                                            setState(() {
                                              multipleIds = [];
                                            });
                                          }
                                        },
                                        child: Container(
                                            width: 20,
                                            height: 20,
                                            decoration: BoxDecoration(
                                                color: projectList.length !=
                                                        multipleIds.length
                                                    ? const Color(0xffececec)
                                                    : const Color(0xff000000),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(2))),
                                            child: const Center(
                                                child: Icon(Icons.check,
                                                    size: 15,
                                                    color:
                                                        Color(0xffffffff))))),
                                    Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return BaseDialog(
                                                        title: "프로젝트를 삭제하시겠어요?",
                                                        content:
                                                            "삭제한 프로젝트는 복구할 수 없습니다.",
                                                        buttonsList: [
                                                          Expanded(
                                                              child:
                                                                  OutlinedButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      style: OutlinedButton.styleFrom(
                                                                          backgroundColor: const Color(
                                                                              0xffffffff),
                                                                          side: const BorderSide(
                                                                              color: Color(
                                                                                  0xffe7e7e7),
                                                                              width:
                                                                                  1.0),
                                                                          shape: RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(
                                                                                  4.0)),
                                                                          padding: const EdgeInsets
                                                                              .symmetric(
                                                                              vertical:
                                                                                  13)),
                                                                      child: const Text(
                                                                          "취소",
                                                                          style: TextStyle(
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.w600,
                                                                              color: Color(0xff000000))))),
                                                          const SizedBox(
                                                              width: 9),
                                                          Expanded(
                                                              child:
                                                                  OutlinedButton(
                                                                      onPressed:
                                                                          () async {
                                                                        if (mounted) {
                                                                          final projectCubit =
                                                                              context.read<ProjectCubit>();

                                                                          await projectCubit.delete(
                                                                              multipleIds,
                                                                              () {
                                                                            setState(() {
                                                                              projectList = [];
                                                                            });
                                                                          });

                                                                          setState(
                                                                              () {
                                                                            isMultipleMode =
                                                                                false;
                                                                            multipleIds =
                                                                                [];
                                                                          });

                                                                          BaseToast(content: '프로젝트가 삭제되었습니다.', context: context)
                                                                              .showToast();

                                                                          Navigator.pop(
                                                                              context);
                                                                        }
                                                                      },
                                                                      style: OutlinedButton.styleFrom(
                                                                          backgroundColor: const Color(
                                                                              0xff000000),
                                                                          side: const BorderSide(
                                                                              color: Color(
                                                                                  0xff000000),
                                                                              width:
                                                                                  1.0),
                                                                          shape: RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(
                                                                                  4.0)),
                                                                          padding: const EdgeInsets
                                                                              .symmetric(
                                                                              vertical:
                                                                                  13)),
                                                                      child: const Text(
                                                                          "확인",
                                                                          style: TextStyle(
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.w600,
                                                                              color: Color(0xffffffff))))),
                                                        ]);
                                                  });
                                            },
                                            icon: Image.asset(
                                                'assets/icons/icon_thread-popup-delete.png',
                                                scale: 4,
                                                color:
                                                    const Color(0xff000000))),
                                        const SizedBox(width: 20),
                                        GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                isMultipleMode = false;
                                                multipleIds = [];
                                              });
                                            },
                                            child: const Text('취소',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xff666666))))
                                      ],
                                    )
                                  ]),
                        const SizedBox(height: 23),
                        projectList.isNotEmpty
                            ? Column(children: [
                                Column(
                                    children: isAdding
                                        ? [
                                            _addRow(),
                                            ...projectList
                                                .map<Widget>((project) {
                                              return _projectRow(project);
                                            })
                                          ]
                                        : projectList.map<Widget>((project) {
                                            return _projectRow(project);
                                          }).toList()),
                                Container(
                                    height: 1,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 24),
                                    decoration: const BoxDecoration(
                                        color: Color(0xfff4f4f5)))
                              ])
                            : Container()
                      ]))));
        }
      }
    }));
  }
}
