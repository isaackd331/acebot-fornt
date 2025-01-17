import "package:flutter/material.dart";
import 'package:lottie/lottie.dart';

class Spinner extends StatefulWidget {
  const Spinner({super.key});

  @override
  _SpinnerState createState() => _SpinnerState();
}

class _SpinnerState extends State<Spinner> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(context) {
    return Center(
        child: Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              color: Color(0xffffffff),
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            child: LottieBuilder.asset('assets/lottie/doc_upload.json')));
  }
}
