import 'package:flutter/material.dart';

class RecommendPromptSection extends StatefulWidget {
  final List<dynamic> recommendPrompts;
  final Function setPromptToChat;

  const RecommendPromptSection(
      {super.key,
      required this.recommendPrompts,
      required this.setPromptToChat});

  @override
  _RecommendPromptSectionState createState() => _RecommendPromptSectionState();
}

class _RecommendPromptSectionState extends State<RecommendPromptSection> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _promptRow(String title, int idx) {
    return Column(children: [
      GestureDetector(
          onTap: () {
            widget.setPromptToChat(title);
          },
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("${idx + 1}",
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff4f4f4f))),
            const SizedBox(width: 10),
            Expanded(
                child: Text(title,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff4f4f4f))))
          ])),
      const SizedBox(height: 20)
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 60),
          Row(
            children: [
              Container(
                  width: 80,
                  height: 2,
                  decoration: const BoxDecoration(color: Color(0xff000000)))
            ],
          ),
          const SizedBox(height: 27),
          const Row(children: [
            Text("이런 추가 질문은 어떠세요?",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff000000)))
          ]),
          const SizedBox(height: 30),
          Column(
              children:
                  widget.recommendPrompts.asMap().entries.map<Widget>((entry) {
            int idx = entry.key;
            dynamic value = entry.value;

            return SizedBox(child: _promptRow(value['prompt'], idx));
          }).toList())
        ]);
  }
}
