import 'package:flutter/material.dart';

Widget customText(
  String text, {
  Color? color,
  double fontSize = 14,
  double? letterSpacing,
  double? height,
  TextAlign? textAlign,
  int? maxLines,
  TextOverflow overflow = TextOverflow.ellipsis,
  TextDecoration? decoration,
  FontWeight? fontWeight = FontWeight.w400,
  String fontFamily = 'Lufga',
  bool blur = false,
  TextStyle? style, // <-- Add this line
  BuildContext? context,
}) {
  return Text(
    text,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: overflow,
    softWrap: true,
    style:
        style ??
        Theme.of(context!).textTheme.bodyLarge!.copyWith(
          fontFamily: fontFamily,
          color: color,
          letterSpacing: letterSpacing,
          fontSize: fontSize,
          height: height,
          fontWeight: fontWeight,
          decoration: decoration,
        ),
  );
}
