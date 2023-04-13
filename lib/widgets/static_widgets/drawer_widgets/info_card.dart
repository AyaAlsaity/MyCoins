import 'package:flutter/material.dart';
import 'package:mycoins/helpers/consts.dart';

class Infocard extends StatelessWidget {
  const Infocard({super.key, required this.nameText, required this.emailText});

  final String nameText;
  final String emailText;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Color.fromARGB(255, 230, 222, 222),
        child: Icon(
          Icons.person,
          color: mainColor,
        ),
      ),
      title: Text(
        nameText,
        style: const TextStyle(fontSize: 18, color: Colors.black),
      ),
      subtitle: Text(emailText,
          style: const TextStyle(fontSize: 16, color: Colors.black)),
    );
  }
}
//    