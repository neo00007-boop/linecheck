import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 全局字体
/// 支持放大缩小 全局通知改变字体大小
class FLText extends StatelessWidget {
  final String? text;
  final TextStyle? style;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final TextAlign? textAlign;
  final Color? bgColor;
  final int? maxLines;

  FLText(
    this.text, {
    Key? key,
    this.textAlign,
    this.maxLines,
    this.style,
    this.padding,
    this.margin,
    this.bgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor ?? Color(0x00000000),
      padding: padding ?? EdgeInsets.zero,
      margin: margin ?? EdgeInsets.zero,
      child: Text(text ?? "",
          maxLines: maxLines ?? 100,
          overflow: TextOverflow.ellipsis,
          //设置超过一行显示...
          textAlign: textAlign ?? TextAlign.start,
          softWrap: true,
          textScaleFactor: 1.0,
          style: style ?? TextStyle(fontSize: 13, color: Color(0xFF000000))),
    );
  }
}
