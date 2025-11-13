import 'package:flutter/material.dart';

class WidgetInputText extends StatelessWidget {
  const WidgetInputText({
    required this.controller,
    required this.hintText,
    super.key,
    required,
  });
  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 1, color: Colors.greenAccent),
          ),
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 1, color: Colors.greenAccent),
          ),
        ),
      ),
    );
  }
}
