// 답변 별 템플릿 Wrapper

import 'package:flutter/material.dart';

import 'package:acebot_front/presentation/widget/history/template/chitchatTemplate.dart';
import 'package:acebot_front/presentation/widget/history/template/weatherTemplate.dart';
import 'package:acebot_front/presentation/widget/history/template/placeTemplate.dart';

import 'package:acebot_front/api/threadService.dart';

class ThreadQnaBottomsheet extends StatefulWidget {
  final int threadId;

  const ThreadQnaBottomsheet({
    super.key,
    required this.threadId,
  });

  @override
  _ThreadQnaBottomsheetState createState() => _ThreadQnaBottomsheetState();
}

class _ThreadQnaBottomsheetState extends State<ThreadQnaBottomsheet> {
  String question = "";
  String templateName = "";
  String mainParagraph = "";
  List<dynamic> subParagraph = [];

  @override
  void initState() {
    super.initState();

    ThreadService().getThread(widget.threadId).then((res) {
      setState(() {
        question = res.data['items'][0]["question"];
        templateName = res.data['items'][0]["templateName"];
        mainParagraph = res.data['items'][0]["mainParagraph"];
        subParagraph = res.data['items'][0]["subParagraph"];
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _templateSelector() {
    switch (templateName) {
      case 'chitchat':
        return ChitChatTemplate(
          mainParagraph: mainParagraph,
          subParagraph: subParagraph,
          templateName: templateName,
        );

      case 'cur_weather':
        return WeatherTemplate(
          mainParagraph: mainParagraph,
          subParagraph: subParagraph,
          templateName: templateName,
        );

      case 'weekly_weather':
        return WeatherTemplate(
          mainParagraph: mainParagraph,
          subParagraph: subParagraph,
          templateName: templateName,
        );

      case 'place_search':
        return PlaceTemplate(
          mainParagraph: mainParagraph,
          subParagraph: subParagraph,
          templateName: templateName,
        );

      default:
        return Container();
    }
  }

  Widget _header() {
    return Container(
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.clear, color: Color(0xff000000)),
              iconSize: 24),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(color: Color(0xffffffff)),
        child: Column(mainAxisSize: MainAxisSize.max, children: [
          _header(),
          const SizedBox(height: 20),
          Row(children: [
            Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xff666666)),
                // TODO : 추후 유저 아이콘으로 변경 필요
                child: const Text(
                  'T',
                  style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: Color(0xffffffff)),
                  textAlign: TextAlign.center,
                )),
            const SizedBox(width: 7),
            const Text('You',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff111111)))
          ]),
          const SizedBox(height: 14),
          Row(
            children: [
              Flexible(
                  child: Text(
                question,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff000000)),
              ))
            ],
          ),
          const SizedBox(height: 60),
          Row(children: [
            Image.asset('assets/icons/icon_answer-start-symbol.png', scale: 3)
          ]),
          const SizedBox(height: 20),
          Row(children: [
            Image.asset('assets/icons/icon_exaone-logo.png', scale: 3),
            const SizedBox(width: 4),
            const Text("ACEBOT",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff111111)))
          ]),
          _templateSelector()
        ]));
  }
}
