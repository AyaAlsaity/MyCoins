import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/dark_theme_provider.dart';
import 'consts.dart';

setLang(String landCode) async {
  SharedPreferences langStorage = await SharedPreferences.getInstance();
  await langStorage.setString('langCode', landCode);
}



Future<void> errorDialog(
    {required String errormessage,
    required BuildContext context,
   
    required Color backgrounColor,
    required image}) async {
  await showDialog(
      context: context,
      builder: (context) {
        final themeFunctions =
            Provider.of<DarkThemeProvider>(context, listen: true);
        return Dialog(
          backgroundColor: themeFunctions.isDark
              ? darkBackroundContinarColor
              : secondeyTextColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                SizedBox(
                  height: 260,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                    child: Column(
                        // crossAxisAlignment:
                        // CrossAxisAlignment.center,
                        children: [
                          Text(
                            "title",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: themeFunctions.isDark
                                    ? darktitleColor
                                    : mainTextColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          const SizedBox(
                            height: sizedBoxSameComponents,
                          ),
                          Text(
                            errormessage,
                            // " We just sent an link to your registered email address ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: themeFunctions.isDark
                                    ? darktitleColor
                                    : mainTextColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                          ),
                          const SizedBox(
                            height: sizedBoxNotSameComponents,
                          ),
                          // MainButton(
                          //     text: btnText,
                          //     // "login ",
                          //     onPressed: () {
                          //       onpress;
                          //     })
                        ]),
                  ),
                ),
                Positioned(
                  top: -60,
                  child: CircleAvatar(
                    backgroundColor: mainColor,
                    radius: 60,
                    child: image,
                  ),
                )
              ]),
        );
      });
}
