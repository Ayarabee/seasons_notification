import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class ChooseDropDown extends StatefulWidget {
  const ChooseDropDown({
    Key? key,
    required this.textEditingController,
    required this.items,
  }) : super(key: key);
  final TextEditingController textEditingController;
  final List<String> items;

  @override
  State<ChooseDropDown> createState() => _RequestPricingDropDown();
}

String? selectedValue;

class _RequestPricingDropDown extends State<ChooseDropDown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: selectedValue != null
            ? Text(
                selectedValue!,
                style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              )
            : const Text(
                "Send to",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
        iconStyleData: const IconStyleData(
          iconDisabledColor: Colors.grey,
          iconEnabledColor: Colors.blue,
        ),
        isDense: true,
        alignment: AlignmentDirectional.centerStart,
        items: widget.items
            .map((String item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600),
                  ),
                ))
            .toList(),
        // value: selectedValue,
        onChanged: (String? value) {
          setState(() {
            selectedValue = value;
          });
        },
        buttonStyleData: ButtonStyleData(
            height: 40,
            padding: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: .5),
            )),

        dropdownStyleData: const DropdownStyleData(
          maxHeight: 250,
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 50,
        ),
        onMenuStateChange: (isOpen) {
          if (!isOpen) {
            widget.textEditingController.clear();
          }
        },
      ),
    );
  }
}
