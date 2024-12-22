import 'package:flutter/material.dart';

import '../../../../core/constants/app_font_size.dart';
import '../../../../core/constants/app_spacing.dart';

class IconWithText extends StatelessWidget {
  final double? width;
  final IconData icon;
  final Color? iconColor;
  final String text;
  final double? iconSize;
  final Color? fontColor;
  final double? fontSize;
  final FontStyle? fontStyle;
  final FontWeight? fontWeight;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final BorderRadius? borderRadius;
  final Alignment? alignment;
  final TextAlign? textAlign;

  const IconWithText({
    super.key,
    required this.icon,
    required this.text,
    this.iconColor,
    this.iconSize,
    this.fontSize,
    this.fontColor,
    this.fontWeight,
    this.backgroundColor,
    this.padding,
    this.margin,
    this.borderRadius,
    this.alignment,
    this.fontStyle,
    this.width,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      alignment: alignment,
      decoration:
          BoxDecoration(color: backgroundColor, borderRadius: borderRadius),
      padding: padding,
      margin: margin,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: iconColor,
            size: iconSize,
          ),
          const SizedBox(width: AppSpacing.marginS),
          Flexible(
            child: Text(
              text,
              style: TextStyle(
                color: fontColor,
                fontWeight: fontWeight,
                fontSize: fontSize ?? AppFontSize.h1,
                fontStyle: fontStyle,
              ),
              textAlign: textAlign,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
