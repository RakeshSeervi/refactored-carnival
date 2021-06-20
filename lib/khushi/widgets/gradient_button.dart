import 'package:bloc_counter/khushi/constants.dart';
import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final String label;
  final void Function()? onPressed;

  const GradientButton({Key? key, required this.label, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: const EdgeInsets.all(0),
      color: secondaryColor,
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              accentColor,
              Color(0x00FFFFFF),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
