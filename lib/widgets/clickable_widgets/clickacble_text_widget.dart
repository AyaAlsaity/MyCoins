import 'package:flutter/material.dart';
import 'package:mycoins/helpers/consts.dart';

class ClickableText extends StatefulWidget {
  const ClickableText({
    Key? key,
    required this.text,
    required this.onPressed,
    this.fontSize = 14,
    this.color = mainColor,
    this.useColors = false,
    this.enabled = true,
    this.withUnderline = false,
  }) : super(key: key);
  final String text;
  final VoidCallback onPressed;
  final double fontSize;
  final Color color;
  final bool useColors;
  final bool enabled;
  final bool withUnderline;

  @override
  State<ClickableText> createState() => _ClickableTextState();
}

class _ClickableTextState extends State<ClickableText> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () {
          if (widget.enabled) widget.onPressed();
        },
        child: Text(
          widget.text,
          style: TextStyle(
              fontSize: widget.fontSize,
              fontWeight: FontWeight.w600,
              color: mainColor,
              decoration:
                  widget.withUnderline ? TextDecoration.underline : null),
        ),
      ),
    );
  }
}
