
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import '../screen/sub_screens/sign_in_screen.dart';

// class AuthScreen extends StatelessWidget {
//   const AuthScreen({super.key});
  
//   Future<FirebaseApp> _initializeFirebase() async {
//     FirebaseApp firebaseApp=await Firebase.initializeApp();
//     return firebaseApp;
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:FutureBuilder(
//         future: _initializeFirebase(),
//         builder: ((context, snapshot) {
//         if(snapshot.connectionState==ConnectionState.done){
//           return const LogInScreen();
//         }else{
//           return const Center(child: Text('error'),);
//         }
//         // return const Center(
//         //   child: CircularProgressIndicator(),
//         // );
//       }),)
      
//     );
//   }
// }