import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mycoins/screen/sub_screens/sign_in_screen.dart';
import 'package:mycoins/widgets/static_widgets/Custom_dialog.dart';

import '../../helpers/consts.dart';
import '../../widgets/clickable_widgets/main_button_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../widgets/input_widgets/text_form_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  Future passwordReset() async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: emailController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: mainColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(paddingAll + 5),
        child: Center(
            child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.125,
              ),
              Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!.fogottiti,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Text(
                    AppLocalizations.of(context)!.fogotsubtiti,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 16),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.185,
              ),
              TextFieldWidget(
                controller: emailController,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return AppLocalizations.of(context)!.email3;
                  }

                  if (!value.contains('.com') || !value.contains('@')) {
                    return AppLocalizations.of(context)!.email4;
                  }

                  return null;
                },
                label: AppLocalizations.of(context)!.email1,
                hintText: AppLocalizations.of(context)!.email2,
                ispassword: false,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: size.height * 0.2,
              ),
              MainButton(
                  // isActive: false,
                  text: AppLocalizations.of(context)!.contin,
                  withBorder: false,
                  onPressed: () {
                    passwordReset();
                    showDialog(
                        context: context,
                        builder: (context) {
                          return CustomDialog(
                            title: "title",
                            subtitle: AppLocalizations.of(context)!.wjslyrea,
                            // " We just sent an link to your registered email address ",
                            btnText: AppLocalizations.of(context)!.butt0,
                            onpress: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()));
                            },
                            image:
                                Image.asset("assets/images/white_success.png"),
                          );
                        });
                    // Navigator.push(
                    //     context,
                    //     CupertinoPageRoute(
                    //         builder: (context) => const OtpScreen()));
                  }),
            ],
          ),
        )),
      ),
    );
  }
}
