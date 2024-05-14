import 'package:flutter/material.dart';

class BaseOutlineButton extends StatelessWidget {
  late void Function()? onPressedFunc;
  String text;
  double fontSize;
  late Color textColor;
  late Color backgroundColor;
  late Color borderColor;

  BaseOutlineButton({
    super.key,
    required this.onPressedFunc,
    required this.text,
    required this.fontSize,
    required this.textColor,
    required this.backgroundColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return
        // OutlinedButton(
        //     onPressed: onPressedFunc,
        //     child: Text(text,
        //         style: TextStyle(
        //           fontSize: fontSize,
        //           fontWeight: FontWeight.w600,
        //         )),
        //     style: OutlinedButton.styleFrom(
        //         foregroundColor: textColor,
        //         backgroundColor: backgroundColor,
        //         side: BorderSide(color: borderColor, width: 1.0),
        //         shape: RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(4.0)),
        //         padding: const EdgeInsets.only(top: 13.0, bottom: 13.0)));
        Expanded(
            child: OutlinedButton(
                onPressed: onPressedFunc,
                child: Text(text,
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.w600,
                    )),
                style: OutlinedButton.styleFrom(
                    foregroundColor: textColor,
                    backgroundColor: backgroundColor,
                    side: BorderSide(color: borderColor, width: 1.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0)),
                    padding: const EdgeInsets.only(top: 13.0, bottom: 13.0))));
  }
}
