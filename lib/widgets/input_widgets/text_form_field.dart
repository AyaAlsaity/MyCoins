import 'package:flutter/material.dart';

import '../../helpers/consts.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget(
      {super.key,
      required this.controller,
      this.label,
      required this.validator,
      required this.hintText,
      this.obSecureText = false,
      this.readOnlyy=false,
      this.perfix, required this.ispassword, required this.keyboardType});
  final TextEditingController controller;
  final String? label;
  final String hintText;
  final FormFieldValidator<String?> validator;
  final bool ispassword ;
  final TextInputType keyboardType;

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
                      fontSize: 16, fontWeight: FontWeight.w500,
                      color: mainTextColor.withOpacity(0.5)),
                ),
              ],
            ),
          const SizedBox(
            height: 5,
          ),
          
          TextFormField(
            
              controller: widget.controller,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: widget.validator,
              obscureText: widget.ispassword? ispasswordshow:widget.obSecureText,
              keyboardType:widget.keyboardType,
              readOnly :widget.readOnlyy,

              decoration: InputDecoration(
            
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 13.0, horizontal: 16),
                suffixIcon:widget.ispassword? IconButton(
              onPressed: () {
                setState(() {
                  ispasswordshow = !ispasswordshow;
                });
              },
              icon: Icon(
                // ignore: dead_code
                ispasswordshow ? Icons.visibility : Icons.visibility_off,
              ),
            ):widget.perfix,
                fillColor: lightBackroundScreenColor,
                filled: true,
                hintText: widget.hintText,
                hintStyle:const TextStyle(
                  color: greyTextColor,
                  fontSize: 12,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide:
                        const BorderSide(color:lightBackroundScreenColor)),
                focusColor: lightBackroundScreenColor,
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: warningColor)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide:
                        const BorderSide(color: lightBackroundScreenColor)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide:
                        const BorderSide(color: lightBackroundScreenColor)),
              ))
        ],
      ),
    );
  }
}