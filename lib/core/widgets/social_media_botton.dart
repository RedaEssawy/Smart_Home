import 'package:flutter/material.dart';
import 'package:smart_home/core/util/app_colors.dart';

class SocialMediaBotton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;

  const SocialMediaBotton(
      {super.key, required this.title, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: DecoratedBox(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.grey2),
              color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon),
                const SizedBox(width: 8),
                Text(title),
              ],
            ),
          )),
    );
  }
}
