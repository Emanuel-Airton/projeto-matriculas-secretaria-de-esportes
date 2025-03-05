import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextformfield extends StatelessWidget {
  TextEditingController? controller;
  List<TextInputFormatter>? inputFormatters;
  String? Function(String?)? validator;
  void Function(String?)? onChanged;
  String? labelText;
  String? hintText;
  TextInputType? keyboardType;
  int? maxLength;
  bool? enabled;
  CustomTextformfield(
      {this.controller,
      this.hintText,
      this.keyboardType,
      this.labelText,
      this.inputFormatters,
      this.maxLength,
      this.validator,
      this.onChanged,
      this.enabled,
      super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      validator: validator,
      inputFormatters: inputFormatters,
      maxLength: maxLength,
      onChanged: onChanged,
      enabled: enabled,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
        border: InputBorder.none,
      ),
    );
  }
}
