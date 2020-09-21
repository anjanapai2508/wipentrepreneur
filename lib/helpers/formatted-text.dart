import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormattedText extends StatelessWidget {
  final String title;
  final double textSize;
  final Color textColor;
  final TextAlign alignment;
  const FormattedText(
      this.title, this.textSize, this.textColor, this.alignment);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: alignment,
      maxLines: 3,
      style: GoogleFonts.openSans(
        textStyle: TextStyle(
            color: textColor,
            fontSize: textSize,
            decoration: TextDecoration.none),
      ),
    );
  }
}
