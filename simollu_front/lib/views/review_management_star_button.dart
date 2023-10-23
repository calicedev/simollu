import 'package:flutter/material.dart';

class ReviewStarBox extends StatefulWidget {
  final String text;

  ReviewStarBox({required this.text});

  @override
  _ReviewStarBoxState createState() => _ReviewStarBoxState();
}

class _ReviewStarBoxState extends State<ReviewStarBox> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: widget.text == '기다릴만해요' ? Color(0xffFFD200) : Colors.white,
        borderRadius: BorderRadius.circular(5.0),
      ),
        child: Text(
          widget.text,
          style: TextStyle(
            color: widget.text == '기다릴만해요' ? Colors.white : Colors.black,
            fontFamily: 'Roboto',
            fontSize: 13,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
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
//backgroundColor: Color(0xffFFD200),