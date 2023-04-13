import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../widgets/clickable_widgets/button.dart';
import '../sub_screens/sign_in_screen.dart';

class ResetSuccessful extends StatefulWidget {
  const ResetSuccessful({super.key});

  @override
  State<ResetSuccessful> createState() => _ResetSuccessfulState();
}

class _ResetSuccessfulState extends State<ResetSuccessful> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(80.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Image.asset(
                'assets/images/success.png',
                width: size.width * 0.6,
                height: size.height * 0.4,
              ),
            ),
            Column(
              children: [
                Text(
                  AppLocalizations.of(context)!.rstsuss,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    AppLocalizations.of(context)!.ycnlitya,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonSignOutScreen(
                  isbackround: false,
                  title: AppLocalizations.of(context)!.butt0,
                  widthh: 180,
                  icon: Icons.arrow_forward,
                  heightt: 60,
                  paddingg: 6,
                  ontap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  },
                )
                // ClickableText(
                //     text: "Login Now",
                //     onPressed: () {
                //       Navigator.push(
                //           context,
                //           CupertinoPageRoute(
                //               builder: (context) => const LoginScreen()));
                //     }),
                // SizedBox(
                //   width: size.width * 0.04,
                // ),
                // const Icon(
                //   Icons.arrow_forward,
                //   color: Color(0xFFF1D970),
                // )
              ],
            )
          ],
        ),
      ),
    );
  }
}
