import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class BaseDropdown extends StatefulWidget {
  Function onChanged;
  List<dynamic> options;
  dynamic selected;

  BaseDropdown(
      {super.key,
      required this.onChanged,
      required this.options,
      required this.selected});

  @override
  _BaseDropdownState createState() => _BaseDropdownState();
}

class _BaseDropdownState extends State<BaseDropdown> {
  @override
  void initState() {
    super.initState();

    print(widget.options);
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<dynamic>(
        isExpanded: true,
        items: widget.options
            .map((dynamic option) => DropdownMenuItem<dynamic>(
                value: option,
                child: Text(option,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff000000)))))
            .toList(),
        value: widget.selected,
        onChanged: (value) {
          widget.onChanged(value);
        },
        buttonStyleData: ButtonStyleData(
            height: 42,
            padding: const EdgeInsets.fromLTRB(0, 8, 16, 8),
            decoration: BoxDecoration(
                color: const Color(0xffffffff),
                border: Border.all(color: const Color(0xffebebeb)),
                borderRadius: BorderRadius.circular(4))),
        iconStyleData: IconStyleData(
            icon: SizedBox(
                width: 14,
                height: 7,
                child: Image.asset('assets/icons/icon_curved_down.png'))),
        dropdownStyleData: DropdownStyleData(
            padding: const EdgeInsets.all(0),
            offset: const Offset(0, -8),
            elevation: 0,
            maxHeight: 300,
            decoration: BoxDecoration(
                color: const Color(0xffffffff),
                border: Border.all(color: const Color(0xffebebeb)),
                borderRadius: BorderRadius.circular(4)),
            scrollbarTheme:
                ScrollbarThemeData(thickness: WidgetStateProperty.all(2)),
            scrollPadding: const EdgeInsets.only(right: 12)),
      ),
    );
  }
}
