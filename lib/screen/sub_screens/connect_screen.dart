import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mycoins/helpers/consts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../widgets/clickable_widgets/button.dart';
import '../../widgets/input_widgets/text_form_field.dart';
import 'package:http/http.dart' as http;
import '../../widgets/static_widgets/status_dialog_content.dart';

class ConnectScreen extends StatefulWidget {
  const ConnectScreen({super.key});

  @override
  State<ConnectScreen> createState() => _ConnectScreenState();
}

class _ConnectScreenState extends State<ConnectScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController messgeController = TextEditingController();

  void clearTextFormField() {
    nameController.clear();
    emailController.clear();
    subjectController.clear();
    messgeController.clear();
  }

  final GlobalKey<FormState> sendForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: sendForm,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  '${AppLocalizations.of(context)!.send1} :)',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20,
                      color: mainColor,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFieldWidget(
                  label: AppLocalizations.of(context)!.send4,
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  hintText: AppLocalizations.of(context)!.send4,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return AppLocalizations.of(context)!.send7;
                    }
                    return null;
                  },
                  ispassword: false,
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFieldWidget(
                  label: AppLocalizations.of(context)!.email1,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  hintText: AppLocalizations.of(context)!.email2,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return AppLocalizations.of(context)!.email3;
                    }
                    if (!value.contains('@') || !value.contains('.com')) {
                      return AppLocalizations.of(context)!.email4;
                    }
                    return null;
                  },
                  ispassword: false,
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFieldWidget(
                  maxLine: 2,
                  label: AppLocalizations.of(context)!.send2,
                  controller: subjectController,
                  keyboardType: TextInputType.name,
                  hintText: AppLocalizations.of(context)!.send2,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return AppLocalizations.of(context)!.send7;
                    }
                    return null;
                  },
                  ispassword: false,
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFieldWidget(
                  maxLine: 4,
                  label: AppLocalizations.of(context)!.send3,
                  controller: messgeController,
                  keyboardType: TextInputType.name,
                  hintText: AppLocalizations.of(context)!.send3,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return AppLocalizations.of(context)!.send7;
                    }
                    return null;
                  },
                  ispassword: false,
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () async {
                    if (sendForm.currentState!.validate()) {
                      sendEmail(
                        name: nameController.text.toString(),
                        email: emailController.text.toString(),
                        subject: subjectController.text.toString(),
                        message: messgeController.text.toString(),
                      );
                      showCustomFlushbar(
                        '${AppLocalizations.of(context)!.send6} :)',
                        successColor,
                        Icons.check_rounded,
                        context,
                      );
                     
                      Timer(const Duration(seconds: 3), () {
                        Navigator.pop(context);
                      }); 
                    }
                  },
                  child: ButtonScreen(
                    isbackround: true,
                    title: AppLocalizations.of(context)!.send5,
                    widthh: double.infinity,
                    heightt: size.width / 6.5,
                    paddingg: 13,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.web,
                      color: Colors.grey.shade600,
                    ),
                    TextButton(
                      onPressed: () async {
                        String urlWebsit = 'https://www.udemy.com/';
                        if (await canLaunchUrlString(urlWebsit)) {
                          await launchUrlString(
                            urlWebsit,
                          );
                        } else {
                          throw Exception('Could not Launch $urlWebsit');
                        }
                      },
                      child: Text(
                        'https://www.mycoins.com',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future sendEmail({
  required String name,
  required String email,
  required String subject,
  required String message,
}) async {
  const String service_id = 'service_1b73rpa';
  const String template_id = 'template_la7xj1d';
  const String user_id = 'Q2H9SGZ6jrtB3h7Ge';
  final url = Uri.parse(
    'https://api.emailjs.com/api/v1.0/email/send',
  );

  final response = await http.post(
    url,
    headers: {
      'origin': 'http://localhost',
      'Content-Type': 'application/json',
    },
    body: json.encode({
      'service_id': service_id,
      'template_id': template_id,
      'user_id': user_id,
      'template_params': {
        'user_name': name,
        'user_email': email,
        'user_subject': subject,
        'user_message': message,
      }
    }),
  );
  // print(response);
}
