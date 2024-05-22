import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
            return Container(width: 50, color: Colors.red);
          });
        }).toList(),
        options: CarouselOptions(height: 30));
  }
}
