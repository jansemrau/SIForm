import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:order_form/main.dart';

class DropdownButtonExample extends StatefulWidget {
  final List<String> listElements;
  final TextEditingController dropdownValue;
  const DropdownButtonExample(
      {Key? key, required this.listElements, required this.dropdownValue})
      : super(key: key);
  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  @override
  void initState() {
    super.initState();
    widget.dropdownValue.text = widget.listElements.first;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton2(
      value: widget.dropdownValue.text,
      isExpanded: true,
      style: TextStyle(fontSize: fontSize, color: Colors.black),
      onChanged: (String? value) {
        setState(() {
          widget.dropdownValue.text = value!;
        });
      },
      buttonStyleData: const ButtonStyleData(height: 40),
      dropdownStyleData: const DropdownStyleData(width: 200),
      items: widget.listElements.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
            value: value, child: SizedBox(width: 500, child: Text(value)));
      }).toList(),
    );
  }
}
