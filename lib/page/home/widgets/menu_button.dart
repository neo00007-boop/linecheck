import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({
    super.key,
    required this.onTap,
    required this.title,
    required this.active,
  });

  final VoidCallback onTap;
  final String title;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color: active ? Colors.white : Color(0xFF2D73F4),
          borderRadius: BorderRadius.circular(22),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: active ? Color(0xFF2D73F4) : Colors.white,
          ),
        ),
      ),
    );
  }
}
