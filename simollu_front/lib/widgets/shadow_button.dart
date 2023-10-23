import 'package:flutter/material.dart';

class ShadowButton extends StatelessWidget {
  final Widget child;
  final Function event;
  final int color;

  ShadowButton({
    super.key,
    required this.child,
    required this.event,
    required this.color,
  });

  void onTap() {
    event();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Color(color),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                blurRadius: 2,
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 2,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}
