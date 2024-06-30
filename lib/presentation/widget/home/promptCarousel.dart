import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:acebot_front/presentation/widget/home/promptCarouselWrapper.dart';

import 'package:acebot_front/bloc/prompt/promptState.dart';
import 'package:acebot_front/bloc/prompt/promptCubit.dart';

class PromptCarousel extends StatefulWidget {
  final Function setPromptToChat;
  final Function setPromptData;

  const PromptCarousel(
      {super.key, required this.setPromptToChat, required this.setPromptData});

  @override
  _PromptCarouselState createState() => _PromptCarouselState();
}

class _PromptCarouselState extends State<PromptCarousel> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    [0, 0, 0, 0].map((idx) {
      widget.setPromptData(idx, 0);
    });

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PromptCubit, PromptState>(builder: (_, state) {
      if (state is LoadedState) {
        return SizedBox(
            height: 314,
            child: ListView.separated(
                itemCount: 4,
                separatorBuilder: (BuildContext context, int idx) {
                  return const SizedBox(height: 18);
                },
                itemBuilder: (BuildContext context, int idx) {
                  return Builder(builder: (BuildContext context) {
                    return PromptCarouselWrapper(
                        groupIdx: idx,
                        itemsData: state.promptJson.prompts[idx],
                        setPromptData: widget.setPromptData,
                        setPromptToChat: widget.setPromptToChat);
                  });
                }));
      } else {
        return Container();
      }
    });
  }
}
