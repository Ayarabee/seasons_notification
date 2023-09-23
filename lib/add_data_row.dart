import 'package:flutter/material.dart';

import 'add_new_textform.dart';

class AddDataRow extends StatelessWidget {
  const AddDataRow(
      {Key? key,
      required this.controller,
      required this.name,
      required this.width})
      : super(key: key);
  final TextEditingController controller;
  final String name;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Colors.blue,
          ),
        ),
        SizedBox(
          width: width,
        ),
        AddNewTextForm(
          controller: controller,
          // height: 30,
          width: MediaQuery.of(context).size.width / 2.5,
        ),
      ],
    );
  }
}
