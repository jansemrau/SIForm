import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormTextField extends StatelessWidget {
  final String label;
  final TextEditingController textController;

  const FormTextField(
      {Key? key, required this.label, required this.textController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.0,
      child: TextFormField(
        controller: textController,
        keyboardType: TextInputType.text,
        autocorrect: false,
        style: const TextStyle(fontSize: 10, color: Colors.black),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black),
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        ),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
    );
  }
}
