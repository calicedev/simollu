import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  late bool isPressed;

  CustomButton(
      {required this.text, required this.onPressed, required this.isPressed});

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return buildOutlinedButton();
  }

  OutlinedButton buildOutlinedButton() {
    return OutlinedButton(
      onPressed: () {
        widget.onPressed();
      },
      style: OutlinedButton.styleFrom(
        backgroundColor: widget.isPressed ? Color(0xFFFFD200) : Colors.white,
        side: BorderSide(
          color: widget.isPressed ? Color(0xFFFFD200) : Colors.black54,
          width: 1.0,
        ),
      ),
      child: Text(
        widget.text,
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'Roboto',
          fontSize: widget.isPressed ? 17 : 15,
          // fontWeight: FontWeight.bold,
          fontWeight: widget.isPressed ? FontWeight.bold : FontWeight.normal,
          letterSpacing: 0,
          wordSpacing: 0,
          height: 1.0,
          shadows: [],
          decoration: TextDecoration.none,
        ),
      ),
    );
  }
}
// Color(0xffFFD200)