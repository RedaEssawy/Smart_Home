import 'package:flutter/material.dart';
import 'package:smart_home/core/util/app_colors.dart';

class StateOfDevice extends StatefulWidget {
  final bool obscureText;
  final TextEditingController controller;
  final IconData prefixIcon;
  final String deviceName;

  const StateOfDevice(
      {super.key,
      required this.controller,
      required this.prefixIcon,
      this.obscureText = false,
      required this.deviceName});

  @override
  State<StateOfDevice> createState() => _StateOfDeviceState();
}

class _StateOfDeviceState extends State<StateOfDevice> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.controller,
          obscureText: widget.obscureText,
          decoration: InputDecoration(
            prefix: Text(
              widget.deviceName,
              style: TextStyle(color: AppColors.black),
            ),
            prefixIcon: Icon(widget.prefixIcon),
            prefixIconColor: AppColors.grey,
            fillColor: AppColors.grey2,
            filled: true,
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10)),
          ),
        )
      ],
    );
  }
}
