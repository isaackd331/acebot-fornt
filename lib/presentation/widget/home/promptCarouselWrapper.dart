import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:acebot_front/presentation/widget/home/promptCarouselItem.dart';

class PromptItem {
  final String type;
  final String content;

  PromptItem({required this.type, required this.content});
}

class PromptCarouselWrapper extends StatelessWidget {
  final List<PromptItem> itemsData;

  const PromptCarouselWrapper({super.key, required this.itemsData});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: itemsData.map((datum) {
          return Builder(builder: (BuildContext context) {
            return PromptCarouselItem(
                type: datum.type, content: datum.content, isActive: true);
          });
        }).toList(),
        options: CarouselOptions(height: 65));
  }
}
