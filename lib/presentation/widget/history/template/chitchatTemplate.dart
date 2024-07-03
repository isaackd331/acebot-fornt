import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ChitChatTemplate extends StatefulWidget {
  final String mainParagraph;
  final List<dynamic> subParagraph;
  final String templateName;

  const ChitChatTemplate(
      {super.key,
      required this.mainParagraph,
      required this.subParagraph,
      required this.templateName});

  @override
  _ChitChatTemplateState createState() => _ChitChatTemplateState();
}

class _ChitChatTemplateState extends State<ChitChatTemplate> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(children: [
          Row(children: [
            Expanded(
                child: MarkdownBody(
              data: widget.mainParagraph,
              listItemCrossAxisAlignment:
                  MarkdownListItemCrossAxisAlignment.start,
              styleSheet: MarkdownStyleSheet(
                  textAlign: WrapAlignment.start,
                  p: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff4f4f4f),
                      height: 1.5)),
            )),
          ]),
        ]));
  }
}
