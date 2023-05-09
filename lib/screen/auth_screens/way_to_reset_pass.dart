import 'package:flutter/material.dart';


class WayToresetPassword extends StatefulWidget {
  const WayToresetPassword({super.key});

  @override
  State<WayToresetPassword> createState() => _WayToresetPasswordState();
}

class _WayToresetPasswordState extends State<WayToresetPassword> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // systemOverlayStyle: const SystemUiOverlayStyle(
        //   statusBarColor: darkBackroundScreenColor,
        // ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Column(
              children: const [
                Text(
                  'Password Forgot',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Choose how you want to Forgot your password!  ",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.185,
            ),
            // ShadoButton(
            //   text: "Continue with Email",
            //   icon: Icons.mail,
            //   onPressed: () {
            //     Navigator.push(
            //         context,
            //         CupertinoPageRoute(
            //             builder: (context) => const ResetPasswordScreen()));
            //   },
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
            // ShadoButton(
            //   text: "Continue with Phone",
            //   icon: Icons.phone,
            //   onPressed: () {},
            // ),
          ],
        ),
      ),
    );
  }
}
