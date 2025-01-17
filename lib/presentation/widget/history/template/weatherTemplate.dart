import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class WeatherTemplate extends StatefulWidget {
  final String mainParagraph;
  final List<dynamic> subParagraph;
  final String templateName;

  const WeatherTemplate(
      {super.key,
      required this.mainParagraph,
      required this.subParagraph,
      required this.templateName});

  @override
  _WeatherTemplateState createState() => _WeatherTemplateState();
}

class _WeatherTemplateState extends State<WeatherTemplate> {
  @override
  void initState() {
    super.initState();
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
                          children: widget.subParagraph
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
    final temperatureString = (widget.templateName == 'cur_weather')
        ? '${weather['온도'].floor()}℃'
        : '${getAverageTemperature(weather['최고기온'], weather['최저기온'])}℃';
    final timeString = (widget.templateName == 'cur_weather')
        ? getHourString(weather['시각'])
        : getWeekString(weather['날짜']);

    return SizedBox(
      child: Padding(
        padding: EdgeInsets.only(left: (index > 0) ? 20 : 0),
        child: Column(
          children: [
            Image.asset(
                'assets/images/${getWeatherAssetName(weather['날씨'], weather[(widget.templateName == 'cur_weather') ? '시각' : '날짜'])}.png',
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
    // 추후 개발 때는 length가 늘어나며 여러 질문/답변이 한 화면에 나타날 수 있어야 함.
    // 1차 개발에서는 한 화면에 한 질문/답변만
    // return BlocListener<AnswerCubit, List<AnswerState>>(
    return Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(children: [
          _subParagraphWidget(),
          const SizedBox(height: 10),
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
            ))
          ]),
        ]));
  }
}
