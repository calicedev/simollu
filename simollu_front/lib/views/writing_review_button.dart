import 'package:flutter/material.dart';
import 'package:simollu_front/viewmodels/preference_view_model.dart';

class WritingReviewButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  bool isPressed = false;

  WritingReviewButton({required this.text, required this.onPressed, required this.isPressed,});

  @override
  _WritingReviewButtonState createState() => _WritingReviewButtonState();
}

class _WritingReviewButtonState extends State<WritingReviewButton> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: OutlinedButton(
        onPressed: () {
          widget.onPressed();
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: widget.isPressed ? Color(0xFFFFD200) : Colors.white,
          side: BorderSide(
            color: widget.isPressed ? Color(0xFFFFD200) : Colors.black38,
            width: 0.5
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          )
        ),
        child: Container(
          padding: EdgeInsets.only(top: 17, bottom: 17, left: 18, right: 18),
          child: Text(
            widget.text,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Roboto',
              fontSize: 20,
              fontWeight: widget.isPressed ? FontWeight.bold : FontWeight.normal,
              fontStyle: FontStyle.normal,
              // letterSpacing: 0,
              // wordSpacing: 0,
              height: 1.0,
              shadows: [],
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }
}
// Color(0xffFFD200)