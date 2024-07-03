import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:acebot_front/presentation/widget/common/baseOutlineButton.dart';
import 'package:acebot_front/presentation/widget/common/baseToast.dart';

import 'package:acebot_front/api/threadService.dart';

import 'package:acebot_front/bloc/project/projectCubit.dart';
import 'package:acebot_front/bloc/project/projectState.dart';

class ProjectsBottomsheet extends StatefulWidget {
  final List<dynamic> threadIds;
  final Function? funcForMultiple;

  const ProjectsBottomsheet(
      {super.key, required this.threadIds, this.funcForMultiple});

  @override
  _ProjectsBottomsheetState createState() => _ProjectsBottomsheetState();
}

class _ProjectsBottomsheetState extends State<ProjectsBottomsheet> {
  bool isEditing = false;
  TextEditingController titleEditController = TextEditingController();
  int? selectedProject;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _header() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  if (!isEditing) {
                    setState(() {
                      isEditing = true;
                      selectedProject = null;
                    });
                  }
                },
                icon: Image.asset('assets/icons/icon_project-add.png',
                    scale: 4,
                    color: !isEditing
                        ? const Color(0xff000000)
                        : const Color(0xffb3b3b3)),
              ),
              const Expanded(
                  child: Text('프로젝트 선택',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff000000)),
                      textAlign: TextAlign.center)),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.clear, color: Color(0xff000000)),
                  iconSize: 24),
            ]));
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
                    color: Color(0xff1c1c1c))),
            const Text('새로운 프로젝트를 추가해주세요.',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff1c1c1c)))
          ]),
    );
  }

  Widget _projectRow(dynamic data) {
    return GestureDetector(
        onTap: () {
          if (!isEditing) {
            if (selectedProject != data['projectId']) {
              setState(() {
                selectedProject = data['projectId'];
              });
            } else {
              setState(() {
                selectedProject = null;
              });
            }
          }
        },
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            decoration: BoxDecoration(
                color: selectedProject != data['projectId']
                    ? const Color(0xffffffff)
                    : const Color(0xfff4f4f4)),
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Image.asset('assets/icons/icon_project.png',
                  scale: 4,
                  color: !isEditing
                      ? const Color(0xff000000)
                      : const Color(0xffb3b3b3)),
              const SizedBox(width: 6),
              Expanded(
                  child: Text(data['title'],
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: !isEditing
                              ? const Color(0xff1c1c1c)
                              : const Color(0xffb3b3b3))))
            ])));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProjectCubit, ProjectState>(
        listener: (context, state) {},
        child: BlocBuilder<ProjectCubit, ProjectState>(builder: (_, state) {
          if (state is LoadedState) {
            return Container(
                height: MediaQuery.of(context).size.height * 0.63,
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: const BoxDecoration(color: Color(0xffffffff)),
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _header(),
                      const SizedBox(height: 20),
                      state.projectJson.items.isEmpty
                          ? _loadedButEmpty()
                          : Expanded(
                              child: SingleChildScrollView(
                                  child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                  isEditing
                                      ? Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 20),
                                          decoration: const BoxDecoration(
                                            color: Color(0xffffffff),
                                          ),
                                          child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                    'assets/icons/icon_project.png',
                                                    scale: 4,
                                                    color: !isEditing
                                                        ? const Color(
                                                            0xff000000)
                                                        : const Color(
                                                            0xffb3b3b3)),
                                                const SizedBox(width: 6),
                                                Expanded(
                                                    child: Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                                border: Border(
                                                                    bottom:
                                                                        BorderSide(
                                                          color:
                                                              Color(0xff000000),
                                                          width: 1,
                                                        ))),
                                                        child: TextField(
                                                            controller:
                                                                titleEditController,
                                                            style: const TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Color(
                                                                    0xff1c1c1c)),
                                                            decoration: const InputDecoration(
                                                                isDense: true,
                                                                contentPadding:
                                                                    EdgeInsets.only(
                                                                        bottom:
                                                                            5),
                                                                border:
                                                                    InputBorder
                                                                        .none)))),
                                                isEditing
                                                    ? Container(
                                                        margin: const EdgeInsets.only(
                                                            left: 6),
                                                        child: OutlinedButton(
                                                            onPressed:
                                                                () async {
                                                              String theTitle =
                                                                  titleEditController
                                                                      .text;

                                                              ProjectCubit
                                                                  projectCubit =
                                                                  BlocProvider.of<
                                                                          ProjectCubit>(
                                                                      context);

                                                              await projectCubit
                                                                  .create(
                                                                      theTitle);

                                                              titleEditController
                                                                  .clear();
                                                              setState(() {
                                                                isEditing =
                                                                    false;
                                                              });

                                                              if (mounted) {
                                                                BaseToast(
                                                                        content:
                                                                            '새로운 프로젝트가 생성되었어요.',
                                                                        context:
                                                                            context)
                                                                    .showToast();
                                                              }
                                                            },
                                                            style: OutlinedButton.styleFrom(
                                                                backgroundColor:
                                                                    const Color(
                                                                        0xff000000),
                                                                side: const BorderSide(
                                                                    color: Color(
                                                                        0xff000000),
                                                                    width: 1.0),
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            4.0)),
                                                                padding: const EdgeInsets.symmetric(
                                                                    horizontal:
                                                                        12,
                                                                    vertical:
                                                                        6)),
                                                            child: const Text("완료",
                                                                style: TextStyle(
                                                                    fontSize: 14,
                                                                    fontWeight: FontWeight.w600,
                                                                    color: Color(0xffffffff)))))
                                                    : Container()
                                              ]))
                                      : Container(),
                                  ...state.projectJson.items
                                      .map<Widget>((project) {
                                    return _projectRow(project);
                                  })
                                ]))),
                      Container(
                          padding: const EdgeInsets.fromLTRB(20, 26, 20, 0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      BaseOutlineButton(
                                          onPressedFunc: () async {
                                            if (selectedProject != null &&
                                                mounted) {
                                              await ThreadService().patchThread(
                                                  widget.threadIds,
                                                  null,
                                                  selectedProject);

                                              BaseToast(
                                                      content:
                                                          '스레드를 프로젝트로 이동했어요.',
                                                      context: context)
                                                  .showToast();

                                              if (widget.funcForMultiple !=
                                                  null) {
                                                widget.funcForMultiple!();
                                              }

                                              Navigator.pop(context);
                                            }
                                          },
                                          text: '확인',
                                          fontSize: 16,
                                          textColor: const Color(0xffffffff),
                                          backgroundColor:
                                              selectedProject != null
                                                  ? const Color(0xff000000)
                                                  : const Color(0xffb3b3b3),
                                          borderColor: selectedProject != null
                                              ? const Color(0xff000000)
                                              : const Color(0xffb3b3b3))
                                    ]),
                              ]))
                    ]));
          } else {
            return Container();
          }
        }));
  }
}
