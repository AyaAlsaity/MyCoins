import 'package:flutter/material.dart';

import '../../helpers/consts.dart';
import '../clickable_widgets/main_button_widget.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.btnText,
      required this.onpress,
      required this.image});
  final String title;
  final String subtitle;
  final String btnText;
  final VoidCallback onpress;
  final Widget image;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            SizedBox(
              height: 250,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                child: Column(
                    // crossAxisAlignment:
                    //     CrossAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const SizedBox(
                        height: sizedBoxSameComponents,
                      ),
                      Text(
                        subtitle,
                        // " We just sent an link to your registered email address ",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18),
                      ),
                      const SizedBox(
                        height: sizedBoxNotSameComponents,
                      ),
                      MainButton(
                          text: btnText,
                          // "login ",
                          onPressed: () {
                            onpress;
                          })
                    ]),
              ),
            ),
            Positioned(
              top: -60,
              child: CircleAvatar(
                backgroundColor: mainColor,
                radius: 60,
                child: image,
              ),
            )
          ]),
    );
  }
}
