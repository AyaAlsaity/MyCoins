import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../../helpers/consts.dart';
import '../../main.dart';
import 'package:flutter/material.dart';
import '../../widgets/clickable_widgets/button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../widgets/input_widgets/text_form_field.dart';
import '../../widgets/static_widgets/status_dialog_content.dart';
import 'sign_in_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  // FirebaseFirestore firestore = FirebaseFirestore.instance;

  final GlobalKey<FormState> registerForm = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController listNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);
    return Scaffold(
        backgroundColor: lightBackroundScreenColor,
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () => showCustomFlushbar(
        //       AppLocalizations.of(context)!.pass7,
        //       Colors.red,
        //       Icons.error,
        //       context),
        // ),
        body: SafeArea(
          child: Form(
            key: registerForm,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/logIn5.png',
                    width: double.infinity,
                    height: size.height / 3.3,
                    fit: BoxFit.contain,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      color: secondeyTextColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(paddingAll + 5),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: sizedBoxNotSameComponents,
                          ),
                          Center(
                            child: Text(
                              AppLocalizations.of(context)!.butt3,
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 20,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: sizedBoxNotSameComponents,
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
                              if (!value.contains('@') ||
                                  !value.contains('.com')) {
                                return AppLocalizations.of(context)!.email4;
                              }
                              return null;
                            },
                            ispassword: false,
                          ),
                          TextFieldWidget(
                            label: AppLocalizations.of(context)!.pass1,
                            hintText: AppLocalizations.of(context)!.pass2,
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return AppLocalizations.of(context)!.pass3;
                              }
                              if (value.length < 8) {
                                return AppLocalizations.of(context)!.pass4;
                              }
                              return null;
                            },
                            ispassword: true,
                          ),
                          TextFieldWidget(
                            label: AppLocalizations.of(context)!.pass8,
                            hintText: AppLocalizations.of(context)!.pass2,
                            controller: passwordConfirmationController,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return AppLocalizations.of(context)!.pass3;
                              }
                              if (value.length < 8) {
                                return AppLocalizations.of(context)!.pass4;
                              }
                              return null;
                            },
                            ispassword: true,
                          ),
                          TextFieldWidget(
                            label: AppLocalizations.of(context)!.name1,
                            controller: firstNameController,
                            keyboardType: TextInputType.name,
                            hintText: AppLocalizations.of(context)!.name2,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return AppLocalizations.of(context)!.name3;
                              }
                              return null;
                            },
                            ispassword: false,
                          ),
                          TextFieldWidget(
                            label: AppLocalizations.of(context)!.name4,
                            controller: firstNameController,
                            keyboardType: TextInputType.name,
                            hintText: AppLocalizations.of(context)!.name5,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return AppLocalizations.of(context)!.name6;
                              }
                              return null;
                            },
                            ispassword: false,
                          ),
                          const SizedBox(
                            height: sizedBoxNotSameComponents,
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (registerForm.currentState!.validate()) {
                                if (passwordController.text ==
                                    passwordConfirmationController.text) {
                                  await auth
                                      .createUserWithEmailAndPassword(
                                          email: emailController.text,
                                          password: passwordController.text)
                                      .then((value) async {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) =>
                                                const MyApp()),
                                        (route) => false);
                                  });
                                } else {
                                  showCustomFlushbar(
                                      AppLocalizations.of(context)!.pass7,
                                      Colors.red,
                                      Icons.error,
                                      context);
                                }
                              }
                            },
                            child: ButtonScreen(
                              isbackround: true,
                              title: AppLocalizations.of(context)!.butt3,
                              // widthh: 560,
                              // heightt: 50,
                              widthh: double.infinity,
                              heightt: size.width / 7.3,
                              paddingg: 13,
                            ),
                          ),
                          const SizedBox(
                            height: sizedBoxSameComponents,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => const LoginScreen()),
                              );
                            },
                            child: ButtonScreen(
                              isbackround: false,
                              title: AppLocalizations.of(context)!.butt2,
                              widthh: double.infinity,
                              heightt: size.width / 7.3,
                              paddingg: 13,
                            ),
                          ),
                          //  Row TextButton
                          const SizedBox(
                            height: sizedBoxNotSameComponents,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
