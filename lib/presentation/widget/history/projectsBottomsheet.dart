import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:acebot_front/presentation/widget/common/baseOutlineButton.dart';

import 'package:acebot_front/bloc/project/projectCubit.dart';
import 'package:acebot_front/bloc/project/projectState.dart';

class ProjectsBottomsheet extends StatefulWidget {
  final int threadId;

  const ProjectsBottomsheet({super.key, required this.threadId});

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
                onPressed: () {},
                icon:
                    Image.asset('assets/icons/icon_project-add.png', scale: 4),
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
          if (selectedProject != data['projectId']) {
            setState(() {
              selectedProject = data['projectId'];
            });
          } else {
            setState(() {
              selectedProject = null;
            });
          }
        },
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            decoration: BoxDecoration(
                color: selectedProject != data['projectId']
                    ? const Color(0xffffffff)
                    : const Color(0xfff4f4f4)),
            child: Row(children: [
              Image.asset('assets/icons/icon_project.png', scale: 4),
              const SizedBox(width: 6),
              Expanded(
                  child: Text(data['title'],
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff1c1c1c))))
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
                              child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: state.projectJson.items
                                      .map<Widget>((project) {
                                    return _projectRow(project);
                                  }).toList())),
                      Container(
                          padding: const EdgeInsets.fromLTRB(20, 26, 20, 0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      BaseOutlineButton(
                                          onPressedFunc: () {
                                            if (selectedProject != null) {}
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
