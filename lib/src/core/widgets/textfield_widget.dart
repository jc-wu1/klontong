import 'package:flutter/material.dart';

import '../design_system/design_system.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    this.textInputAction,
    this.id,
    this.controller,
    this.onTap,
    this.onFieldSubmitted,
    this.hint,
    this.suffixIcon,
    this.prefixIcon,
    this.maxLines = 1,
    this.maxLength,
    this.textAlign = TextAlign.start,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
    this.errorText,
    this.counter = const SizedBox.shrink(),
    this.onChanged,
    this.initialValue,
    this.readOnly = false,
    this.useBorder = true,
    this.textStyle = body2Regular,
  });
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final GestureTapCallback? onTap;
  final ValueChanged<String>? onFieldSubmitted;
  final String? id;
  final String? hint;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Widget? counter;
  final int? maxLines;
  final int? maxLength;
  final TextAlign? textAlign;
  final TextInputType? keyboardType;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final String? initialValue;
  final bool readOnly;
  final String? errorText;
  final TextStyle? textStyle;
  final bool useBorder;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: textInputAction,
      controller: controller,
      maxLines: maxLines,
      maxLength: maxLength,
      textAlign: textAlign!,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      initialValue: initialValue,
      readOnly: readOnly,
      decoration: InputDecoration(
        errorStyle: const TextStyle(color: primaryColor50),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor50, width: 1),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor50, width: 1),
        ),
        border: (useBorder)
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: whiteColor40),
              )
            : InputBorder.none,
        errorText: errorText,
        counter: counter,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: whiteColor40),
        ),
        focusedBorder: (useBorder)
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: whiteColor40),
              )
            : null,
        contentPadding: const EdgeInsets.all(8),
        fillColor: whiteColor10,
        filled: true,
        hintText: hint,
      ),
      onTap: onTap,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      style: caption1Regular,
    );
  }
}
