import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:acebot_front/presentation/screen/Login.dart';

void main() {
  /**
   * Splash Image 관련 코드
   * Splash Image를 특정 행위가 종료되기 전까지 유지시킬 수 있음
   */
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(MaterialApp(
      home: const AceBot(), theme: ThemeData(fontFamily: "Pretendard")));
}

class AceBot extends StatelessWidget {
  const AceBot({super.key});

  @override
  Widget build(BuildContext context) {
    return Login();
  }
}
