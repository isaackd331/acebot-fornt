import 'package:flutter/material.dart';

import 'package:acebot_front/presentation/widget/common/baseAppBar.dart';
import 'package:acebot_front/presentation/widget/common/baseOutlineButton.dart';

import 'package:acebot_front/api/fileService.dart';

class MyDataBottomSheet extends StatefulWidget {
  final Function setUploadedFiles;

  const MyDataBottomSheet({super.key, required this.setUploadedFiles});

  @override
  _myDataBottomSheetState createState() => _myDataBottomSheetState();
}

class _myDataBottomSheetState extends State<MyDataBottomSheet> {
  List<dynamic> files = [];
  List<dynamic> selected = [];

  @override
  void initState() {
    super.initState();

    getFiles();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getFiles() async {
    final res = await FileService().getFiles();

    setState(() {
      files = res.data['content'];
    });
  }

  Widget _extensionImage(String extension) {
    switch (extension) {
      case 'pptx':
        return Image.asset('assets/icons/icon_pptx.png', scale: 4);
      default:
        return Image.asset('assets/icons/icon_etc.png', scale: 4);
    }
  }

  Widget _fileRow(dynamic file) {
    String ellipsizeMiddle(String text, int maxLength) {
      if (text.length <= maxLength) {
        return text;
      }
      int ellipsisLength = 3;
      int keepLength = (maxLength - ellipsisLength) ~/ 2;

      return '${text.substring(0, keepLength)}...${text.substring(text.length - keepLength)}';
    }

    return GestureDetector(
        onTap: () {
          List<dynamic> tempList = List.from(selected);
          if (selected.contains(file)) {
            tempList.remove(file);
          } else {
            tempList.add(file);
          }

          setState(() {
            selected = tempList;
          });
        },
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(mainAxisSize: MainAxisSize.max, children: [
              Image.asset(
                  selected.contains(file)
                      ? 'assets/icons/icon_square-check-active.png'
                      : 'assets/icons/icon_square-check-inactive.png',
                  scale: 4),
              const SizedBox(width: 16),
              _extensionImage('etc'),
              const SizedBox(width: 8),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(file['permission_type'],
                    style: const TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff000000))),
                const SizedBox(height: 6),
                Text(ellipsizeMiddle(file['file_name'], 30),
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff000000)))
              ])
            ])));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
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
                          icon:
                              const Icon(Icons.clear, color: Color(0xff000000)),
                          iconSize: 24),
                    ],
                    leading: Container()),
                body: Column(children: [
                  Expanded(
                      child: SingleChildScrollView(
                          child: Column(
                              children: files
                                  .map((item) => _fileRow(item))
                                  .toList()))),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
                      child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            BaseOutlineButton(
                                onPressedFunc: () {
                                  if (selected.isNotEmpty) {
                                    widget.setUploadedFiles(selected);

                                    Navigator.pop(context);
                                  }
                                },
                                text: '확인',
                                fontSize: 16,
                                textColor: const Color(0xffffffff),
                                backgroundColor: selected.isNotEmpty
                                    ? const Color(0xff000000)
                                    : const Color(0xffb3b3b3),
                                borderColor: selected.isNotEmpty
                                    ? const Color(0xff000000)
                                    : const Color(0xffb3b3b3))
                          ]))
                ]))));
  }
}
