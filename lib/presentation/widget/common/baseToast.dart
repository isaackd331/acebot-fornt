/**
 * 베이스 토스트 메세지
 * @params String content : 토스트에 띄울 메세지 내용
 * @params BuildContext context : 호출한 위젯의 context
 */

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BaseToast {
  final String content;
  final BuildContext context;

  BaseToast({
    required this.content,
    required this.context 
  });

  /**
   * Toast
   */
  void showToast() {
    FToast fToast = FToast().init(context);

    Widget toast = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(120),
              color: const Color(0xff1f1f1f),
            ),
            child: Text(
              content.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xfff5f5f5)
              )
            )
          )
        )
      ]
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 3)
    );
  }
}