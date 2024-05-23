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
                    child: Image.asset('assets/icons/icon_prompt_active.png'))
                : Container(),
            const SizedBox(width: 2),
            type == "beta"
                ? SizedBox(
                    width: 14,
                    height: 14,
                    child: Image.asset('assets/icons/icon_prompt_beta.png',
                        color: isActive
                            ? const Color(0xff808080)
                            : const Color(0xff5d5d5d)))
                : Container(),
            type == "prompt"
                ? SizedBox(
                    width: 14,
                    height: 14,
                    child: Image.asset('assets/icons/icon_prompt_prompt.png',
                        color: isActive
                            ? const Color(0xff808080)
                            : const Color(0xff5d5d5d)))
                : Container(),
            const SizedBox(width: 2),
            Text(capitalize(type),
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: isActive
                        ? const Color(0xff808080)
                        : const Color(0xff5d5d5d)))
          ]),
          const SizedBox(height: 4),
          Row(children: [
            Expanded(
                child: Text(content,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: isActive
                          ? const Color(0xff808080)
                          : const Color(0xff5d5d5d),
                    ),
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis))
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
