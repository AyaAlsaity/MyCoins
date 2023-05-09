import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../helpers/consts.dart';
import '../../main.dart';
import 'package:flutter/material.dart';
import '../../providers/dark_theme_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../providers/get_from_fire_storge_provider.dart';
import '../../widgets/clickable_widgets/button.dart';
import '../../widgets/clickable_widgets/clickacble_text_widget.dart';
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

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  int indexFavorite = 0;

  final GlobalKey<FormState> registerForm = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController listNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController =
      TextEditingController();

  // addUserToFire(var userId,String name,String email) {
  //   firestore.collection('users').add({
  //     'user_id': auth.currentUser!.uid,
  // "name": '${firstNameController.text} ${listNameController.text}',
  // "email": emailController.text.trim(),
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = firestore.collection('users');
    Size size = MediaQuery.of(context).size;
    final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);
    return Consumer<FireStorgeProvoder>(
        builder: (context, coinsFireStorgeConsumer, _) {
      return Scaffold(
          appBar: AppBar(
            elevation: 0,
          ),
          body: SafeArea(
            child: Form(
              key: registerForm,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/logIn6.png',
                      width: double.infinity,
                      height: size.height / 3.3,
                      fit: BoxFit.contain,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        color: themeListener.isDark
                            ? darkBackroundContinarColor
                            : lightBackroundBottomNavigationBarColor
                                .withOpacity(0.5),
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
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 20,
                                  color: themeListener.isDark
                                      ? secondeyTextColor
                                      : Colors.black87,
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
                              controller: listNameController,
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
                              height: sizedBoxNotSameComponents + 5,
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (registerForm.currentState!.validate()) {
                                  if (passwordController.text ==
                                      passwordConfirmationController.text) {
                                    try {
                                      auth
                                          .createUserWithEmailAndPassword(
                                              email: emailController.text,
                                              password: passwordController.text)
                                          .then((value) async {
                                        await coinsFireStorgeConsumer
                                            .addUserToFire(
                                          '${firstNameController.text} ${listNameController.text}',
                                          emailController.text.trim(),
                                        );
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            CupertinoPageRoute(
                                                builder: (context) =>
                                                    const MyApp()),
                                            (route) => false);
                                      });
                                    } on FirebaseAuthException catch (e) {
                                      if (e.code == 'weak-password') {
                                        showCustomFlushbar(
                                            AppLocalizations.of(context)!
                                                .weakpass,
                                            warningColor,
                                            Icons.warning,
                                            context);
                                        // print( "The password provided is too weak.");
                                      } else if (e.code ==
                                          'email-already-in-use') {
                                        showCustomFlushbar(
                                            AppLocalizations.of(context)!
                                                .existsemail,
                                            warningColor,
                                            Icons.warning,
                                            context);

                                        // print( The account already exists for that email.);
                                      }
                                    } catch (e) {
                                      print(e);
                                    }
                                  }
                                }
                              },
                              child: ButtonScreen(
                                isbackround: true,
                                title: AppLocalizations.of(context)!.butt3,
                                widthh: double.infinity,
                                heightt: size.width / 6.5,
                                paddingg: 13,
                              ),
                            ),
                            const SizedBox(
                              height: sizedBoxNotSameComponents + 10,
                            ),
                            ClickableText(
                                text: AppLocalizations.of(context)!.butt2,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            const LoginScreen()),
                                  );
                                }),
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
    });
  }
}
