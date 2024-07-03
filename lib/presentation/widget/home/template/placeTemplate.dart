import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:acebot_front/presentation/widget/home/additionalAction.dart';

import 'package:acebot_front/bloc/answer/answerState.dart';
import 'package:acebot_front/bloc/answer/answerCubit.dart';

class PlaceTemplate extends StatefulWidget {
  // final int index;
  final int questionId;
  final int threadId;
  final String question;
  final Function setChatContent;
  final String initMp;
  final List<dynamic> recommendPrompts;

  const PlaceTemplate(
      {super.key,
      // required this.index,
      required this.questionId,
      required this.threadId,
      required this.question,
      required this.setChatContent,
      required this.initMp,
      required this.recommendPrompts});

  @override
  _PlaceTemplateState createState() => _PlaceTemplateState();
}

class _PlaceTemplateState extends State<PlaceTemplate> {
  String? templateName = "";
  String mainParagraph = "";
  List<dynamic>? subParagraph = [];
  List<dynamic>? recommendedPrompt = [];

  @override
  void initState() {
    super.initState();

    setState(() {
      mainParagraph = widget.initMp;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _subParagraphWidget() {
    final textStyle = Theme.of(context)
        .textTheme
        .bodyMedium
        ?.copyWith(fontSize: 14, fontWeight: FontWeight.bold);

    return Column(
      children: [
        IntrinsicHeight(
          child: Row(
            children: [
              Text('출처 ${subParagraph!.length}',
                  style: textStyle?.copyWith(color: const Color(0xFF4F4F4F))),
              const VerticalDivider(
                  color: Color(0xFFD9D9D9),
                  width: 20,
                  thickness: 1,
                  indent: 5,
                  endIndent: 5),
              Image.asset('assets/images/google_map.png',
                  width: 18, height: 18),
              const SizedBox(width: 4),
              Text('Google Map',
                  style: textStyle?.copyWith(color: const Color(0xFF999999))),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              children: subParagraph!
                  .asMap()
                  .entries
                  .map((e) => _subParagraphItem(e.key, e.value))
                  .toList()),
        ),
      ],
    );
  }

  Widget _subParagraphItem(int index, dynamic data) {
    const borderRadius = 4.0;
    final textStyle = Theme.of(context)
        .textTheme
        .bodyMedium
        ?.copyWith(fontSize: 12, color: const Color(0xFF292B2E));
    final subTextStyle = textStyle?.copyWith(color: const Color(0xFF999999));

    Future<void> launchBrowser(Uri url) async {
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $url');
      }
    }

    return Padding(
      padding: EdgeInsets.only(top: 12, left: (index == 0) ? 0 : 10),
      child: Card(
        color: Colors.white,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
            side: const BorderSide(color: Color(0xFFEBEBEB)),
            borderRadius: BorderRadius.circular(borderRadius)),
        child: InkWell(
          onTap: () => launchBrowser(Uri.parse(data['place_link'])),
          borderRadius: BorderRadius.circular(borderRadius),
          child: SizedBox(
            width: 256,
            height: 63,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(borderRadius),
                    child: Image.network(data['photo_reference'],
                        width: 39, height: 39, fit: BoxFit.cover),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            data['place'],
                            overflow: TextOverflow.ellipsis,
                            style: textStyle?.copyWith(
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Row(
                          children: [
                            Text('${data['rating']}', style: subTextStyle),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: _starRating(
                                  double.parse(data['rating'].toString())),
                            ),
                            Text('(${data['review_count']})',
                                style: subTextStyle),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _starRating(double rating) {
    List<Widget> makeStarList() {
      final list = <Widget>[];
      for (var x = 1; x <= 5; ++x) {
        list.add(Image.asset(
            (x - 0.2 <= rating)
                ? 'assets/images/ic_star.png'
                : (x - 0.7 <= rating)
                    ? 'assets/images/ic_star_half.png'
                    : 'assets/images/ic_star_none.png',
            width: 16,
            height: 16));
      }
      return list;
    }

    return Row(children: makeStarList());
  }

  @override
  Widget build(BuildContext context) {
    // 추후 개발 때는 length가 늘어나며 여러 질문/답변이 한 화면에 나타날 수 있어야 함.
    // 1차 개발에서는 한 화면에 한 질문/답변만
    // return BlocListener<AnswerCubit, List<AnswerState>>(
    return BlocListener<AnswerCubit, AnswerState>(listener: (context, state) {
      // 추후 개발 때는 length가 늘어나며 여러 질문/답변이 한 화면에 나타날 수 있어야 함.
      // 1차 개발에서는 한 화면에 한 질문/답변만
      // AnswerState theState = state[widget.index];
      AnswerState theState = state;

      if (theState is LoadedState) {
        setState(() {
          templateName = theState.answerJson.template_name;
          mainParagraph = theState.answerJson.main_paragraph;
          subParagraph = theState.answerJson.sub_paragraph;
        });
      }
    },
        // 추후 개발 때는 length가 늘어나며 여러 질문/답변이 한 화면에 나타날 수 있어야 함.
        // 1차 개발에서는 한 화면에 한 질문/답변만
        // child: BlocBuilder<AnswerCubit, List<AnswerState>>(builder: (_, state) {
        child: BlocBuilder<AnswerCubit, AnswerState>(builder: (_, state) {
      // 추후 개발 때는 length가 늘어나며 여러 질문/답변이 한 화면에 나타날 수 있어야 함.
      // 1차 개발에서는 한 화면에 한 질문/답변만
      // AnswerState theState = state[widget.index];
      AnswerState theState = state;

      if (theState is LoadedState) {
        return Container(
            margin: const EdgeInsets.only(top: 20),
            child: Column(children: [
              _subParagraphWidget(),
              const SizedBox(height: 10),
              Row(children: [
                Expanded(
                    child: MarkdownBody(
                  data: mainParagraph,
                  listItemCrossAxisAlignment:
                      MarkdownListItemCrossAxisAlignment.start,
                  styleSheet: MarkdownStyleSheet(
                      textAlign: WrapAlignment.start,
                      p: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff4f4f4f),
                          height: 1.5)),
                ))
              ]),
              const SizedBox(height: 28),
              AdditionalAction(
                  mainParagraph: mainParagraph,
                  questionId: widget.questionId,
                  threadId: widget.threadId,
                  page: 0,
                  answerArrLength: 0,
                  setPage: () {})
            ]));
      } else {
        return Container();
      }
    }));
  }
}
