import 'package:flutter/material.dart';

class FirstProgress extends StatefulWidget {
  final Function setProgress;
  final Function setUserId;
  final String userId;

  const FirstProgress(
      {super.key,
      required this.setProgress,
      required this.setUserId,
      required this.userId});

  @override
  _FirstProgressState createState() => _FirstProgressState();
}

class _FirstProgressState extends State<FirstProgress> {
  bool isIdFieldFocused = false;
  bool isIdInvalid = false;
  bool isIdEmpty = true;
  TextEditingController idController = TextEditingController();

  @override
  void initState() {
    super.initState();

    idController.addListener(() {
      setState(() {
        isIdEmpty = idController.text.isEmpty;
      });
    });

    isIdInvalid = false;
  }

  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 30.0),
        child: Column(children: <Widget>[
          Row(children: <Widget>[
            Expanded(
                child: Text("이메일을\n입력해 주세요.",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xff000000))))
          ]),
          SizedBox(height: 56.0),
          Column(children: <Widget>[
            Row(children: <Widget>[
              Expanded(
                  child: Text('아이디',
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff444444))))
            ]),
            SizedBox(height: 12),
            Focus(
              child: TextField(
                controller: idController,
                onChanged: (value) => {widget.setUserId(value)},
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff000000)),
                decoration: InputDecoration(
                    suffixIcon: !isIdEmpty
                        ? IconButton(
                            icon: Icon(Icons.clear,
                                color: const Color(0xff000000), size: 24.0),
                            onPressed: () {
                              setState(() {
                                idController.clear();
                                widget.setUserId("");
                              });
                            },
                          )
                        : null,
                    hintText: "아이디",
                    hintStyle: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff939393)),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 11.5),
                    filled: true,
                    fillColor: Color(0xfff4f4f4),
                    border: InputBorder.none),
              ),
              onFocusChange: (isIdFieldFocused) {
                // isIdFieldFocused가 false가 될 때 error 메세지 드으이 처리를 할 것
                print(isIdFieldFocused);
              },
            )
          ])
        ]));
  }
}
