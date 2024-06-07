/// screen/History.dart
/// Widget for when tabMode == 'thread'
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:acebot_front/presentation/widget/common/baseOutlineButton.dart';

import 'package:acebot_front/bloc/thread/threadState.dart';
import 'package:acebot_front/bloc/thread/threadCubit.dart';

class ThreadWidget extends StatefulWidget {
  const ThreadWidget({super.key});

  @override
  _ThreadWidgetState createState() => _ThreadWidgetState();
}

class _ThreadWidgetState extends State<ThreadWidget> {
   @override
   void initState() {
    super.initState();

    // initialize Cubit
    context.read<ThreadCubit>();
   }

   @override
   void dispose() {
    super.dispose();
   }

   Widget _loadedButEmpty() {
    return Expanded(
      child: Column(
        children: [
          Flexible(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 68,
                  height: 68,
                  child: Image.asset('assets/icons/icon_thread_empty.png')
                ),
                const SizedBox(height: 12),
                const Text('스레드가 없습니다.',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff1c1c1c)
                  )
                )
              ]
            ),
          ),
          Flexible(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    BaseOutlineButton(onPressedFunc: () {
                      context.go('/home');
                    }, text: '스레드 추가하기', fontSize: 16, textColor: const Color(0xffffffff), backgroundColor: const Color(0xff000000), borderColor: const Color(0xff000000))
                  ]
                ),
                const SizedBox(height: 24)
              ]
            )
          )
        ]
      )
    );
   }

   @override
   Widget build(BuildContext context) {
    return BlocBuilder<ThreadCubit, ThreadState>(
      builder: (_, state) {
        if(state is! LoadedState) {
          return Container();
        } else {
          if(state.threadJson.items.isEmpty) {
            return _loadedButEmpty();
          } else {
            return Column(
              children: [
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: const Text('편집',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff666666)
                        )
                      )
                    )
                  ]
                )
              ]
            );
          }
        }
      }
    );
   }
}
