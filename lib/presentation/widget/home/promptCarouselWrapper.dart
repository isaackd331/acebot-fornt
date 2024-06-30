/// TODO
/// 이 위젯이 마운트 될 때, setPromptData로 [0,0,0,0] 설정시키기
library;

import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:acebot_front/presentation/widget/home/promptCarouselItem.dart';

class PromptCarouselWrapper extends StatefulWidget {
  final List<dynamic> itemsData;
  final int groupIdx;
  final Function setPromptData;
  final Function setPromptToChat;

  const PromptCarouselWrapper(
      {super.key,
      required this.groupIdx,
      required this.itemsData,
      required this.setPromptData,
      required this.setPromptToChat});

  @override
  _PromptCarouselWrapperState createState() => _PromptCarouselWrapperState();
}

class _PromptCarouselWrapperState extends State<PromptCarouselWrapper> {
  int curIdx = 0;

  @override
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
                prompt: datum['prompt'],
                title: datum['title'],
                tag: datum['tag'],
                isActive: idx == curIdx,
                setPromptToChat: widget.setPromptToChat);
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
