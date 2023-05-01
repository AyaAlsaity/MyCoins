import 'package:flutter/material.dart';

import '../../helpers/consts.dart';

class ButtonScreen extends StatefulWidget {
  const ButtonScreen({
    Key? key,
    required this.isbackround,
    required this.title,
    required this.widthh,
    required this.heightt, 
    required this.paddingg,
  }) : super(key: key);
  final bool isbackround;
  final String title;
  final double widthh;
  final double heightt;
  final double paddingg;

  @override
  State<ButtonScreen> createState() => _ButtonScreenState();
}

class _ButtonScreenState extends State<ButtonScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.heightt,
      width: widget.widthh,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: widget.isbackround ? mainColor : secondeyTextColor,
        border: Border.all(color: mainColor, width: 2),
      ),
     
      child: Padding(
        padding: EdgeInsets.all(widget.paddingg),
       
        child: Text(
          widget.title,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: widget.isbackround ? secondeyTextColor : mainColor),
        ),
      ),
    );
  }
}

//button with icon like sign Out
class ButtonSignOutScreen extends StatefulWidget {
  const ButtonSignOutScreen({
    Key? key,
    required this.isbackround,
    required this.title,
    required this.widthh,
    required this.heightt,
    required this.paddingg,
    this.icon = Icons.exit_to_app_rounded,
    required this.ontap,
  }) : super(key: key);
  final bool isbackround;
  final String title;
  final double widthh;
  final double heightt;
  final double paddingg;
  final IconData icon;
  final VoidCallback ontap;

  @override
  State<ButtonSignOutScreen> createState() => _ButtonSignOutScreenState();
}

//button with Icon
class _ButtonSignOutScreenState extends State<ButtonSignOutScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.ontap,
      child: Container(
        height: widget.heightt,
        width: widget.widthh,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: widget.isbackround ? warningColor : mainTextColor,
          border: Border.all(color: mainColor, width: 2),
        ),
        // ignore: prefer_const_constructors
        child: Padding(
          padding: EdgeInsets.all(widget.paddingg),
          // ignore: prefer_const_constructors
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: widget.isbackround ? mainTextColor : mainColor),
              ),
              const SizedBox(
                width: 15,
              ),
              Icon(widget.icon,
                  color: widget.isbackround ? warningColor : mainColor)
            ],
          ),
        ),
      ),
    );
  }
}
