import 'package:flutter/material.dart';

class AddNewTextForm extends StatelessWidget {
  const AddNewTextForm(
      {Key? key, required this.controller, required this.width})
      : super(key: key);
  final TextEditingController controller;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
        scrollPadding: EdgeInsets.zero,
        textAlign: TextAlign.start,
        controller: controller,
        minLines: 1,
        maxLines: 500,
        textAlignVertical: TextAlignVertical.center,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: Colors.blue,
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: .2),
              borderRadius: BorderRadius.circular(4)),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: .2),
            borderRadius: BorderRadius.circular(4),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blue, width: .2),
              borderRadius: BorderRadius.circular(4)),
          errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: .2),
              borderRadius: BorderRadius.circular(4)),
        ),
      ),
    );
  }
}
