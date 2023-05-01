import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mycoins/screen/auth_screens/sign_in_screen.dart';
import 'package:mycoins/widgets/clickable_widgets/button.dart';
import 'package:mycoins/widgets/static_widgets/custom_dialog.dart';
import 'package:provider/provider.dart';

import '../../helpers/consts.dart';
import '../../providers/dark_theme_provider.dart';
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
    final themeFunctions =
        Provider.of<DarkThemeProvider>(context, listen: true);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: darkBackroundScreenColor,
        ),
        // elevation: 0,
        // backgroundColor: Colors.white,
        // iconTheme: const IconThemeData(color: mainColor),
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          
          children: [
            SizedBox(
              height: size.height * 0.15,
            ),
            Center(
              child: Text(
                AppLocalizations.of(context)!.fogottiti,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: themeFunctions.isDark
                        ? darktitleColor
                        : mainTextColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Center(
              child: Text(
                AppLocalizations.of(context)!.fogotsubtiti,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: themeFunctions.isDark
                        ? darktitleColor
                        : mainTextColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 16),
              ),
            ),
            SizedBox(
              height: size.height * 0.150,
            ),

 Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    color: themeFunctions.isDark
                        ? darkBackroundContinarColor
                        : secondeyTextColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(paddingAll + 5),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: sizedBoxNotSameComponents,
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
                      height: size.height * 0.1,
                    ),
                    GestureDetector(
                      onTap: () {
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
                                          builder: (context) => const LoginScreen()));
                                },
                                image: Image.asset("assets/images/white_success.png"),
                              );
                            });
                      },
                      child: ButtonScreen(
                          isbackround: true,
                          title: AppLocalizations.of(context)!.contin,
                          widthh: double.infinity,
                          heightt: size.width / 7.5,
                          paddingg: 13),
                    ),
              
                       const SizedBox(
                          height: sizedBoxNotSameComponents,
                        ),
                      ],
                    ),
                  ),
                ),
              



           
            // MainButton(
            //     // isActive: false,
            //     text: AppLocalizations.of(context)!.contin,
            //     withBorder: false,
            //     onPressed: () {
            //       passwordReset();
            //       showDialog(
            //           context: context,
            //           builder: (context) {
            //             return CustomDialog(
            //               title: "title",
            //               subtitle: AppLocalizations.of(context)!.wjslyrea,
            //               // " We just sent an link to your registered email address ",
            //               btnText: AppLocalizations.of(context)!.butt0,
            //               onpress: () {
            //                 Navigator.push(
            //                     context,
            //                     CupertinoPageRoute(
            //                         builder: (context) =>
            //                             const LoginScreen()));
            //               },
            //               image:
            //                   Image.asset("assets/images/white_success.png"),
            //             );
            //           });
            //       // Navigator.push(
            //       //     context,
            //       //     CupertinoPageRoute(
            //       //         builder: (context) => const OtpScreen()));
            //     }),
          ],
        ),
      )),
    );
  }
}
