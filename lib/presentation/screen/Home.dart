/**
 * 홈 페이지
 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:acebot_front/presentation/widget/home/promptCarouselWrapper.dart';
import 'package:acebot_front/presentation/widget/common/baseAppBar.dart';
import 'package:acebot_front/presentation/widget/common/baseBody.dart';

import 'package:acebot_front/bloc/user/selfState.dart';
import 'package:acebot_front/bloc/user/selfCubit.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();

    /**
     * 사용할 Cubit 초기화
     */
    context.read<SelfCubit>();
  }

  Widget _bodyWidget() {
    return BlocListener<SelfCubit, SelfState>(
        listener: (context, state) {},
        child: BlocBuilder<SelfCubit, SelfState>(builder: (_, state) {
          if (state is LoadedState) {
            return Center(
                child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 70, 20, 0),
                    child: Column(children: [
                      Row(children: [
                        Expanded(
                            child: RichText(
                                textAlign: TextAlign.center,
                                text: const TextSpan(
                                    text: 'ACEBOT ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14.0,
                                        color: Color(0xff000000)),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: 'Universe',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 14.0,
                                              color: Color(0xff000000)))
                                    ]))),
                      ]),
                      const SizedBox(height: 16),
                      Row(children: [
                        Expanded(
                            child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    text: '안녕하세요, ',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 20.0,
                                        color: Color(0xff000000),
                                        height: 1.5),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: '${state.userJson.name}님',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20.0,
                                              color: Color(0xff000000),
                                              height: 1.5))
                                    ])))
                      ]),
                      const Text('무엇을 도와드릴까요?',
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 20.0,
                              color: Color(0xff000000),
                              height: 1.5)),
                      const SizedBox(height: 20),
                      SizedBox(
                          width: 40,
                          height: 10,
                          child: Image.asset('assets/images/acebot_logo.png')),
                    ])));
          } else {
            return Container();
          }
        }));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: BaseAppBar(
        title: '',
        actions: [
          IconButton(
              onPressed: () {},
              icon: Image.asset('assets/icons/icons_newchat_disabled.png'),
              iconSize: 18,
              padding: const EdgeInsets.all(0)),
          IconButton(
              onPressed: () {},
              icon: Image.asset('assets/icons/icons_streamline.png'),
              iconSize: 16,
              padding: const EdgeInsets.all(0)),
        ],
        leading: IconButton(
            onPressed: () {},
            icon: Image.asset('assets/icons/icons_history.png'),
            iconSize: 8,
            padding: const EdgeInsets.all(0)),
      ),
      body: BaseBody(child: _bodyWidget()),
    ));
  }
}
