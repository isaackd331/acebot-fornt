/// Thread & Projects Page
library;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:acebot_front/presentation/widget/history/threadWidget.dart';
import 'package:acebot_front/presentation/widget/common/baseAppBar.dart';
import 'package:acebot_front/presentation/widget/common/baseBody.dart';

import 'package:acebot_front/bloc/thread/threadState.dart';
import 'package:acebot_front/bloc/thread/threadCubit.dart';
import 'package:acebot_front/bloc/project/projectState.dart';
import 'package:acebot_front/bloc/project/projectCubit.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  String tabMode = 'thread';
  TextEditingController searchController = TextEditingController();
  String searchText = '';

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
    return MultiBlocListener(
        listeners: [
          BlocListener<ThreadCubit, ThreadState>(
            listener: (context, state) {},
          )
        ],
        child: Center(
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
                  TextField(
                      onChanged: (value) {
                        setState(() {
                          searchText = value;
                        });
                      },
                      controller: searchController,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff000000)),
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {},
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
                  tabMode == 'thread' ? const ThreadWidget() : Container()
                ]))));
  }

  /// 상단 Tab 버튼 making widget
  Widget tabButton(String title, String activeCondition) {
    return Expanded(
        child: GestureDetector(
            onTap: () {
              if (tabMode != activeCondition) {
                searchController.clear();
                setState(() {
                  tabMode = activeCondition;
                  searchText = '';
                });
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
                    iconSize: 8,
                    padding: const EdgeInsets.all(0))),
            body: BaseBody(child: _bodyWidget())));
  }
}
