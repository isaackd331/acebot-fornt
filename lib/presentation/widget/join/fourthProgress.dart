import 'package:flutter/material.dart';

import 'package:acebot_front/presentation/widget/common/baseDropdown.dart';

import 'package:acebot_front/api/utilService.dart';

class FourthProgress extends StatefulWidget {
  final Function setProgress;
  final Function setAbleToProgress;
  final Function setUserJob;
  final Function setUserTasks;
  final String userJob;
  final List<dynamic> userTasks;

  const FourthProgress({
    super.key,
    required this.setProgress,
    required this.setAbleToProgress,
    required this.setUserJob,
    required this.setUserTasks,
    required this.userJob,
    required this.userTasks,
  });

  @override
  _FourthProgressState createState() => _FourthProgressState();
}

class _FourthProgressState extends State<FourthProgress> {
  List<dynamic> jobList = [];
  List<dynamic> tasksList = [];
  dynamic userJob = "직군을 선택해 주세요";

  @override
  void initState() {
    super.initState();

    UtilService().getWorksRolesList().then((res) => {
          setState(() {
            jobList = ["직군을 선택해 주세요", ...res.data["role"]];
            tasksList = res.data["work"];
          })
        });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _listView(String title, Widget child) {
    bool ableToProgress =
        widget.userJob.isNotEmpty && widget.userTasks.isNotEmpty;

    if (ableToProgress) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.setAbleToProgress(true);
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.setAbleToProgress(false);
      });
    }

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
            widget.userTasks.contains(value)
                ? widget.userTasks.remove(value)
                : widget.userTasks.add(value);
          });
        },
        child: Container(
            height: 32,
            padding: const EdgeInsets.fromLTRB(6, 6, 12, 6),
            decoration: BoxDecoration(
              color: const Color(0xffffffff),
              border: Border.all(
                  color: widget.userTasks.contains(value)
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
                          color: widget.userTasks.contains(value)
                              ? const Color(0xff000000)
                              : const Color(0xffebebeb))),
                  const SizedBox(width: 7),
                  Text(value,
                      style: TextStyle(
                          fontSize: 14,
                          color: const Color(0xff1a1a1a),
                          fontWeight: widget.userTasks.contains(value)
                              ? FontWeight.w700
                              : FontWeight.w500))
                ])));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 30.0),
        child: Column(children: [
          const Row(children: [
            Expanded(
                child: Text("직군과 업무를\n선택해 주세요",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff000000))))
          ]),
          const SizedBox(height: 38),
          Row(children: [
            SizedBox(
                width: 40,
                height: 10,
                child: Image.asset('assets/images/acebot_logo.png')),
          ]),
          const SizedBox(height: 83.0),
          Column(children: [
            jobList.isNotEmpty
                ? _listView(
                    '직군',
                    BaseDropdown(
                        onChanged: (value) {
                          widget.setUserJob(value);

                          setState(() {
                            userJob = value;
                          });
                        },
                        options: jobList,
                        selected: userJob))
                : Container(),
            widget.userJob.isNotEmpty
                ? _listView(
                    '업무',
                    Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.start,
                        children: tasksList
                            .where((task) => task != null)
                            .map((task) => _taskCheckbox(task))
                            .toList()))
                : Container()
          ])
        ]));
  }
}
