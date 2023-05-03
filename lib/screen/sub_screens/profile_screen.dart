// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:mycoins/screen/sub_screens/settings_screen.dart';
// import 'package:mycoins/widgets/clickable_widgets/button_with_icon.dart';
// import 'package:provider/provider.dart';

// import '../../helpers/consts.dart';
// import '../../providers/dark_theme_provider.dart';
// import '../auth_screens/sign_in_screen.dart';
// import 'infoApp_screen.dart';

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);
//     FirebaseAuth auth = FirebaseAuth.instance;
//     return Scaffold(
//       appBar: AppBar(
//         systemOverlayStyle: const SystemUiOverlayStyle(
//           statusBarColor: darkBackroundScreenColor,
//         ),
//       ),
//       body: Column(
//         children: [
//           Container(
//             height: 280,
//             width: 500,
//             decoration: BoxDecoration(
//                 boxShadow: [
//                   BoxShadow(
//                       color: mainColor.withOpacity(0.5),
//                       offset: const Offset(1.0, 1.0),
//                       blurRadius: 15.0,
//                       spreadRadius: 1.0)
//                 ],
//                 color: themeListener.isDark
//                     ? darkBackroundContinarColor
//                     : secondeyTextColor,
//                 borderRadius: const BorderRadius.only(
//                   bottomRight: Radius.circular(30),
//                   bottomLeft: Radius.circular(30),
//                 )),
//             child: Column(
//               children: [
//                 const SizedBox(
//                   height: sizedBoxNotSameComponents + 5,
//                 ),
//                 Center(
//                   child: SizedBox(
//                     height: 130,
//                     width: 140,
//                     child: Image.asset("assets/images/woman.png"
//                         // 'images/woman.png',
//                         ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: sizedBoxNotSameComponents + 5,
//                 ),
//                 Text("Areej Elbarassi",
//                     style: TextStyle(
//                       fontSize: 30,
//                       fontWeight: FontWeight.w600,
//                       color:
//                           themeListener.isDark ? darktitleColor : mainTextColor,
//                     )),
//                 const SizedBox(
//                   height: sizedBoxSameComponents,
//                 ),
//                 Text(
//                   "areej.elbarassi@gmail.com",
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.w400,
//                     color:
//                         themeListener.isDark ? darktitleColor : mainTextColor,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(
//             height: sizedBoxNotSameComponents + 20,
//           ),
//           GestureDetector(
//             onTap: () {
//               print("object");
//               Navigator.push(context, MaterialPageRoute(builder: (context) {
//                 return const SettingScreen();
//               }));
//             },
//             child: const ButtonWithIcon(
//               icon: Icons.settings,
//               text: 'Settings',
//               height: 50,
//               width: 300,
//               withborder: false,
//             ),
//           ),
//           const SizedBox(
//             height: sizedBoxSameComponents + 5,
//           ),
//           GestureDetector(
//             onTap: () {
//               Navigator.push(
//                   context,
//                   CupertinoPageRoute(
//                       builder: (context) => const InfoAppScreen()));
//             },
//             child: const ButtonWithIcon(
//               icon: Icons.help,
//               text: 'Help & Support',
//               height: 50,
//               width: 300,
//               withborder: false,
//             ),
//           ),
//           const SizedBox(
//             height: sizedBoxSameComponents + 20,
//           ),
//           GestureDetector(
//             onTap: () async {
//               auth.signOut();
//               Navigator.pushAndRemoveUntil(
//                   context,
//                   CupertinoPageRoute(
//                       builder: ((context) => const LoginScreen())),
//                   (route) => false);
//             },
//             child: const ButtonWithIcon(
//               icon: Icons.logout,
//               text: 'LogOut',
//               height: 50,
//               width: 300,
//               withborder: true,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
