import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import '../../helpers/consts.dart';

Future showCustomFlushbar(
    String message, Color color, IconData icon, BuildContext context) async {
  Flushbar(
    message: message,
    icon: Icon(
      icon,
      size: 28.0,
      color: mainColor,
    ),
    margin: const EdgeInsets.all(6.0),
    flushbarStyle: FlushbarStyle.FLOATING,
    flushbarPosition: FlushbarPosition.TOP,
    textDirection: Directionality.of(context),
    borderRadius: BorderRadius.circular(12),
    duration: const Duration(seconds: 2),
    leftBarIndicatorColor: color,
  ).show(context);
}


//  Future<void> errorDialog({
//     required String subtitle,
//     required BuildContext context,
//   }) async {
//     await showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: Row(children: const [
//               SizedBox(
//                 width: 8,
//               ),
//               Text('حدث خطاء'),
//             ]),
//             content: Text(subtitle),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   if (Navigator.canPop(context)) {
//                     Navigator.pop(context);
//                   }
//                 },
//                 child: TextWidget(
//                   color: Colors.cyan,
//                   text: 'الغاء',
//                   textSize: 18,
//                 ),
//               ),
//                 TextButton(
//                 onPressed: () {
//                   if (Navigator.canPop(context)) {
//                     Navigator.pop(context);
//                   }
//                 },
//                 child: TextWidget(
//                   text: 'نعم',
//                   textSize: 18,
//                   color: Colors.cyan,
//                 ),
//               ),
//             ],
//           );
// });}

