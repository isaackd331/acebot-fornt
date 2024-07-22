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
  String namePlaceholder = "공백없이 한글 or 영어 or 숫자 포함 12자";
  bool? isNameInvalid;
  TextEditingController nameController = TextEditingController();

  Widget _errorState(String str) {
    return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.clear, color: Color(0xffe72929), size: 16),
          const SizedBox(width: 2),
          Text(str,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xffe72929)))
        ]);
  }

  Widget stateRenderer() {
    switch (isNameInvalid) {
      case true:
        return _errorState('이름은 한글, 영어 숫자를 사용한 1~12글자 입력해주세요.');
      default:
        return Container();
    }
  }

  @override
  void initState() {
    super.initState();

    nameController.text = widget.userName;

    nameFocusNode.addListener(() {
      if (nameFocusNode.hasFocus) {
        setState(() {
          namePlaceholder = "";
          isNameInvalid = null;
        });
        widget.setAbleToProgress(false);
      } else {
        setState(() {
          namePlaceholder = "공백없이 한글 or 영어 or 숫자 포함 12자";
        });

        String namePattern = r'^(?=.*[가-힣A-Za-z0-9])[가-힣A-Za-z0-9]{1,12}$';
        RegExp regExp = RegExp(namePattern);

        if (!regExp.hasMatch(nameController.text)) {
          setState(() {
            isNameInvalid = true;
          });
        } else {
          widget.setAbleToProgress(true);
          setState(() {
            isNameInvalid = false;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 30.0),
        child: Column(children: [
          const Row(children: [
            Expanded(
                child: Text("이름을\n입력해 주세요.",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff000000))))
          ]),
          const SizedBox(height: 56.0),
          Column(children: [
            const Row(children: [
              Expanded(
                  child: Text('이름',
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff444444))))
            ]),
            const SizedBox(height: 12),
            Row(children: [
              Expanded(
                  flex: 1,
                  child: TextField(
                    focusNode: nameFocusNode,
                    controller: nameController,
                    onChanged: (value) => {widget.setUserName(value)},
                    style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff000000)),
                    decoration: InputDecoration(
                        suffixIcon: nameController.text.isNotEmpty
                            ? IconButton(
                                onPressed: () {
                                  nameController.clear();

                                  setState(() {
                                    widget.setUserName("");
                                    isNameInvalid = false;
                                  });
                                },
                                icon: Image.asset('assets/icons/icon_clear.png',
                                    scale: 4),
                                iconSize: 24.0,
                                padding: const EdgeInsets.all(0))
                            : null,
                        hintText: namePlaceholder,
                        hintStyle: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff939393)),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 11.5),
                        filled: true,
                        fillColor: const Color(0xfff4f4f4),
                        border: InputBorder.none),
                  )),
            ]),
            const SizedBox(height: 8),
            stateRenderer()
          ])
        ]));
  }
}
