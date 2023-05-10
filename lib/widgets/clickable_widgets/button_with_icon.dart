import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/consts.dart';
import '../../providers/dark_theme_provider.dart';

class ButtonWithIcon extends StatefulWidget {
  const ButtonWithIcon({
    super.key,
    required this.text,
    required this.icon,
    required this.width,
    required this.height,
    required this.withborder,
  });
  final String text;
  final IconData icon;
  final double width;
  final double height;
  final bool withborder;

  @override
  State<ButtonWithIcon> createState() => _ButtonWithIconState();
}

class _ButtonWithIconState extends State<ButtonWithIcon> {
  @override
  Widget build(BuildContext context) {
    final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
          color: widget.withborder
              ? themeListener.isDark
                  ? darkBackroundScreenColor
                  : secondeyTextColor
              : mainColor,
       

          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: widget.withborder ? mainColor : mainColor, width: 2)),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const SizedBox(
          width: sizedBoxSameComponents + 10,
        ),
        Icon(
          widget.icon,
       
          color:
        
              widget.withborder ? darkBackroundScreenColor : secondeyTextColor,
        ),
        const SizedBox(
          width: sizedBoxSameComponents + 10,
        ),
        Text(
          widget.text,
       
          style: TextStyle(
              color:
                  widget.withborder ? darkBackroundScreenColor : darktitleColor,
              fontSize: 20,
              fontWeight: FontWeight.w600),
        ),
      ]),
    );
  }
}
