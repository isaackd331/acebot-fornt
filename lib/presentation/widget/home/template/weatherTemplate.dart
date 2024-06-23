import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:acebot_front/bloc/answer/answerState.dart';
import 'package:acebot_front/bloc/answer/answerCubit.dart';

class WeatherTemplate extends StatefulWidget {
  final int index;
  final int questionId;
  final int threadId;
  final String question;

  const WeatherTemplate(
      {super.key,
      required this.index,
      required this.questionId,
      required this.threadId,
      required this.question});

  @override
  _WeatherTemplateState createState() => _WeatherTemplateState();
}

class _WeatherTemplateState extends State<WeatherTemplate> {
  String? templateName = "";
  String mainParagraph = "";
  List<dynamic>? subParagraph = [];
  List<dynamic>? recommendedPrompt = [];

  @override
  void initState() {
    super.initState();

    // initialize cubit
    context.read<AnswerCubit>();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _subParagraphWidget() {
    final textStyle = Theme.of(context)
        .textTheme
        .bodyMedium
        ?.copyWith(fontSize: 14, color: const Color(0xFF19171F));
    final subTextStyle =
        textStyle?.copyWith(fontSize: 12, color: const Color(0xFF999999));
    final weatherChildren = <Widget>[];

    return Card(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
          side: const BorderSide(color: Color(0xFFEBEBEB)),
          borderRadius: BorderRadius.circular(2)),
      margin: EdgeInsets.zero,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(
            children: weatherChildren
              ..add(
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          children: subParagraph!
                              .asMap()
                              .entries
                              .map((e) => _weatherBox(e.key, e.value))
                              .toList()),
                      Text('OpenWeatherMap', style: subTextStyle),
                    ],
                  ),
                ),
              ),
          ),
        ),
      ),
    );
  }

  Widget _weatherBox(int index, dynamic weather) {
    int? getHour(String time) {
      var findHour = RegExp(r'\d+(?=:)').firstMatch(time)?.group(0);
      return (findHour != null) ? int.tryParse(findHour) : null;
    }

    String getWeatherAssetName(String weatherType, String time) {
      if (weatherType == 'clear') {
        final hour = getHour(time);
        if (hour == null) {
          return 'sunny_light';
        } else if (hour >= 6 && hour < 18) {
          return 'sunny_light';
        } else {
          return 'sunny_dark';
        }
      }

      return switch (weatherType) {
        'thunderstorm' => 'thunder',
        'drizzle' || 'rain' || 'squall' => 'rainy',
        'snow' => 'snowman',
        'mist' ||
        'smoke' ||
        'haze' ||
        'dust' ||
        'fog' ||
        'sand' ||
        'ash' =>
          'haze',
        'tornado' => 'windy',
        'clouds' => 'cloudy',
        _ => 'icon_error',
      };
    }

    String getHourString(String time) {
      final hour = getHour(time);
      if (hour == null) {
        return '';
      } else {
        return (hour == 0)
            ? '자정'
            : (hour < 12)
                ? '오전 $hour시'
                : '오후 ${hour - 12}시';
      }
    }

    String getWeekString(String time) {
      var findWeek = RegExp(r'(\S)(?=요일)').firstMatch(time)?.group(0);
      return (findWeek == null) ? '' : findWeek;
    }

    int getAverageTemperature(dynamic highest, dynamic lowest) =>
        ((highest + lowest) / 2).floor();

    final textStyle =
        Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14);
    final subTextStyle =
        textStyle?.copyWith(fontSize: 12, color: const Color(0xFF999999));
    final temperatureString = (templateName == 'cur_weather')
        ? '${weather['온도'].floor()}℃'
        : '${getAverageTemperature(weather['최고기온'], weather['최저기온'])}℃';
    final timeString = (templateName == 'cur_weather')
        ? getHourString(weather['시각'])
        : getWeekString(weather['날짜']);

    return SizedBox(
      child: Padding(
        padding: EdgeInsets.only(left: (index > 0) ? 20 : 0),
        child: Column(
          children: [
            Image.asset(
                'assets/images/${getWeatherAssetName(weather['날씨'], weather[(templateName == 'cur_weather') ? '시각' : '날짜'])}.png',
                width: 44,
                height: 44),
            const SizedBox(height: 12),
            Text(temperatureString, style: textStyle),
            const SizedBox(height: 12),
            Text(timeString, style: subTextStyle),
            const SizedBox(height: 24)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AnswerCubit, List<AnswerState>>(
        listener: (context, state) {
      AnswerState theState = state[widget.index];

      if (theState is LoadedState) {
        setState(() {
          templateName = theState.answerJson.template_name;
          mainParagraph = theState.answerJson.main_paragraph;
          subParagraph = theState.answerJson.sub_paragraph;
        });
      }
    }, child: BlocBuilder<AnswerCubit, List<AnswerState>>(builder: (_, state) {
      AnswerState theState = state[widget.index];

      if (theState is LoadedState) {
        return SingleChildScrollView(
            child: Container(
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
                  ])
                ])));
      } else {
        return Container();
      }
    }));
  }
}
