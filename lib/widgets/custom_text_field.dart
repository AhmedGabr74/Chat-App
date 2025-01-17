import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({this.hintText, this.onchange, this.obscureText = false});
  Function(String)? onchange;
  final String? hintText;
  final bool? obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText!,
      validator: (data)
      {

        if (data!.isEmpty)
          return 'field is Required';

      },
      onChanged:onchange ,
      style: const TextStyle(color: Colors.white,
          fontSize: 18,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.white,
        ),
        // labelStyle: TextStyle(color: Colors.orange),
        // labelText: 'Custom Text',
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        // focusedBorder: const OutlineInputBorder(
        //   borderSide: BorderSide(
        //     color: Colors.white,
        //   ),
        // ),
      ),
    );
  }
}
