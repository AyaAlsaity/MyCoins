import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mycoins/helpers/consts.dart';
import 'package:provider/provider.dart';
import '../../main.dart';
import '../../providers/dark_theme_provider.dart';
import '../../widgets/clickable_widgets/button.dart';
import '../../widgets/clickable_widgets/clickacble_text_widget.dart';
import '../../widgets/input_widgets/text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'forgot_pass_screen.dart';
import 'sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> loginForm = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final themeFunctions =
        Provider.of<DarkThemeProvider>(context, listen: true);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: darkBackroundScreenColor,
          ),
        ),
        body: SafeArea(
          child: Form(
            key: loginForm,
            // onChanged: () {
            //   setState(() {
            //     buttonEnabled = loginForm.currentState!.validate();
            //   });
            // },
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
                          Center(
                            child: Text(
                              AppLocalizations.of(context)!.butt0,
                              //  ' Log In',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 20,
                                color: themeFunctions.isDark
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
                          const SizedBox(
                            height: sizedBoxNotSameComponents - 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ClickableText(
                                  text: AppLocalizations.of(context)!.forgot1,
                                  fontSize: 11,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) =>
                                                const ForgotPasswordScreen()));
                                  }),
                            ],
                          ),
                          const SizedBox(
                            height: sizedBoxNotSameComponents + 5,
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (loginForm.currentState!.validate()) {
                                auth
                                    .signInWithEmailAndPassword(
                                        email: emailController.text,
                                        password: passwordController.text)
                                    .then((value) async {
                                   Navigator.pushAndRemoveUntil(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) => const MyApp()),
                                      (route) => false);
                                });
                              }
                            },
                            child: ButtonScreen(
                              isbackround: true,
                              title: AppLocalizations.of(context)!.butt0,
                              widthh: double.infinity,
                              heightt: size.width / 7.5,
                              paddingg: 13,
                            ),
                          ),
                          const SizedBox(
                            height: sizedBoxNotSameComponents + 10,
                          ),
                          ClickableText(
                              text: AppLocalizations.of(context)!.butt1,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          const RegisterScreen()),
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
  }
}
