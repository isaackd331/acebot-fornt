import 'package:flutter/material.dart';

class ThirdProgress extends StatefulWidget {
  final Function setProgress;
  final Function setAbleToProgress;
  final Function setUserName;
  final String userName;

  const ThirdProgress(
      {super.key,
      required this.setProgress,
      required this.setAbleToProgress,
      required this.setUserName,
      required this.userName});

  @override
  _ThirdProgressState createState() => _ThirdProgressState();
}

class _ThirdProgressState extends State<ThirdProgress> {
  FocusNode nameFocusNode = FocusNode();
  String namePlaceholder = "아이디";
  bool isIdInvalid = false;
  String idInvalidType = "";
  bool isIdEmpty = true;
  TextEditingController idController = TextEditingController();

  @override
  void initState() {
    super.initState();

    nameFocusNode.addListener(() {
      nameFocusNode.hasFocus
          ? setState(() {
              namePlaceholder = "";
            })
          : setState(() {
              namePlaceholder = "아이디";
            });
    });

    idController.addListener(() {
      setState(() {
        isIdEmpty = idController.text.isEmpty;

        if (isIdEmpty) {
          idInvalidType = "";
        } else {
          String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
          RegExp regExp = new RegExp(emailPattern);

          if (regExp.hasMatch(idController.text)) {
            idInvalidType = "notEmail";
          } else {
            // 이메일 중복 체크 후 idInvalidType을 조정
          }
        }
      });
    });

    isIdInvalid = false;
    idInvalidType = "";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 30.0),
        child: Column(children: [
          Row(children: [
            Expanded(
                child: Text("이메일을\n입력해 주세요.",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xff000000))))
          ]),
          SizedBox(height: 56.0),
          Column(children: [
            Row(children: [
              Expanded(
                  child: Text('아이디',
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff444444))))
            ]),
            SizedBox(height: 12),
            TextField(
              focusNode: nameFocusNode,
              controller: idController,
              onChanged: (value) => {widget.setUserName(value)},
              style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff000000)),
              decoration: InputDecoration(
                  suffixIcon: !isIdEmpty
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              idController.clear();
                              widget.setUserName("");
                            });
                          },
                          icon:
                              Icon(Icons.clear, color: const Color(0xff000000)),
                          iconSize: 24.0,
                          padding: const EdgeInsets.all(0))
                      : null,
                  hintText: namePlaceholder,
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
          ])
        ]));
  }
}
