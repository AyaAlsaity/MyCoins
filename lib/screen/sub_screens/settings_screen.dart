import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../helpers/consts.dart';
import '../../main.dart';
import '../../providers/dark_theme_provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingState();
}

class _SettingState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
     final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);
    return Scaffold(
        appBar: AppBar(
        ),
        body: Container(
          padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
          child: ListView(
            children: [
              Text(
                AppLocalizations.of(context)!.settings,
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: mainColor),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Icon(
                    Icons.person,
                    color: mainColor,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(AppLocalizations.of(context)!.account,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                           color:
                          themeListener.isDark ? darktitleColor : mainTextColor,)),
                ],
              ),
              const Divider(
                height: 15,
                thickness: 2,
                color: greyColor,
              ),
              const SizedBox(
                height: 10,
              ),
              SettingsRowButton(
                title: AppLocalizations.of(context)!.resttitl1,
              ),
              SettingsRowButton(
                title: AppLocalizations.of(context)!.edityc,
              ),
             
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Icon(Icons.volume_up_outlined,
                      color: mainColor.withOpacity(.5)),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(AppLocalizations.of(context)!.notification,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                           color:
                          themeListener.isDark ? darktitleColor : mainTextColor,)),
                ],
              ),
              const Divider(
                height: 15,
                thickness: 2,
                color: greyColor,
              ),
              const SizedBox(
                height: 10,
              ),
              
              buildNotificationsOptionRow(
                  AppLocalizations.of(context)!.activte, true),

              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ));
  }

  // Padding buildAccountOptionRow(BuildContext context, String title) {
  //   // bool isChecked = false;
  //   // List<String> item = ["Male ", "Female "];
  //   // String currentitem =
  //   //     " ${AppLocalizations.of(context)!.lag}   (${AppLocalizations.of(context)!.localeName == 'en' ? (AppLocalizations.of(context)!.lanen) : (AppLocalizations.of(context)!.lanar)})";

  //   // void handleChange(String? value) {
  //   //   setState(() {
  //   //     currentitem = value!;
  //   //   });
  //   // }

  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 8.0),
  //     child: GestureDetector(
  //       onTap: () {
  //         PopupMenuButton(
  //           child: const Text('Some Button'),
  //           itemBuilder: (_) => [
  //             const PopupMenuItem(
  //               value: 'item1',
  //               child: Text('Item1'),
  //             ),
  //             const PopupMenuItem(value: 'item2', child: Text('Item2')),
  //           ],
  //           onSelected: (value) => Navigator.of(context).pushNamed(value),
  //         );
  //       },
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Text(
  //             title,
  //             style: TextStyle(
  //                 fontSize: 18,
  //                 fontWeight: FontWeight.w500,
  //                 color: Colors.grey[400]),
  //           ),
  //           const Icon(
  //             Icons.arrow_forward_ios,
  //             color: mainColor,
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Row buildNotificationsOptionRow(String title, bool isActive,) {
     final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
               color:
                          themeListener.isDark ? darktitleColor : mainTextColor,),
        ),
        Switch(
            value: isActive, onChanged: (bool val) {}, activeColor: mainColor)
      ],
    );
  }
}

class SettingsRowButton extends StatelessWidget {
  const SettingsRowButton({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
     final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                 color:
                          themeListener.isDark ? darktitleColor : mainTextColor,),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: mainColor,
          )
        ],
      ),
    );
  }
}

// void showLenguageSelectionDialog(BuildContext context, String currentLenguage) {
//   showDialog(
//     context: context,
//     builder: (_) => AlertDialog(
//       title: Text(AppLocalizations.of(context)!.lag),
//       content: SizedBox(
//         height: 100,
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Radio<String>(
//                   value: currentLenguage,
//                   groupValue: AppLocalizations.of(context)!.lanen,
//                   onChanged: (value) async {
//                     AppLocalizations.of(context)!.localeName == 'en'
//                         ? MyApp.setLocale(context, const Locale('ar'))
//                         : MyApp.setLocale(context, const Locale('en'));

//                     Navigator.pop(context);
//                   },
//                 ),
//                 Text(
//                   AppLocalizations.of(context)!.lanen,
//                   style: const TextStyle(fontSize: 18),
//                 )
//               ],
//             ),
//             Row(
//               children: [
//                 Radio<String>(
//                   value: currentLenguage,
//                   groupValue: AppLocalizations.of(context)!.lanar,
//                   onChanged: (value) async {
//                     AppLocalizations.of(context)!.localeName == 'en'
//                         ? MyApp.setLocale(context, const Locale('ar'))
//                         : MyApp.setLocale(context, const Locale('en'));
//                     Navigator.pop(context);
//                   },
//                 ),
//                 Text(
//                   AppLocalizations.of(context)!.lanar,
//                   style: const TextStyle(fontSize: 18),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
