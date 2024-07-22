import 'package:flutter/material.dart';

import 'package:acebot_front/presentation/widget/common/baseAppBar.dart';
import 'package:acebot_front/presentation/widget/common/baseOutlineButton.dart';
import 'package:acebot_front/presentation/widget/common/baseDialog.dart';
import 'package:acebot_front/presentation/widget/common/baseToast.dart';

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
  List<dynamic> showingFiles = [];
  String tabMode = '';
  TextEditingController keywordController = TextEditingController();
  String curText = '';
  String keyword = '';
  bool deleteMode = false;

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
      showingFiles = res.data['content'];
    });
  }

  // filter
  void _filterByTab(String extensions) {
    setState(() {
      selected = [];
    });

    switch (extensions) {
      case '':
        {
          List<dynamic> tempList = List.from(files);
          if (keyword.isNotEmpty) {
            tempList = tempList.where((item) {
              return item['file_name'].contains(keyword);
            }).toList();
          }

          setState(() {
            showingFiles = tempList;
          });
        }
      case "ppt":
        {
          List<dynamic> tempList = List.from(files);
          tempList = tempList.where((item) {
            return item['extension'] == 'ppt' || item['extension'] == 'pptx';
          }).toList();
          if (keyword.isNotEmpty) {
            tempList = tempList.where((item) {
              return item['file_name'].contains(keyword);
            }).toList();
          }

          setState(() {
            showingFiles = tempList;
          });
        }
      case "pdf":
        {
          List<dynamic> tempList = List.from(files);
          tempList = tempList.where((item) {
            return item['extension'] == 'pdf';
          }).toList();
          if (keyword.isNotEmpty) {
            tempList = tempList.where((item) {
              return item['file_name'].contains(keyword);
            }).toList();
          }

          setState(() {
            showingFiles = tempList;
          });
        }
      case "excel/csv":
        {
          List<dynamic> tempList = List.from(files);
          tempList = tempList.where((item) {
            return item['extension'] == 'csv' || item['extension'] == 'xlsx';
          }).toList();
          if (keyword.isNotEmpty) {
            tempList = tempList.where((item) {
              return item['file_name'].contains(keyword);
            }).toList();
          }

          setState(() {
            showingFiles = tempList;
          });
        }
    }
  }

  /// 상단 Tab 버튼 making widget
  Widget _tabButton(String title, String activeCondition) {
    return Expanded(
        child: GestureDetector(
            onTap: () {
              if (tabMode != activeCondition) {
                setState(() {
                  tabMode = activeCondition;
                  selected = [];
                });

                _filterByTab(activeCondition);
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
                  softWrap: false,
                ))));
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
            child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(children: [
                    Image.asset(
                        selected.contains(file)
                            ? 'assets/icons/icon_square-check-active.png'
                            : 'assets/icons/icon_square-check-inactive.png',
                        scale: 4),
                    const SizedBox(width: 16),
                    _extensionImage('etc'),
                    const SizedBox(width: 8),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(file['permission_type'],
                              style: const TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff000000))),
                          const SizedBox(height: 6),
                          Text(ellipsizeMiddle(file['file_name'], 24),
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff000000)))
                        ])
                  ]),
                  !deleteMode
                      ? Container()
                      : file['permission_type'] == 'private'
                          ? IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return BaseDialog(
                                          title: "My Data를 삭제하시겠어요?",
                                          content: "삭제한 My Data는 복구할 수 없습니다.",
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
                                                        await FileService()
                                                            .deleteFiles(
                                                                [file]);

                                                        getFiles();

                                                        setState(() {
                                                          selected = [];
                                                          tabMode = "";
                                                          curText = "";
                                                          deleteMode = false;
                                                          keyword = "";
                                                        });
                                                        keywordController
                                                            .clear();

                                                        BaseToast(
                                                                content:
                                                                    'My Data가 삭제되었습니다.',
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
                              icon: Image.asset(
                                  'assets/icons/icon_thread-popup-delete.png',
                                  scale: 4,
                                  color: const Color(0xff000000)))
                          : Container()
                ])));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.95,
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
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _tabButton('ALL', ''),
                            _tabButton('PPT', 'ppt'),
                            _tabButton('PDF', 'pdf'),
                            _tabButton('EXCEL/CSV', 'excel/csv'),
                          ])),
                  const SizedBox(height: 20),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            curText = value;
                          });
                        },
                        controller: keywordController,
                        style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff000000)),
                        decoration: InputDecoration(
                            suffixIcon:
                                Row(mainAxisSize: MainAxisSize.min, children: [
                              curText.isNotEmpty
                                  ? IconButton(
                                      onPressed: () async {
                                        keywordController.clear();
                                        setState(() {
                                          curText = "";
                                        });
                                      },
                                      icon: Image.asset(
                                          'assets/icons/icon_clear.png',
                                          scale: 4),
                                      padding: const EdgeInsets.all(0))
                                  : Container(),
                              IconButton(
                                  onPressed: () async {
                                    setState(() {
                                      keyword = keywordController.text;
                                    });

                                    _filterByTab(tabMode);
                                  },
                                  icon: Image.asset(
                                      'assets/icons/icon_search.png',
                                      scale: 4),
                                  padding: const EdgeInsets.all(0))
                            ]),
                            hintText: 'My Data를 검색해 보세요',
                            hintStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff939393)),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 11.5),
                            filled: true,
                            fillColor: const Color(0xfff4f4f4),
                            border: InputBorder.none),
                      )),
                  Container(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            !deleteMode
                                ? Container()
                                : IconButton(
                                    onPressed: () {
                                      if (selected.length !=
                                          showingFiles.length) {
                                        List<dynamic> tempArr =
                                            List.from(showingFiles);

                                        setState(() {
                                          selected = tempArr;
                                        });
                                      } else {
                                        setState(() {
                                          selected = [];
                                        });
                                      }
                                    },
                                    icon: Image.asset(
                                        (selected.length ==
                                                    showingFiles.length &&
                                                showingFiles.isNotEmpty)
                                            ? 'assets/icons/icon_square-check-active.png'
                                            : 'assets/icons/icon_square-check-inactive.png',
                                        scale: 3),
                                    padding: EdgeInsets.zero),
                            Row(children: [
                              !deleteMode
                                  ? Container()
                                  : IconButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return BaseDialog(
                                                  title: "My Data를 삭제하시겠어요?",
                                                  content:
                                                      "삭제한 My Data는 복구할 수 없습니다.",
                                                  buttonsList: [
                                                    Expanded(
                                                        child: OutlinedButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            style: OutlinedButton.styleFrom(
                                                                backgroundColor:
                                                                    const Color(
                                                                        0xffffffff),
                                                                side: const BorderSide(
                                                                    color: Color(
                                                                        0xffe7e7e7),
                                                                    width: 1.0),
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            4.0)),
                                                                padding: const EdgeInsets.symmetric(
                                                                    vertical:
                                                                        13)),
                                                            child: const Text(
                                                                "취소",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Color(0xff000000))))),
                                                    const SizedBox(width: 9),
                                                    Expanded(
                                                        child: OutlinedButton(
                                                            onPressed:
                                                                () async {
                                                              if (mounted) {
                                                                await FileService()
                                                                    .deleteFiles(
                                                                        selected);

                                                                getFiles();

                                                                setState(() {
                                                                  selected = [];
                                                                  tabMode = "";
                                                                  curText = "";
                                                                  deleteMode =
                                                                      false;
                                                                  keyword = "";
                                                                });
                                                                keywordController
                                                                    .clear();

                                                                BaseToast(
                                                                        content:
                                                                            'My Data가 삭제되었습니다.',
                                                                        context:
                                                                            context)
                                                                    .showToast();

                                                                Navigator.pop(
                                                                    context);
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
                                                                    vertical:
                                                                        13)),
                                                            child: const Text(
                                                                "확인",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Color(0xffffffff))))),
                                                  ]);
                                            });
                                      },
                                      icon: Image.asset(
                                          'assets/icons/icon_thread-popup-delete.png',
                                          scale: 4,
                                          color: const Color(0xff000000))),
                              TextButton(
                                  onPressed: () {
                                    if (!deleteMode) {
                                      setState(() {
                                        deleteMode = true;
                                      });
                                    } else {
                                      setState(() {
                                        deleteMode = false;
                                      });
                                    }
                                  },
                                  child: Text(!deleteMode ? '편집' : '취소',
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff666666))))
                            ]),
                          ])),
                  Expanded(
                      child: SingleChildScrollView(
                          child: Column(
                              children: showingFiles
                                  .map((item) => _fileRow(item))
                                  .toList()))),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
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
