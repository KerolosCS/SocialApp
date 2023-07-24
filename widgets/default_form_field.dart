import 'package:flutter/material.dart';

class Defualts {
  static Widget defaultFormFeild({
    required TextEditingController controller,
    required TextInputType type,
    Function(String)? onSubmit,
    Function(String)? onChange,
    String? Function(String?)? validate,
    required String label,
    IconData? prefix,
    IconData? suffix,
  }) =>
      TextFormField(
        controller: controller,
        keyboardType: type,
        obscureText: true,
        onFieldSubmitted: onSubmit,
        onChanged: onChange,
        validator: validate,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(prefix),
          suffixIcon: Icon(suffix),
          border: const OutlineInputBorder(),
        ),
      );
}
