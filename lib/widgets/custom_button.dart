import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({this.onTap , required this.text});
  final String text;
  VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        width: double.infinity,
        height: 60,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 24,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
