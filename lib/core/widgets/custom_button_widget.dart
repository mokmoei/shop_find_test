import 'package:find_shop_test/core/font/font_style.dart';
import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  final void Function()? onPressed;
  final String buttonText;
  final Color? buttonColor;
  final Color? textColor;
  final EdgeInsets? margin;
  final double? fontSize;
  final String? iconPath;
  final TextStyle? textStyle;
  final Color? iconColor;
  final Color? borderColor;

  const CustomButtonWidget({
    super.key,
    this.onPressed,
    required this.buttonText,
    this.buttonColor,
    this.textColor,
    this.margin,
    this.fontSize,
    this.iconPath,
    this.textStyle,
    this.iconColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ButtonStyle(
          elevation: const MaterialStatePropertyAll(0),
          shape: borderColor != null
              ? MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    side: BorderSide(color: borderColor ?? Colors.blue),
                  ),
                )
              : null,
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return buttonColor?.withOpacity(0.3) ?? Colors.blue;
              }
              return buttonColor ?? Colors.blue;
            },
          ),
        ),
        onPressed: onPressed,
        icon: iconPath != null
            ? Image.asset(
                iconPath!,
                width: 16,
                height: 16,
              )
            : const SizedBox.shrink(),
        label: Text(
          buttonText,
          style: textStyle ?? FontAppStyle.fontLargeWhite,
        ),
      ),
    );
  }
}
