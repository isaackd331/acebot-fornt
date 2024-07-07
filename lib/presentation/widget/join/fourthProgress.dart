import 'package:flutter/material.dart';

import 'package:acebot_front/presentation/widget/common/baseDropdown.dart';

import 'package:acebot_front/api/utilService.dart';

class FourthProgress extends StatefulWidget {
  final Function setProgress;
  final Function setAbleToProgress;
  final Function setUserJob;
  final Function setUserTasks;
  final String userJob;

  const FourthProgress({
    super.key,
    required this.setProgress,
    required this.setAbleToProgress,
    required this.setUserJob,
    required this.setUserTasks,
    required this.userJob,
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
          ])
        ]));
  }
}
