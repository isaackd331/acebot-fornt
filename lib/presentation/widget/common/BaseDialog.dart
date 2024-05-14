/**
 * 커스텀 AlertDialog
 * title: 제목
 * actions: 제목 하단 내용
 * buttonsList: AlertDialog 하단 버튼(child, textColor, onPressed, backgroundColor 등 요구)
 */

import 'package:flutter/material.dart';

class BaseDialog extends StatelessWidget {
  String title;
  String content;
  List<Widget> buttonsList;

  BaseDialog(
      {super.key,
      required this.title,
      required this.content,
      required this.buttonsList});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Container(
            width: 335.0,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                color: Color(0xffffffff)),
            padding: const EdgeInsets.fromLTRB(20.0, 46.0, 20.0, 20.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // TITLE
                  Row(children: <Widget>[
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                            color: Color(0xff000000),
                            fontWeight: FontWeight.w700,
                            fontSize: 16.0),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ]),

                  // CONTENT
                  Container(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 30.0),
                    child: Text(
                      content,
                      style: const TextStyle(
                          color: Color(0xff000000),
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  // ACTIONS
                  Row(
                    children: buttonsList,
                    mainAxisAlignment: MainAxisAlignment.center,
                  )
                ])));
  }
}
