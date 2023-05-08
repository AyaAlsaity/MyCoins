import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/consts.dart';
import '../../providers/dark_theme_provider.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget(
      {super.key,
      required this.controller,
      this.label,
      required this.validator,
      required this.hintText,
      this.obSecureText = false,
      this.readOnlyy = false,
      this.perfix,
      required this.ispassword,
      this.maxLine=1,
      required this.keyboardType});
  final TextEditingController controller;
  final String? label;
  final String hintText;
  final FormFieldValidator<String?> validator;
  final bool ispassword;
  final TextInputType keyboardType;
  final int maxLine;
  final bool obSecureText;
  final bool readOnlyy;
  final Widget? perfix;
  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool ispasswordshow = true;
  @override
  Widget build(BuildContext context) {
    final themeFunctions =
        Provider.of<DarkThemeProvider>(context, listen: true);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          if (widget.label != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.label ?? "",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color:themeFunctions.isDark ? secondeyTextColor : darkBackroundScreenColor),
                ),
              ],
            ),
          const SizedBox(
            height: 5,
          ),
          TextFormField(
            maxLines :widget.maxLine,
              controller: widget.controller,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: widget.validator,
              obscureText:
                  widget.ispassword ? ispasswordshow : widget.obSecureText,
              keyboardType: widget.keyboardType,
              readOnly: widget.readOnlyy,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 13.0, horizontal: 16),
                suffixIcon: widget.ispassword
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            ispasswordshow = !ispasswordshow;
                          });
                        },
                        icon: Icon(
                           
                            ispasswordshow
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: mainColor
                            
                            ),
                      )
                    : widget.perfix,
                fillColor: themeFunctions.isDark
                    ? Colors.white30
                    : lightBackroundScreenColor,
                filled: true,
                hintText: widget.hintText,
                hintStyle: TextStyle(
                  color: themeFunctions.isDark ? Colors.white54 : greyTextColor,
                  fontSize: 12,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: themeFunctions.isDark
                          ? Colors.white30
                          : lightBackroundScreenColor,
                    )),
                focusColor: themeFunctions.isDark
                    ? Colors.white30
                    : lightBackroundScreenColor,
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: warningColor)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: themeFunctions.isDark
                          ? Colors.white30
                          : lightBackroundScreenColor,
                    )),
                // enabledBorder: OutlineInputBorder(
                //     borderRadius: BorderRadius.circular(15),
                //     borderSide: BorderSide(
                //       color: themeFunctions.isDark
                //           ? Colors.white30
                //           : lightBackroundScreenColor,
                //     )),
              ))
        ],
      ),
    );
  }
}
