import 'package:flutter/material.dart';
import 'package:smart_home/core/util/app_colors.dart';

class LableWithTextField extends StatefulWidget {
  final bool obscureText;
  final TextEditingController controller;
  final Widget? sufixIcon;
  final IconData prefixIcon;
  final String hintText;
  final String title;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;

  const LableWithTextField(
      {super.key,
      required this.title,
      required this.controller,
      required this.prefixIcon,
      this.sufixIcon,
      this.validator,
      required this.hintText,
      this.obscureText = false, this.onChanged});

  @override
  State<LableWithTextField> createState() => _LableWithTextFieldState();
}

class _LableWithTextFieldState extends State<LableWithTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.w600),
        ),
        TextFormField(
          onChanged: widget.onChanged,
          validator:widget.validator,
          controller: widget.controller,
          obscureText: widget.obscureText,
          decoration: InputDecoration(
              prefixIcon: Icon(widget.prefixIcon),
              suffixIcon: widget.sufixIcon,
              suffixIconColor: AppColors.grey,
              fillColor: AppColors.grey2,
              filled: true,
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10)),
              hintText: widget.hintText,
              hintStyle: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: AppColors.black)),
        )
      ],
    );
  }
}
