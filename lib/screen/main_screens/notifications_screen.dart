import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mycoins/helpers/consts.dart';
import '../../providers/dark_theme_provider.dart';
import '../../widgets/clickable_widgets/notification_tiles.dart';
import '../../widgets/static_widgets/appBar_widget.dart';
import '../../widgets/static_widgets/drawer_widgets/custom_drawer.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({
    Key? key,

  }) : super(key: key);


  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {

  String notificationTitle = 'My Coins';
  String notificationBody = 'Thanks for download my coins app.';
  

  @override
  void initState() {
    final firebaseMessaging = FCM();
    firebaseMessaging.setNotifications();

    firebaseMessaging.bodyCtlr.stream.listen(_changeBody);
    firebaseMessaging.titleCtlr.stream.listen(_changeTitle);

    super.initState();
  }

  _changeBody(String msg) => setState(() => notificationBody = msg);
  _changeTitle(String msg) => setState(() => notificationTitle = msg);

  @override
  Widget build(BuildContext context) {
    final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBarWidget(context),
      
      drawer: const CustomDrawer(),

      body: RefreshIndicator(
        color: mainColor,
        backgroundColor: themeListener.isDark
            ? darkBackroundContinarColor
            : secondeyTextColor,
        onRefresh: () async {
          initState();
        },
        child: ListView.separated(
            physics: const ClampingScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: 12,
            itemBuilder: (context, index) {
              return NotificationTiles(
                title: notificationTitle,
                subtitle:  notificationBody,
                enable: true,
                ontap: () {},
                key: null,
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            }),
      ),
    );
  }
}

Future<void> onBackgroundMessage(RemoteMessage message) async {
  await Firebase.initializeApp();

  if (message.data.containsKey('data')) {
    // Handle data message
    final data = message.data['data'];
  }

  if (message.data.containsKey('notification')) {
    // Handle notification message
    final notification = message.data['notification'];
  }
  // Or do other work.
}

class FCM {
  final _firebaseMessaging = FirebaseMessaging.instance;

  final streamCtlr = StreamController<String>.broadcast();
  final titleCtlr = StreamController<String>.broadcast();
  final bodyCtlr = StreamController<String>.broadcast();

  setNotifications() {
    FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);

    // handle when app in active state
    forgroundNotification();

    // handle when app running in background state
    backgroundNotification();

    // handle when app completely closed by the user
    terminateNotification();

    // dispose();

    // With this token you can test it easily on your phone
    final token =
        _firebaseMessaging.getToken().then((value) => print('Token: $value'));
  }

  forgroundNotification() {
    FirebaseMessaging.onMessage.listen(
      (message) async {
        if (message.data.containsKey('data')) {
          // Handle data message
          streamCtlr.sink.add(message.data['data']);
        }
        if (message.data.containsKey('notification')) {
          // Handle notification message
          streamCtlr.sink.add(message.data['notification']);
        }
        // Or do other work.
        titleCtlr.sink.add(message.notification!.title!);
        bodyCtlr.sink.add(message.notification!.body!);
      },
    );
  }

  backgroundNotification() {
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) async {
        if (message.data.containsKey('data')) {
          // Handle data message
          streamCtlr.sink.add(message.data['data']);
        }
        if (message.data.containsKey('notification')) {
          // Handle notification message
          streamCtlr.sink.add(message.data['notification']);
        }
        // Or do other work.
        titleCtlr.sink.add(message.notification!.title!);
        bodyCtlr.sink.add(message.notification!.body!);
      },
    );
  }

  terminateNotification() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      if (initialMessage.data.containsKey('data')) {
        // Handle data message
        streamCtlr.sink.add(initialMessage.data['data']);
      }
      if (initialMessage.data.containsKey('notification')) {
        // Handle notification message
        streamCtlr.sink.add(initialMessage.data['notification']);
      }
      // Or do other work.
      titleCtlr.sink.add(initialMessage.notification!.title!);
      bodyCtlr.sink.add(initialMessage.notification!.body!);
    }
  }

  dispose() {
    streamCtlr.close();
    bodyCtlr.close();
    titleCtlr.close();
  }
}




// class NotificationDetails extends StatefulWidget {
//   const NotificationDetails({super.key});

//   @override
//   State<NotificationDetails> createState() => _NotificationDetailsState();
// }

// class _NotificationDetailsState extends State<NotificationDetails> {
//   @override
//   Widget build(BuildContext context) {
//     final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);

//     return Scaffold(
//       appBar: AppBar(
//       ),
//       body: FittedBox(
//         child: Container(
//           // height: MediaQuery.of(context).size.height,
//           width: MediaQuery.of(context).size.width,
//           margin: const EdgeInsets.all(16.0),
//           padding: const EdgeInsets.all(16.0),
//           decoration: BoxDecoration(
//             //    color: themeListener.isDark ? greyTextColor : greyColor,
//             shape: BoxShape.rectangle,
//             borderRadius: BorderRadius.circular(8.0),
//           ),
//           child: Column(
//             children: [
//               Text(
//                   'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
//                   style: TextStyle(
//                     fontSize: 20.0,
//                     color: themeListener.isDark
//                         ? secondeyTextColor
//                         : Colors.black87,
//                   )),
//               const SizedBox(height: 16.0),
//               Image.asset("assets/images/logo2.png"),
//               const SizedBox(height: 16.0),
//               Text(
//                   "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
//                   style: TextStyle(
//                     color: themeListener.isDark
//                         ? secondeyTextColor
//                         : Colors.black87,
//                   )),
//               const SizedBox(height: 16.0),
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: Text('1/May/2021 10:01 PM',
//                     style: TextStyle(
//                       color: themeListener.isDark
//                           ? secondeyTextColor
//                           : Colors.black87,
//                     )),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
