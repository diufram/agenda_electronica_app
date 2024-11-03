import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.textController,
      required this.isObscureText,
      required this.hintText,
      required this.type,
      this.validate});
  final TextEditingController textController;
  final TextInputType type;
  final bool isObscureText;
  final String hintText;
  final Function(String?)? validate;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: type,
      textInputAction: TextInputAction.done,
      style: Theme.of(context).textTheme.bodyMedium,
      controller: textController,
      obscureText: isObscureText,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.sp), // Bordes redondeados
          borderSide: const BorderSide(
            color: Colors.black,
            style: BorderStyle.solid,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.sp), // Bordes redondeados
          borderSide: const BorderSide(
            color: Colors.red,
            style: BorderStyle.solid,
          ),
        ),
        hintTextDirection: TextDirection.ltr,
        hintStyle: Theme.of(context).textTheme.bodyMedium,
        filled: true,
        hintText: hintText,
      ),
    );
  }
}
