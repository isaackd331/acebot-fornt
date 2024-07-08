/// Thread & Projects Page
library;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:acebot_front/presentation/widget/history/threadWidget.dart';
import 'package:acebot_front/presentation/widget/history/projectWidget.dart';
import 'package:acebot_front/presentation/widget/common/baseAppBar.dart';

import 'package:acebot_front/bloc/thread/threadCubit.dart';
import 'package:acebot_front/bloc/project/projectCubit.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  String tabMode = 'thread';

  @override
  void initState() {
    super.initState();

    /**
     * Initialize Cubit
     */
    final threadCubit = context.read<ThreadCubit>();
    threadCubit.init();

    final projectCubit = context.read<ProjectCubit>();
    projectCubit.init();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _bodyWidget() {
    return Center(
        child: Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Column(children: [
              Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    tabButton('THREADS', 'thread'),
                    tabButton('PROJECTS', 'project')
                  ]),
              const SizedBox(height: 20),
              tabMode == 'thread' ? const ThreadWidget() : Container(),
              tabMode == 'project' ? const ProjectWidget() : Container()
            ])));
  }

  /// 상단 Tab 버튼 making widget
  Widget tabButton(String title, String activeCondition) {
    return Expanded(
        child: GestureDetector(
            onTap: () {
              if (tabMode != activeCondition) {
                setState(() {
                  tabMode = activeCondition;
                });

                if (activeCondition == 'thread') {
                  final threadCubit = context.read<ThreadCubit>();
                  threadCubit.init();
                } else if (activeCondition == 'project') {
                  final projectCubit = context.read<ProjectCubit>();
                  projectCubit.init();
                }
              }
            },
            child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: tabMode == activeCondition
                                ? const Color(0xff000000)
                                : const Color(0xffcccccc),
                            width: 2))),
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: tabMode == activeCondition
                          ? FontWeight.w700
                          : FontWeight.w500,
                      color: tabMode == activeCondition
                          ? const Color(0xff000000)
                          : const Color(0xffcccccc)),
                  textAlign: TextAlign.center,
                ))));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: BaseAppBar(
                title: '',
                actions: const [],
                leading: IconButton(
                    onPressed: () {
                      context.go('/home');
                    },
                    icon: const Icon(Icons.arrow_back_ios_new_outlined),
                    iconSize: 16,
                    padding: const EdgeInsets.all(0))),
            body: _bodyWidget()));
  }
}
