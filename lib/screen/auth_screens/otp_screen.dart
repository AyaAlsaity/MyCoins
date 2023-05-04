import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mycoins/screen/auth_screens/reset_password.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../helpers/consts.dart';


class OtpScreen extends StatefulWidget {
  const OtpScreen({
    super.key,
  });
  // final String phoneNumber;
  // final String nextBtnText;

  // final Function onNext;
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  void initState() {
    // if (kDebugMode) {
    //   print("send otp to ${widget.phoneNumber}");
    // }
    super.initState();
  }

  TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // Color mainColor = const Color(0xFFF5C249);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: darkBackroundScreenColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  AppLocalizations.of(context)!.conficode,
                  // "Confirmation Code",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Text(
                  AppLocalizations.of(context)!.wjsaotrea,
                  // " We just sent an OTP to your registered email address ",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                // const Text(
                //   " widget.email",
                //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                // ),
                SizedBox(
                  height: size.height * 0.01,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(paddingAll + 5),
              child: SizedBox(
                width: size.width * 0.95,
                height: size.height * 0.2,
                child: Center(
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: PinCodeTextField(
                      enablePinAutofill: true,
                      cursorColor: mainColor,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                      ],
                      length: 6,
                      obscureText: false,
                      keyboardType: TextInputType.number,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(13)),
                          disabledColor: mainColor.withOpacity(0.5),
                          inactiveColor: mainColor.withOpacity(0.2),
                          borderWidth: 1,
                          inactiveFillColor: mainColor.withOpacity(0.09),
                          errorBorderColor: warningColor,
                          selectedColor: mainColor,
                          selectedFillColor: mainColor.withOpacity(0.2),
                          activeColor: mainColor,
                          shape: PinCodeFieldShape.box,
                          fieldHeight: size.width / 7,
                          fieldWidth: size.width / 7,
                          activeFillColor: mainColor.withOpacity(0.2)),
                      animationDuration: const Duration(milliseconds: 300),
                      backgroundColor: Colors.transparent,
                      enableActiveFill: true,
                      controller: otpController,
                      hintCharacter: '',
                      textStyle: const TextStyle(color: mainColor, fontSize: 20),
                      hintStyle: const TextStyle(
                          fontSize: 24,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold),
                      onCompleted: (v) async {
                        if (kDebugMode) {
                          print("Completed $v");
                        }
                      },
                      onChanged: (value) {
                        if (kDebugMode) {
                          print('The Code is $value');
                        }
                        if (mounted) setState(() {});
                      },
                      appContext: context,
                    ),
                  ),
                ),
              ),
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    // initState();
                  },
                  child: Text(
                    AppLocalizations.of(context)!.dgacr,
                    // "Didnt get a code? Resend ",
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        color: mainColor),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                // MainButton(
                //     text: AppLocalizations.of(context)!.veotp,
                //     withBorder: false,
                //     onPressed: () {
                //       Navigator.push(
                //           context,
                //           CupertinoPageRoute(
                //               builder: (context) =>
                //                   const ResetPasswordScreen()));
                //     }),
                const SizedBox(
                  height: 10,
                ),
                // MainButton(
                //     text: 'back',
                //     withBorder: true,
                //     onPressed: () {
                //       Navigator.pop(context);
                //     }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
