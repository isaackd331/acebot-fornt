import 'package:flutter/material.dart';

import 'package:acebot_front/presentation/widget/common/baseAppBar.dart';

class MyDataBottomSheet extends StatefulWidget {
  final Function setUploadedFiles;

  const MyDataBottomSheet({super.key, required this.setUploadedFiles});

  @override
  _myDataBottomSheetState createState() => _myDataBottomSheetState();
}

class _myDataBottomSheetState extends State<MyDataBottomSheet> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: const Color(0xffffffff),
            appBar: BaseAppBar(
                title: const Text("My Data",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff000000))),
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.clear, color: Color(0xff000000)),
                      iconSize: 24),
                ],
                leading: Container()),
            body: const Column(children: [])));
  }
}
