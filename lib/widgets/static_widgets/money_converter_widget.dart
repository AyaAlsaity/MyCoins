
import 'package:flutter/material.dart';

import 'Custom_dialog.dart';

class moneyConverter extends StatefulWidget {
  const moneyConverter({super.key});

  @override
  State<moneyConverter> createState() => _moneyConverterState();
}

class _moneyConverterState extends State<moneyConverter> {
  @override
  Widget build(BuildContext context) {
    return CustomDialog(btnText: 'Alsaity', image: Image.asset('assets/images/logIn6.png'), onpress: () {  }, subtitle: 'ayaAlsaity', title: 'Aya',);
  }
}