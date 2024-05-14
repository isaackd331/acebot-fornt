import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:acebot_front/presentation/widget/common/BaseAppBar.dart';
import 'package:acebot_front/presentation/widget/common/BaseDialog.dart';
import 'package:acebot_front/presentation/widget/common/BaseOutlineButton.dart';

void main() {
  /**
   * Splash Image 관련 코드
   * Splash Image를 특정 행위가 종료되기 전까지 유지시킬 수 있음
   */
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(MaterialApp(
      home: const AceBot(),
      theme: ThemeData(
        fontFamily: "Pretendard",
      )));
}

class AceBot extends StatelessWidget {
  const AceBot({super.key});

  @override
  Widget build(BuildContext context) {
    final testDialog = BaseDialog(
        title: "오류",
        content: "서비스가 지연되고 있습니다.\n인터넷 연결을 확인해 주세요.",
        buttonsList: <Widget>[
          BaseOutlineButton(
              onPressedFunc: () {},
              text: "테스트",
              fontSize: 16,
              textColor: Color(0xff000000),
              backgroundColor: Color(0xffffffff),
              borderColor: Color(0xffe7e7e7)),
          SizedBox(width: 9.0),
          BaseOutlineButton(
              onPressedFunc: () {},
              text: "테스트",
              fontSize: 16,
              textColor: Color(0xffffffff),
              backgroundColor: Color(0xff000000),
              borderColor: Color(0xff000000)),
        ]);

    return Scaffold(
        appBar: BaseAppBar(
            title: 'TEST',
            actions: [
              IconButton(
                icon: const Icon(Icons.add_alert),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return testDialog;
                      });
                },
              )
            ],
            leading: SizedBox()));
  }
}
