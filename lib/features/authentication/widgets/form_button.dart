import 'package:flutter/material.dart';
import 'package:thread_clone/constants/sizes.dart';

class FormButton extends StatelessWidget {
  const FormButton({
    super.key,
    required this.disabled,
    this.text,
    required this.isLarge,
    this.color,
  });

  final bool disabled;
  final bool isLarge;
  final String? text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isLarge ? 300 : 100,
      child: AnimatedContainer(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size16,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizes.size24),
          color: disabled ? const Color(0xff88898c) : color ?? Colors.black,
        ),
        duration: const Duration(
          milliseconds: 500,
          // seconds: 5,
        ),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(
            milliseconds: 500,
            // seconds: 5,
          ),
          style: TextStyle(
            color: disabled ? const Color(0xffC1C3C6) : Colors.white,
            fontWeight: FontWeight.w600,
          ),
          child: Text(
            text ?? "Next",
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
