/**
   * TODO
   * 이 위젯이 마운트 될 때, setPromptData로 [0,0,0,0] 설정시키기
   */

import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:acebot_front/presentation/widget/home/promptCarouselItem.dart';

class PromptItem {
  final String type;
  final String content;

  PromptItem({
    required this.type,
    required this.content,
  });
}

class PromptCarouselWrapper extends StatefulWidget {
  final List<PromptItem> itemsData;
  final int groupIdx;
  final Function setPromptData;

  const PromptCarouselWrapper(
      {super.key,
      required this.groupIdx,
      required this.itemsData,
      required this.setPromptData});

  @override
  _PromptCarouselWrapperState createState() => _PromptCarouselWrapperState();
}

class _PromptCarouselWrapperState extends State<PromptCarouselWrapper> {
  int curIdx = 0;

  void initState() {
    super.initState();

    curIdx = 0;
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: widget.itemsData.mapIndexed((idx, datum) {
          return Builder(builder: (BuildContext context) {
            return PromptCarouselItem(
                type: datum.type,
                content: datum.content,
                isActive: idx == curIdx);
          });
        }).toList(),
        options: CarouselOptions(
          height: 65,
          viewportFraction: 0.6,
          pageSnapping: false,
          onPageChanged: (index, reason) {
            setState(() {
              curIdx = index;
            });
            widget.setPromptData(widget.groupIdx, index);
          },
        ));
  }
}
