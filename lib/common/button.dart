import 'package:flutter/material.dart';

enum ButtonSize {
  large, // 大号
  middle, // 中型
  small, // 小型
}

enum ButtonType {
  primary, // 默认
  grey, // 白色
  text, // 文案
}

class Button extends StatelessWidget {
  const Button({
    super.key,
    this.size = ButtonSize.middle,
    this.width = 0,
    this.height = 0,
    this.margin,
    this.padding,
    this.color,
    this.borderColor,
    this.loading = false,
    this.disabled = false,
    this.type = ButtonType.primary,
    required this.text,
    this.borderRadius,
    this.boxShadow,
    this.fontSize = 0,
    this.fontWeight = FontWeight.w500,
    this.fontColor,
    this.onPressed,
    this.fontFamily,
    this.gradient,
  });

  final ButtonSize size; // 类型
  final double width; // 宽度
  final Color? color; // 容器颜色
  final Color? borderColor; // 边框颜色
  final EdgeInsetsGeometry? margin; //容器层margin
  final EdgeInsetsGeometry? padding; //容器层padding
  final double height; // 高度
  final bool loading; // 是否是loading
  final bool disabled; // 是否禁用
  final ButtonType type; // 类型
  final dynamic text; // 文案
  final BorderRadiusGeometry? borderRadius; // 原角
  final List<BoxShadow>? boxShadow; // 按钮阴影
  final double fontSize; //  文字大小
  final FontWeight? fontWeight; // 文字
  final Color? fontColor; // 文字颜色
  final VoidCallback? onPressed; // 回调方法
  final Gradient? gradient; // 渐变色
  final String? fontFamily;

  // 获取宽度
  double get _width {
    // 优先使用传入值
    if (width != 0) {
      return width;
    }
    if (size == ButtonSize.small) {
      return 96;
    }
    if (size == ButtonSize.middle) {
      return 200;
    }
    return 348;
  }

  // 获取高度
  double get _height {
    // 优先使用传入值
    if (height != 0) {
      return height;
    }
    if (size == ButtonSize.small) {
      return 30;
    }
    if (size == ButtonSize.middle) {
      return 44;
    }
    return 60;
  }

  // 获取字体
  double get _fontSize {
    // 优先使用传入值
    if (fontSize != 0) {
      return fontSize;
    }
    if (size == ButtonSize.small) {
      return 12;
    }
    if (size == ButtonSize.middle) {
      return 14;
    }
    return 16;
  }

  //
  bool get _isPrimary => type == ButtonType.primary;

  // 是否禁用
  bool get _disabled => disabled || loading;

  // 透明度
  double get _opacity {
    if (_isPrimary) return 1;
    return _disabled ? 0.5 : 1;
  }

  // 类型
  ButtonType get _type {
    if (_isPrimary && _disabled) {
      return ButtonType.grey;
    }
    return type;
  }

  @override
  Widget build(BuildContext context) {
    // 灰色类型
    bool isTypeGrey = _type == ButtonType.grey;
    // 文案类型
    bool isTypeText = _type == ButtonType.text;
    // 自定义颜色
    bool isCustomize = color != null;

    return InkWell(
      onTap: _disabled
          ? null
          : () {
              FocusScope.of(context).requestFocus(FocusNode());
              onPressed!();
            },
      child: Container(
        alignment: Alignment.center,
        margin: margin ?? const EdgeInsets.all(0),
        padding: padding ?? const EdgeInsets.all(0),
        width: _width,
        height: _height,
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(4),
          border: isTypeText && !isCustomize
              ? Border.all(
                  width: 1,
                  color: (borderColor ?? Colors.white38).withValues(
                    alpha: _opacity,
                  ), //
                )
              : null,
          gradient:
              gradient ??
              (type == ButtonType.primary
                  ? LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.white38, Colors.white38],
                    )
                  : null),
          color: gradient != null
              ? null
              : isTypeGrey
              ? (type == ButtonType.primary ? Colors.white38 : Colors.white38)
              : color ?? Colors.white38,
          boxShadow: boxShadow,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (loading)
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                child: _loading(_height / 2.6),
              ),
            if (text is String)
              Text(
                text,
                style: TextStyle(
                  fontSize: _fontSize,
                  fontWeight: fontWeight,
                  fontFamily: fontFamily,
                  color:
                      fontColor ??
                      (type == ButtonType.primary && _disabled
                          ? Colors.white.withValues(alpha: 0.7)
                          : (isTypeText
                                ? (borderColor ?? Colors.white).withValues(
                                    alpha: _opacity,
                                  )
                                : isTypeGrey
                                ? Colors.grey
                                : Colors.white.withValues(alpha: _opacity))),
                ),
              ),
            if (text is Widget) text,
          ],
        ),
      ),
    );
  }

  Widget _loading(double width) {
    return SizedBox(
      width: width,
      height: width,
      child: CircularProgressIndicator(),
    );
  }
}
