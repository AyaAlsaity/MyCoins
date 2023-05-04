import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../helpers/consts.dart';
import '../../providers/dark_theme_provider.dart';

class ErrorWwidget extends StatelessWidget {
  String image;
  String error;
  ErrorWwidget({
    Key? key,
    required this.image,
    required this.error,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
        Size size = MediaQuery.of(context).size;
            final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(image,
                       width: double.infinity,
                    height: size.height /2,
                    fit: BoxFit.fill,
                      ),
                     
                       Text(
                       error,
                       style:TextStyle(
                            color: themeListener.isDark
        ? darktitleColor
        : mainTextColor,
        fontWeight: FontWeight.bold,
                          ),
                      ),
                    ],
                  );
  }
}
