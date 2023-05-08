import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mycoins/screen/auth_screens/successful_reset%20.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../helpers/consts.dart';
import '../../providers/dark_theme_provider.dart';
import '../../widgets/input_widgets/text_form_field.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
     final themeFunctions =
        Provider.of<DarkThemeProvider>(context, listen: true);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        // systemOverlayStyle: const SystemUiOverlayStyle(
        //   statusBarColor: darkBackroundScreenColor,
        // ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(paddingAll + 5),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration:  BoxDecoration(
                  color: themeFunctions.isDark ? darkBackroundScreenColor: lightBackroundScreenColor,
                  borderRadius:const BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Image.asset(
                  'assets/images/resetpassw.png',
                  width: size.width * 0.6,
                  height: size.height * 0.4,
                ),
              ),
              Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!.resttitl,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      AppLocalizations.of(context)!.restsub,
                      style: const TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextFieldWidget(
                      controller: passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppLocalizations.of(context)!.pass3;
                        }
                        if (value.length < 8) {
                          return AppLocalizations.of(context)!.pass4;
                        }
                        return null;
                      },
                      label: AppLocalizations.of(context)!.pass1,
                      hintText: AppLocalizations.of(context)!.pass3,
                      ispassword: true,
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    TextFieldWidget(
                      controller: passwordConfirmationController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppLocalizations.of(context)!.pass3;
                        }
                        if (value.length < 8) {
                          return AppLocalizations.of(context)!.pass4;
                        }
                        if (value != passwordController.text) {
                          return AppLocalizations.of(context)!.pass7;
                        }
                        return null;
                      },
                      label: AppLocalizations.of(context)!.pass8,
                      hintText: AppLocalizations.of(context)!.pass3,
                      ispassword: true,
                      keyboardType: TextInputType.text,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              // MainButton(
              //     text: AppLocalizations.of(context)!.contin,
              //     withBorder: false,
              //     onPressed: () {
              //       Navigator.push(
              //           context,
              //           CupertinoPageRoute(
              //               builder: (context) => const ResetSuccessful()));
              //     }),
            ],
          ),
        ),
      ),
    );
  }
}
