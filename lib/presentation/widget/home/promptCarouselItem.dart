/**
 * 프롬프트 캐로셀 아이템
 */

import 'package:flutter/material.dart';

class PromptCarouselItem extends StatelessWidget {
  final String type;
  final String content;
  final bool isActive;

  const PromptCarouselItem(
      {super.key,
      required this.type,
      required this.content,
      required this.isActive});

  String capitalize(String str) {
    if (str == null || str.isEmpty) {
      return str;
    } else {
      return str[0].toUpperCase() + str.substring(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200,
        height: 65,
        decoration: const BoxDecoration(color: Color(0xffffffff)),
        child: Column(children: [
          Row(children: [
            isActive
                ? SizedBox(
                    width: 6,
                    height: 6,
                    child: Image.asset('assets/icons/icons_prompt_active.png'))
                : Container(),
            const SizedBox(width: 1),
            type == "beta"
                ? SizedBox(
                    width: 14,
                    height: 14,
                    child: Image.asset('assets/icons/icons_prompt_beta.png'))
                : Container(),
            type == "prompt"
                ? SizedBox(
                    width: 14,
                    height: 14,
                    child: Image.asset('assets/icons/icons_prompt_prompt.png'))
                : Container(),
            Text(capitalize(type),
                style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff808080)))
          ]),
          const SizedBox(height: 4),
          Row(children: [
            Expanded(
                child: Text(
              content,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xff808080),
              ),
              textAlign: TextAlign.start,
            ))
          ]),
          Expanded(
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    width: 20,
                    height: 1,
                    decoration: const BoxDecoration(color: Color(0xff000000)),
                  )))
        ]));
  }
}
