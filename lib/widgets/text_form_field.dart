import 'package:bazaar_adm/constants/style_constants.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? fieldLabel;

  const CustomTextFormField({
    this.controller,
    this.fieldLabel,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(width: 1.5, color: Colors.grey.shade400)),
        focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(width: 1.5, color: StyleConstants.primaryColor)
        ),
        label: Text(fieldLabel ?? ""),
        fillColor: Colors.white
      ),
    );
  }
}