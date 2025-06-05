import 'package:flutter/material.dart';
import 'package:groc_shopy/utils/app_colors/app_colors.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double width;
  final double height;
  final Color backgroundColor;
  final Color? disabledBackgroundColor;
  final double borderRadius;
  final TextStyle textStyle;
  final bool enabled;

  const AppButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.width = double.infinity,
    this.height = 48,
    this.backgroundColor = AppColors.primary, // default yellow color
    this.disabledBackgroundColor,
    this.borderRadius = 8,
    required this.textStyle,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = enabled && onPressed != null;
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled
              ? backgroundColor
              : (disabledBackgroundColor ?? backgroundColor.withOpacity(0.4)),
          disabledBackgroundColor:
              disabledBackgroundColor ?? backgroundColor.withOpacity(0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: 0,
        ),
        child: Text(text, style: textStyle),
      ),
    );
  }
}
