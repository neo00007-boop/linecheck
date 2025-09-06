import 'package:flutter/material.dart';
import 'package:super_tooltip/super_tooltip.dart';

///带箭头的提示框
class MyTooltip extends StatefulWidget {
  const MyTooltip({
    super.key,
    required this.fromChild,
    required this.tipsChild,
    required this.controller,
    this.popupDirection = TooltipDirection.down,
    this.leftMargin = 50,
  });

  final Widget fromChild; // 弹出的位置view
  final Widget tipsChild; // 展示的弹窗
  final TooltipDirection popupDirection; // 默认在上面弹出
  final double leftMargin; //弹出位置和左边的间距
  final SuperTooltipController controller;

  @override
  State<MyTooltip> createState() => _MyTooltipState();
}

class _MyTooltipState extends State<MyTooltip> {

  /*@override
  void initState() {
    super.initState();
    _controller = SuperTooltipController();
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }*/

  @override
  Widget build(BuildContext context) {
    return SuperTooltip(
      controller: widget.controller,
      popupDirection: widget.popupDirection,
      showBarrier: true,
      hasShadow: false,
      arrowBaseWidth: 16,
      arrowLength: 7,
      arrowTipDistance: 22,
      borderRadius: 4,
      top: -10,
      right: -10,
      barrierColor: Colors.transparent,
      borderColor: Colors.grey,
      content: widget.tipsChild,
      backgroundColor: Colors.white,
      child: GestureDetector(
        onTap: () {
          if (!widget.controller.isVisible) {
            widget.controller.showTooltip();
          } else {
            widget.controller.hideTooltip();
          }
        },
        child: widget.fromChild,
      ),
    );
  }
}
