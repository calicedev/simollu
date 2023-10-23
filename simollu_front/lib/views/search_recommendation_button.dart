import 'package:flutter/material.dart';

class SearchRecommendationButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  const SearchRecommendationButton({super.key, required this.text, required this.onPressed});

  @override
  State<SearchRecommendationButton> createState() => _SearchRecommendationButtonState();
}

class _SearchRecommendationButtonState extends State<SearchRecommendationButton> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        widget.onPressed();
      },
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        side: BorderSide(
          color: Colors.black38,
          width: 0.9,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // 원하는 radius 값으로 설정
        ),
      ),
      child: Text(
        widget.text,
        style: TextStyle(
          color: Colors.black,
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
